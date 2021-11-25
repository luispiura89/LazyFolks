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
        let bundle = Bundle(for: SearchActivityPresenter.self)
        let table = "SearchActivity"
        XCTAssertEqual(
            SearchActivityPresenter.title,
            localized("SEARCH_ACTIVITY_VIEW_TITLE", bundle: bundle, table: table)
        )
        XCTAssertEqual(
            SearchActivityPresenter.subtitle,
            localized("SEARCH_ACTIVITY_VIEW_SUBTITLE", bundle: bundle, table: table)
        )
        XCTAssertEqual(
            SearchActivityPresenter.typePlaceholder,
            localized("SEARCH_ACTIVITY_TYPE_PLACEHOLDER", bundle: bundle, table: table)
        )
        XCTAssertEqual(
            SearchActivityPresenter.participantsPlaceholder,
            localized("SEARCH_ACTIVITY_PARTICIPANTS_PLACEHOLDER", bundle: bundle, table: table)
        )
        XCTAssertEqual(
            SearchActivityPresenter.minPricePlaceholder,
            localized("SEARCH_ACTIVITY_MIN_PRICE_PLACEHOLDER", bundle: bundle, table: table)
        )
        XCTAssertEqual(
            SearchActivityPresenter.maxPricePlaceholder,
            localized("SEARCH_ACTIVITY_MAX_PRICE_PLACEHOLDER", bundle: bundle, table: table)
        )
        XCTAssertEqual(
            SearchActivityPresenter.searchButtonTitle,
            localized("SEARCH_ACTIVITY_SEARCH_BUTTON_TITLE", bundle: bundle, table: table)
        )
    }
    
    func test_presenter_shouldTellTheViewToLoadWhenSearchStarts() {
        let (presenter, viewSpy) = makeSUT()
        
        presenter.startSearchingActivity()
        
        XCTAssertEqual(viewSpy.messages, [.loading(true), .failure(nil)])
    }
    
    func test_presenter_shouldTellTheViewToDisplayNotFoundActivityErrorOnError() {
        let (presenter, viewSpy) = makeSUT()
        let bundle = Bundle(for: SearchActivityPresenter.self)
        let table = "SearchActivity"
        
        presenter.didFinishLoading(with: ActivitiesMapper.Error.noActivityWasFound)
        
        XCTAssertEqual(
            viewSpy.messages,
            [.loading(false), .failure(localized("NO_ACTIVITY_FOUND_ERROR_MESSAGE", bundle: bundle, table: table))]
        )
    }
    
    func test_presenter_shouldTellTheViewToDisplayGeneralErrorOnError() {
        let (presenter, viewSpy) = makeSUT()
        let bundle = Bundle(for: SearchActivityPresenter.self)
        let table = "SearchActivity"
        
        presenter.didFinishLoading(with: anyNSError())
        
        XCTAssertEqual(
            viewSpy.messages,
            [.loading(false), .failure(localized("GENERAL_LOADING_ERROR_MESSAGE", bundle: bundle, table: table))]
        )
    }
    
    func test_presenter_shouldTellTheViewToDisplayAnActivityOnSuccessfulLoading() {
        let activity = Activity(description: "A description", type: "A type", participants: 1, price: 0.2)
        let (presenter, viewSpy) = makeSUT()
        
        presenter.didFinishLoading(with: activity)
        
        XCTAssertEqual(viewSpy.messages, [.loading(false), .success(activity)])
    }
    
    func test_presenter_shouldTellTheViewToUpdateData() {
        let (presenter, viewSpy) = makeSUT()
        let type = "type"
        let participants = "0"
        let minPrice = "0.2"
        let maxPrice = "0.5"
        
        presenter.updateView(inputedData: (type: type, participants: participants, minPrice: minPrice, maxPrice: maxPrice))
        
        XCTAssertEqual(viewSpy.messages, [.inputedData(type, participants, minPrice, maxPrice)])
    }
    
    // MARK: - Helpers
    
    private func makeSUT(file: StaticString = #filePath, line: UInt = #line) -> (SearchActivityPresenter, ViewSpy) {
        let viewSpy = ViewSpy()
        let presenter = SearchActivityPresenter(loadingView: viewSpy, errorView: viewSpy, searchView: viewSpy)
        
        trackMemoryLeaks(viewSpy, file: file, line: line)
        trackMemoryLeaks(presenter, file: file, line: line)
        
        return (presenter, viewSpy)
    }
    
    private final class ViewSpy: LoadingView, LoadingErrorView, SearchView {
        
        enum Message: Hashable {
            
            case loading(Bool)
            case failure(String?)
            case success(Activity)
            case inputedData(String?, String?, String?, String?)
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
        
        func updateEnteredData(_ data: InputedData?) {
            if let data = data {
                let (type, participants, minPrice, maxPrice) = data
                messages.insert(.inputedData(type, participants, minPrice, maxPrice))
            } else {
                messages.insert(.inputedData(nil, nil, nil, nil))
            }
        }
    }
}
