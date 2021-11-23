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
        
        loaderSpy.simulateLoadingCompletionWithError(at: 0)
        sut.simulateUserRequestedActivitySearch()
        XCTAssertEqual(loaderSpy.searchActivityCallCount, 2, "Should had requested activity search after failure and retry")
        
        loaderSpy.simulateLoadingCompletionSuccessfully(at: 1)
        sut.simulateUserRequestedActivitySearch()
        XCTAssertEqual(loaderSpy.searchActivityCallCount, 3, "Should had requested activity search after successful search")
    }
    
    func test_searchView_shouldShowLoadingIndicator() {
        let (sut, loaderSpy) = makeSUT()
        
        sut.loadViewIfNeeded()
        
        sut.simulateUserRequestedActivitySearch()
        XCTAssertTrue(sut.isShowingLoadingIndicator, "Should be showing loader after first request")
        
        sut.simulateUserRequestedActivitySearch()
        XCTAssertTrue(sut.isShowingLoadingIndicator, "Should continue showing loading indicator")
        
        loaderSpy.simulateLoadingCompletionWithError(at: 0)
        XCTAssertFalse(sut.isShowingLoadingIndicator, "Shouldn't be showing loading after request failure")
        sut.simulateUserRequestedActivitySearch()
        XCTAssertTrue(sut.isShowingLoadingIndicator, "Should show loading after retry")
        
        loaderSpy.simulateLoadingCompletionSuccessfully(at: 1)
        XCTAssertFalse(sut.isShowingLoadingIndicator, "Shouldn't show load indicator after successful request")
        sut.simulateUserRequestedActivitySearch()
        XCTAssertTrue(sut.isShowingLoadingIndicator, "Should show loading indicator after retry")
    }
    
    // MARK: - Helpers
    
    private func makeSUT(file: StaticString = #filePath, line: UInt = #line) -> (SearchActivityViewController, LoaderSpy) {
        let loaderSpy = LoaderSpy()
        let search = SearchViewComposer.compose(windowBounds: .zero, loader: loaderSpy.loaderPublisher)
        
        trackMemoryLeaks(search, file: file, line: line)
        trackMemoryLeaks(loaderSpy, file: file, line: line)
        
        return (search, loaderSpy)
    }
    
    private func localized(_ key: String, table: String, bundle: Bundle) -> String {
        bundle.localizedString(forKey: key, value: nil, table: table)
    }
    
    private final class LoaderSpy {
        
        var searchActivityCallCount: Int {
            requests.count
        }
        
        private var requests = [PassthroughSubject<Activity, Error>]()
        
        func loaderPublisher(type: String, participants: Int, minPrice: Double, maxPrice: Double) -> AnyPublisher<Activity, Error> {
            let publisher = PassthroughSubject<Activity, Error>()
            requests.append(publisher)
            return publisher.eraseToAnyPublisher()
        }
        
        func simulateLoadingCompletionSuccessfully(at index: Int) {
            guard requests.count > index else { return }
            requests[index].send(Activity(description: "any description", type: "any type", participants: 10, price: 0.5))
        }
        
        func simulateLoadingCompletionWithError(at index: Int) {
            guard requests.count > index else { return }
            requests[index].send(completion: .failure(NSError(domain: "Any error", code: -1, userInfo: nil)))
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
    
    var isShowingLoadingIndicator: Bool {
        searchView?.searchButton.isLoading == true
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
