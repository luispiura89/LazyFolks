//
//  SearchViewControllerSnapshotTests.swift
//  LazyFolksiOSTests
//
//  Created by Luis Francisco Piura Mejia on 22/11/21.
//

import XCTest
import LazyFolksiOS
import LazyFolksEngine

final class SearchViewControllerSnapshotTests: XCTestCase {
    
    func test_search_shouldRenderInitialState() {
        let sut = makeSUT()
        
        assert(snapshot: sut.snapshot(for: .iPhone13(style: .light)), named: "SEARCH_VIEW_light")
        assert(snapshot: sut.snapshot(for: .iPhone13(style: .dark)), named: "SEARCH_VIEW_dark")
    }
    
    func test_search_shouldLoad() {
        let sut = makeSUT()
        
        sut.didStartLoading()
        sut.fillData()
        
        assert(snapshot: sut.snapshot(for: .iPhone13(style: .light)), named: "SEARCH_VIEW_LOADING_light")
        assert(snapshot: sut.snapshot(for: .iPhone13(style: .dark)), named: "SEARCH_VIEW_LOADING_dark")
    }
    
    func test_search_rendersError() {
        let sut = makeSUT()
        
        sut.didFinishLoadWithError(message: "This is a long\nerror message")
        sut.fillData()
        
        assert(snapshot: sut.snapshot(for: .iPhone13(style: .light)), named: "SEARCH_VIEW_LOADING_ERROR_light")
        assert(snapshot: sut.snapshot(for: .iPhone13(style: .dark)), named: "SEARCH_VIEW_LOADING_ERROR_dark")
    }
    
    // MARK: - Helpers
    
    private func makeSUT() -> SearchActivityViewController {
        let bounds = SnapshotConfiguration.iPhone13(style: .light).frame
        let searchView = SearchActivityView(
            bounds: bounds,
            title: "A title",
            subtitle: "A subtitle",
            typePlaceholder: "type",
            participantsPlaceholder: "participants",
            minPricePlaceholder: "min price",
            maxPricePlaceholder: "max price")
        let searchController =  SearchActivityViewController(searchView: searchView, bounds: bounds, delegate: nil)
        searchController.loadViewIfNeeded()
        return searchController
    }
}

extension SearchActivityViewController {
    func didFinishLoadWithError(message: String?) {
        displayErrorMessage(ErrorViewData(errorMessage: message))
    }
    
    func didStartLoading() {
        didLoadingStateChanged(LoadingViewData(isLoading: true))
    }
    
    func fillData() {
        updateInputedData(values: ("Type", "2", "0.2", "0.5"))
    }
}
