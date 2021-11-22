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
        
        record(snapshot: sut.snapshot(for: .iPhone13(style: .light)), named: "SEARCH_VIEW_light")
        record(snapshot: sut.snapshot(for: .iPhone13(style: .dark)), named: "SEARCH_VIEW_dark")
    }
    
    // MARK: - Helpers
    
    private func makeSUT() -> SearchActivityViewController {
        let frame = SnapshotConfiguration.iPhone13(style: .light).frame
        let searchController =  SearchActivityViewController(snapshotFrame: frame)
        searchController.loadViewIfNeeded()
        return searchController
    }
    
}
