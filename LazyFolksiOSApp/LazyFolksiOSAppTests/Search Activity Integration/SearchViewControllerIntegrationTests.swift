//
//  SearchViewControllerIntegrationTests.swift
//  LazyFolksiOSAppTests
//
//  Created by Luis Francisco Piura Mejia on 23/11/21.
//

import Foundation
import LazyFolksiOS
import LazyFolksiOSApp
import LazyFolksEngine
import XCTest

final class SearchViewControllerIntegrationTests: XCTestCase {
    
    func test_searchView_hasTitleAndPlaceholders() {
        let sut = makeSUT()
        let table = "SearchActivity"
        let bundle = Bundle(for: SearchActivityPresenter.self)
        
        sut.loadViewIfNeeded()
        
        XCTAssertEqual(sut.header, localized("SEARCH_ACTIVITY_VIEW_TITLE", table: table, bundle: bundle))
        XCTAssertEqual(sut.subtitle, localized("SEARCH_ACTIVITY_VIEW_SUBTITLE", table: table, bundle: bundle))
        XCTAssertEqual(sut.typePlaceholder, localized("SEARCH_ACTIVITY_TYPE_PLACEHOLDER", table: table, bundle: bundle))
        XCTAssertEqual(sut.participantsPlaceholder, localized("SEARCH_ACTIVITY_PARTICIPANTS_PLACEHOLDER", table: table, bundle: bundle))
        XCTAssertEqual(sut.minPricePlaceholder, localized("SEARCH_ACTIVITY_MIN_PRICE_PLACEHOLDER", table: table, bundle: bundle))
        XCTAssertEqual(sut.maxPricePlaceholder, localized("SEARCH_ACTIVITY_MAX_PRICE_PLACEHOLDER", table: table, bundle: bundle))
    }
    
    // MARK: - Helpers
    
    private func makeSUT() -> SearchActivityViewController {
        let search = SearchViewComposer.compose(windowBounds: .zero)
        
        return search
    }
    
    private func localized(_ key: String, table: String, bundle: Bundle) -> String {
        bundle.localizedString(forKey: key, value: nil, table: table)
    }
    
}

extension SearchActivityViewController {
    
    var header: String? {
        searchView?.title
    }
    
    var subtitle: String? {
        searchView?.subtitle
    }
    
    var typePlaceholder: String? {
        searchView?.typePlaceholder
    }
    
    var participantsPlaceholder: String? {
        searchView?.participantsPlaceholder
    }
    
    var minPricePlaceholder: String? {
        searchView?.minPricePlaceholder
    }
    
    var maxPricePlaceholder: String? {
        searchView?.maxPricePlaceholder
    }
    
}
