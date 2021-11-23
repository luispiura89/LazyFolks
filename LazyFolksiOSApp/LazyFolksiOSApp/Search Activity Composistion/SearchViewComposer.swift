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
        let searchView = SearchViewAdapter(controller: search)
        let loadingView = WeakRefProxy(reference: search)
        let errorView = WeakRefProxy(reference: search)
        presentationAdapter.presenter = SearchActivityPresenter(loadingView: loadingView, errorView: errorView, searchView: searchView)
        
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
    
    private final class SearchViewAdapter: SearchView {
        
        private weak var controller: SearchActivityViewController?
        
        init(controller: SearchActivityViewController) {
            self.controller = controller
        }
        
        func didLoad(_ data: SearchActivityViewData) {}
    }
    
    private final class SearchActivityPresentationAdapter {
        private let loader: SearchActivityLoader
        private var cancellable: AnyCancellable?
        var presenter: SearchActivityPresenter?
        
        init(loader: @escaping SearchActivityLoader) {
            self.loader = loader
        }
        
        func searchActivity(type: String, participants: Int, minPrice: Double, maxPrice: Double) {
            presenter?.startSearchingActivity()
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

private final class WeakRefProxy<T: AnyObject> {
    
    private weak var reference: T?
    
    init(reference: T) {
        self.reference = reference
    }
}

extension WeakRefProxy: LoadingView where T: LoadingView {
    func didLoadingStateChanged(_ data: LoadingViewData) {
        reference?.didLoadingStateChanged(data)
    }
}

extension WeakRefProxy: LoadingErrorView where T: LoadingErrorView {
    func displayErrorMessage(_ data: ErrorViewData) {
        reference?.displayErrorMessage(data)
    }
}
