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

public typealias SearchActivityLoader = (String, String, String, String) -> AnyPublisher<Activity, Error>

public final class SearchViewComposer {
    private init() {}
    
    static public func compose(
        windowBounds: CGRect,
        loader:  @escaping SearchActivityLoader = { _, _, _, _ in Empty<Activity, Error>().eraseToAnyPublisher() }
    ) -> SearchActivityViewController {
        let presentationAdapter = SearchActivityPresentationAdapter(loader: loader)
        let delegate = SearchActivityValidator()
        let view = makeView()
        let search = SearchActivityViewController(
            searchView: view,
            bounds: windowBounds,
            searchController: SearchActivityController(
                searchHandler: { [presentationAdapter] (type, participants, minPrice, maxPrice) in
                    presentationAdapter.searchActivity(type: type, participants: participants, minPrice: minPrice, maxPrice: maxPrice) },
                isSearching: { [weak view] in view?.searchButton.isLoading == true }
            ),
            delegate: delegate
        )
        let searchView = SearchViewAdapter(controller: search)
        let loadingView = WeakRefProxy(reference: search)
        let errorView = WeakRefProxy(reference: search)
        let presenter = SearchActivityPresenter(loadingView: loadingView, errorView: errorView, searchView: searchView)
        presentationAdapter.presenter = presenter
        delegate.presenter = presenter
        
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
}
