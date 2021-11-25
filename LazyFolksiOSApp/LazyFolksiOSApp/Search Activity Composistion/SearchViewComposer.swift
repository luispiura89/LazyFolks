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

/// This factory class is in charge of create an instance of `SearchActivityViewController` with all its dependencies

public final class SearchViewComposer {
    private init() {}
    
    static public func compose(
        windowBounds: CGRect,
        loader:  @escaping SearchActivityLoader,
        navigationHandler: @escaping (Activity) -> Void
    ) -> SearchActivityViewController {
        let presentationAdapter = SearchActivityPresentationAdapter(loader: loader)
        let delegate = SearchActivityValidator()
        let view = makeView(bounds: windowBounds)
        let search = SearchActivityViewController(
            searchView: view,
            searchController: SearchActivityController(
                searchHandler: { [presentationAdapter] (type, participants, minPrice, maxPrice) in
                    presentationAdapter.searchActivity(type: type, participants: participants, minPrice: minPrice, maxPrice: maxPrice) },
                isSearching: { [weak view] in view?.searchButton.isLoading == true }
            ),
            delegate: delegate
        )
        let searchView = SearchViewAdapter(controller: search, navigationHandler: navigationHandler)
        let loadingView = WeakRefProxy(reference: search)
        let errorView = WeakRefProxy(reference: search)
        let presenter = SearchActivityPresenter(loadingView: loadingView, errorView: errorView, searchView: searchView)
        presentationAdapter.presenter = presenter
        delegate.presenter = presenter
        
        return search
    }
    
    static private func makeView(bounds: CGRect) -> SearchActivityView {
        SearchActivityView(
            bounds: bounds,
            title: SearchActivityPresenter.title,
            subtitle: SearchActivityPresenter.subtitle,
            typePlaceholder: SearchActivityPresenter.typePlaceholder,
            participantsPlaceholder: SearchActivityPresenter.participantsPlaceholder,
            minPricePlaceholder: SearchActivityPresenter.minPricePlaceholder,
            maxPricePlaceholder: SearchActivityPresenter.maxPricePlaceholder,
            searchButtonTitle: SearchActivityPresenter.searchButtonTitle
        )
    }
}
