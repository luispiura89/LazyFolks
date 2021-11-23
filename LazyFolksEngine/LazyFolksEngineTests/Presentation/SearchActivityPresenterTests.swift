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
        let viewSpy = ViewSpy()
        let presenter = SearchActivityPresenter(loadingView: viewSpy)
        
        presenter.startSearchingActivity()
        
        XCTAssertEqual(viewSpy.messages, [.loading(true)])
    }
    
    // MARK: - Helpers
    
    private func localized(_ key: String, file: StaticString = #filePath, line: UInt = #line) -> String {
        let bundle = Bundle(for: SearchActivityPresenter.self)
        let localized = bundle.localizedString(forKey: key, value: nil, table: "SearchActivity")
        if localized == key {
            XCTFail("Please provide a localization for the key \(key)", file: file, line: line)
        }
        return localized
    }
    
    private final class ViewSpy: LoadingView {
        
        enum Message: Equatable {
            case loading(Bool)
        }
        
        private(set) var messages = [Message]()
        
        
        func didLoadingStateChanged(_ data: LoadingViewData) {
            messages.append(.loading(data.isLoading))
        }
        
    }
}
