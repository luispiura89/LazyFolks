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
        
        XCTAssertEqual(sut.header, SearchActivityPresenter.title)
        XCTAssertEqual(sut.subtitle, SearchActivityPresenter.subtitle)
        XCTAssertEqual(sut.typePlaceholder, SearchActivityPresenter.typePlaceholder)
        XCTAssertEqual(sut.participantsPlaceholder, SearchActivityPresenter.participantsPlaceholder)
        XCTAssertEqual(sut.minPricePlaceholder, SearchActivityPresenter.minPricePlaceholder)
        XCTAssertEqual(sut.maxPricePlaceholder, SearchActivityPresenter.maxPricePlaceholder)
    }
    
    func test_searchView_shouldRequestSearchActivity() {
        let (sut, loaderSpy) = makeSUT()
        
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
    
    func test_searchView_shouldEnableSearchButtonWhenUserHasFilledAllTheData() {
        let (sut, _) = makeSUT(withFilledData: false)
        
        XCTAssertFalse(sut.canSendSearchRequest, "Search button should be disabled")
        
        sut.simulateUserFilledData()
        XCTAssertTrue(sut.canSendSearchRequest, "Search button should be enabled")
    }
    
    func test_searchView_shouldDisplayAnErrorWhenThereIsAnError() {
        let (sut, loader) = makeSUT()
        
        sut.simulateUserRequestedActivitySearch()
        XCTAssertFalse(sut.isShowingErrorMessage, "Should show error view until there's an error")
        
        loader.simulateLoadingCompletionWithError(at: 0)
        XCTAssertTrue(sut.isShowingErrorMessage, "Should be showing error message")
        
        sut.simulateUserRequestedActivitySearch()
        XCTAssertFalse(sut.isShowingErrorMessage, "Should show error view until there's an error")
        
        loader.simulateLoadingCompletionSuccessfully(at: 1)
        XCTAssertFalse(sut.isShowingErrorMessage, "Should show error view until there's an error")
    }
    
    func test_searchView_shouldDisplayActivityScreenWhenItFindsAnActivity() {
        var expectedActivity: Activity?
        let (sut, loader) = makeSUT { expectedActivity = $0 }
        let activity = makeActivity()
        
        sut.simulateUserFilledData()
        sut.simulateUserRequestedActivitySearch()
        loader.simulateLoadingCompletionSuccessfully(with: activity, at: 0)
        
        XCTAssertEqual(activity, expectedActivity)
    }
    
    // MARK: - Helpers
    
    private func makeSUT(
        withFilledData fillData: Bool = true,
        navigationHandler: @escaping (Activity) -> Void = { _ in },
        file: StaticString = #filePath,
        line: UInt = #line
    ) -> (SearchActivityViewController, LoaderSpy) {
        let loaderSpy = LoaderSpy()
        let search = SearchViewComposer.compose(
            windowBounds: .zero,
            loader: loaderSpy.loaderPublisher,
            navigationHandler: navigationHandler
        )
        
        trackMemoryLeaks(search, file: file, line: line)
        trackMemoryLeaks(loaderSpy, file: file, line: line)
        
        search.loadViewIfNeeded()
        if fillData {
            search.simulateUserFilledData()
        }
        
        return (search, loaderSpy)
    }
    
    private func makeActivity() -> Activity {
        Activity(description: "any description", type: "any type", participants: 10, price: 0.5)
    }
    
    private final class LoaderSpy {
        
        var searchActivityCallCount: Int {
            requests.count
        }
        
        private var requests = [PassthroughSubject<Activity, Error>]()
        
        func loaderPublisher(type: String, participants: String, minPrice: String, maxPrice: String) -> AnyPublisher<Activity, Error> {
            let publisher = PassthroughSubject<Activity, Error>()
            requests.append(publisher)
            return publisher.eraseToAnyPublisher()
        }
        
        func simulateLoadingCompletionSuccessfully(with activity: Activity? = nil, at index: Int) {
            guard requests.count > index else { return }
            requests[index].send( activity ?? Activity(description: "any description", type: "any type", participants: 10, price: 0.5))
        }
        
        func simulateLoadingCompletionWithError(at index: Int) {
            guard requests.count > index else { return }
            requests[index].send(completion: .failure(NSError(domain: "Any error", code: -1, userInfo: nil)))
        }
    }
}
