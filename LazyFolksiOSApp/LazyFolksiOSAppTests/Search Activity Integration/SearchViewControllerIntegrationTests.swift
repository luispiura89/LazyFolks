//
//  SearchViewControllerIntegrationTests.swift
//  LazyFolksiOSAppTests
//
//  Created by Luis Francisco Piura Mejia on 23/11/21.
//

import Foundation
import Combine
import LazyFolksiOS
import LazyFolksiOSApp
import LazyFolksEngine
import XCTest

final class SearchViewControllerIntegrationTests: XCTestCase {
    
    func test_searchView_hasTitleAndPlaceholders() {
        let (sut, _) = makeSUT()
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
    
    func test_searchView_shouldRequestSearchActivity() {
        let (sut, loaderSpy) = makeSUT()
        
        sut.loadViewIfNeeded()
        
        sut.simulateUserRequestedActivitySearch()
        XCTAssertEqual(loaderSpy.searchActivityCallCount, 1, "Should had requested activity search")
        
        sut.simulateUserRequestedActivitySearch()
        XCTAssertEqual(loaderSpy.searchActivityCallCount, 1, "Shouldn't request activity search while loading")
    }
    
    // MARK: - Helpers
    
    private func makeSUT() -> (SearchActivityViewController, LoaderSpy) {
        let loaderSpy = LoaderSpy()
        let search = SearchViewComposer.compose(windowBounds: .zero, loader: loaderSpy.loaderPublisher)
        
        
        
        return (search, loaderSpy)
    }
    
    private func localized(_ key: String, table: String, bundle: Bundle) -> String {
        bundle.localizedString(forKey: key, value: nil, table: table)
    }
    
    private final class LoaderSpy {
        
        private(set) var searchActivityCallCount = 0
        
        private var requests = [AnyPublisher<Activity, Error>]()
        
        func loaderPublisher(type: String, participants: Int, minPrice: Double, maxPrice: Double) -> AnyPublisher<Activity, Error> {
            searchActivityCallCount += 1
            return Empty<Activity, Error>().eraseToAnyPublisher()
        }
        
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
    
    func simulateUserRequestedActivitySearch() {
        searchView?.searchButton.simulate(event: .touchUpInside)
    }
}

private extension UIControl {
    func simulate(event: UIControl.Event) {
        allTargets.forEach { target in
            actions(forTarget: target, forControlEvent: event)?.forEach {
                (target as NSObject).perform(Selector($0))
            }
        }
    }
}
