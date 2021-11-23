//
//  SearchViewComposer.swift
//  LazyFolksiOSApp
//
//  Created by Luis Francisco Piura Mejia on 23/11/21.
//

import Combine
import LazyFolksiOS
import LazyFolksEngine
import UIKit

public typealias SearchActivityLoader = (String, Int, Double, Double) -> AnyPublisher<Activity, Error>

public final class SearchViewComposer {
    private init() {}
    
    static public func compose(
        windowBounds: CGRect,
        loader:  @escaping SearchActivityLoader = { _, _, _, _ in Empty<Activity, Error>().eraseToAnyPublisher() }
    ) -> SearchActivityViewController {
        let presentationAdapter = SearchActivityPresentationAdapter(loader: loader)
        let search = SearchActivityViewController(
            searchView: makeView(),
            bounds: windowBounds,
            searchController: SearchActivityController(searchHandler: presentationAdapter.searchActivity)
        )
        
        return search
    }
    
    static private func makeView() -> SearchActivityView {
        SearchActivityView(
            title: SearchActivityPresenter.title,
            subtitle: SearchActivityPresenter.subtitle,
            typePlaceholder: SearchActivityPresenter.typePlaceholder,
            participantsPlaceholder: SearchActivityPresenter.participantsPlaceholder,
            minPricePlaceholder: SearchActivityPresenter.minPricePlaceholder,
            maxPricePlaceholder: SearchActivityPresenter.maxPricePlaceholder
        )
    }
    
    private final class SearchActivityPresentationAdapter {
        private let loader: SearchActivityLoader
        private var cancellable: AnyCancellable?
        var presenter: SearchActivityPresenter?
        
        init(loader: @escaping SearchActivityLoader) {
            self.loader = loader
        }
        
        func searchActivity(type: String, participants: Int, minPrice: Double, maxPrice: Double) {
            cancellable = loader(type, participants, minPrice, maxPrice)
                .sink { [weak presenter] result in
                    if case let .failure(error) = result {
                        presenter?.didFinishLoading(with: error)
                    }
                } receiveValue: {  [weak presenter] activity in
                    presenter?.didFinishLoading(with: activity)
                }
        }
    }
}
