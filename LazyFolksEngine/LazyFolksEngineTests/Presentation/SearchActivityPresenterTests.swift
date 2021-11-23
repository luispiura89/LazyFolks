//
//  SearchActivityPresenterTests.swift
//  LazyFolksEngineTests
//
//  Created by Luis Francisco Piura Mejia on 23/11/21.
//

import Foundation
import LazyFolksEngine
import XCTest

final class SearchActivityPresenterTests: XCTestCase {
    
    func test_presenter_shouldLocalizeTitleAndPlaceholders() {
        XCTAssertEqual(SearchActivityPresenter.title, localized("SEARCH_ACTIVITY_VIEW_TITLE"))
        XCTAssertEqual(SearchActivityPresenter.subtitle, localized("SEARCH_ACTIVITY_VIEW_SUBTITLE"))
        XCTAssertEqual(SearchActivityPresenter.typePlaceholder, localized("SEARCH_ACTIVITY_TYPE_PLACEHOLDER"))
        XCTAssertEqual(SearchActivityPresenter.participantsPlaceholder, localized("SEARCH_ACTIVITY_PARTICIPANTS_PLACEHOLDER"))
        XCTAssertEqual(SearchActivityPresenter.minPricePlaceholder, localized("SEARCH_ACTIVITY_MIN_PRICE_PLACEHOLDER"))
        XCTAssertEqual(SearchActivityPresenter.maxPricePlaceholder, localized("SEARCH_ACTIVITY_MAX_PRICE_PLACEHOLDER"))
    }
    
    func test_presenter_shouldTellTheViewToLoadWhenSearchStarts() {
        let (presenter, viewSpy) = makeSUT()
        
        presenter.startSearchingActivity()
        
        XCTAssertEqual(viewSpy.messages, [.loading(true), .failure(nil)])
    }
    
    func test_presenter_shouldTellTheViewToDisplayNotFoundActivityErrorOnError() {
        let (presenter, viewSpy) = makeSUT()
        
        presenter.didFinishLoading(with: ActivitiesMapper.Error.noActivityWasFound)
        
        XCTAssertEqual(viewSpy.messages, [.loading(false), .failure(localized("NO_ACTIVITY_FOUND_ERROR_MESSAGE"))])
    }
    
    func test_presenter_shouldTellTheViewToDisplayGeneralErrorOnError() {
        let (presenter, viewSpy) = makeSUT()
        
        presenter.didFinishLoading(with: anyNSError())
        
        XCTAssertEqual(viewSpy.messages, [.loading(false), .failure(localized("GENERAL_LOADING_ERROR_MESSAGE"))])
    }
    
    func test_presenter_shouldTellTheViewToDisplayAnActivityOnSuccessfulLoading() {
        let activity = Activity(description: "A description", type: "A type", participants: 1, price: 0.2)
        let (presenter, viewSpy) = makeSUT()
        
        presenter.didFinishLoading(with: activity)
        
        XCTAssertEqual(viewSpy.messages, [.loading(false), .success(activity)])
    }
    
    // MARK: - Helpers
    
    private func makeSUT(file: StaticString = #filePath, line: UInt = #line) -> (SearchActivityPresenter, ViewSpy) {
        let viewSpy = ViewSpy()
        let presenter = SearchActivityPresenter(loadingView: viewSpy, errorView: viewSpy, searchView: viewSpy)
        
        trackMemoryLeaks(viewSpy, file: file, line: line)
        trackMemoryLeaks(presenter, file: file, line: line)
        
        return (presenter, viewSpy)
    }
    
    private func localized(_ key: String, file: StaticString = #filePath, line: UInt = #line) -> String {
        let bundle = Bundle(for: SearchActivityPresenter.self)
        let localized = bundle.localizedString(forKey: key, value: nil, table: "SearchActivity")
        if localized == key {
            XCTFail("Please provide a localization for the key \(key)", file: file, line: line)
        }
        return localized
    }
    
    private final class ViewSpy: LoadingView, ErrorView, SearchView {
        
        enum Message: Hashable {
            case loading(Bool)
            case failure(String?)
            case success(Activity)
        }
        
        private(set) var messages = Set<Message>()
        
        
        func didLoadingStateChanged(_ data: LoadingViewData) {
            messages.insert(.loading(data.isLoading))
        }
        
        
        func displayErrorMessage(_ data: ErrorViewData) {
            messages.insert(.failure(data.errorMessage))
        }
        
        func didLoad(_ data: SearchActivityViewData) {
            messages.insert(.success(data.activity))
        }
    }
}
