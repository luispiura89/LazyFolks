//
//  SearchViewControllerSnapshotTests.swift
//  LazyFolksiOSTests
//
//  Created by Luis Francisco Piura Mejia on 22/11/21.
//

import XCTest
import LazyFolksiOS

final class SearchViewControllerSnapshotTests: XCTestCase {
    
    func test_search_shouldRenderInitialState() {
        let sut = makeSUT()
        
        assert(snapshot: sut.snapshot(for: .iPhone13(style: .light)), named: "SEARCH_VIEW_light")
        assert(snapshot: sut.snapshot(for: .iPhone13(style: .dark)), named: "SEARCH_VIEW_dark")
    }
    
    func test_search_shouldLoad() {
        let sut = makeSUT()
        
        sut.didStartLoading(isLoading: true)
        
        assert(snapshot: sut.snapshot(for: .iPhone13(style: .light)), named: "SEARCH_VIEW_LOADING_light")
        assert(snapshot: sut.snapshot(for: .iPhone13(style: .dark)), named: "SEARCH_VIEW_LOADING_dark")
    }
    
    func test_search_rendersError() {
        let sut = makeSUT()
        
        sut.didFinishLoadWithError(message: "This is a long\nerror message")
        
        assert(snapshot: sut.snapshot(for: .iPhone13(style: .light)), named: "SEARCH_VIEW_LOADING_ERROR_light")
        assert(snapshot: sut.snapshot(for: .iPhone13(style: .dark)), named: "SEARCH_VIEW_LOADING_ERROR_dark")
    }
    
    // MARK: - Helpers
    
    private func makeSUT() -> SearchActivityViewController {
        let frame = SnapshotConfiguration.iPhone13(style: .light).frame
        let searchController =  SearchActivityViewController(snapshotFrame: frame)
        searchController.loadViewIfNeeded()
        return searchController
    }
    
}
