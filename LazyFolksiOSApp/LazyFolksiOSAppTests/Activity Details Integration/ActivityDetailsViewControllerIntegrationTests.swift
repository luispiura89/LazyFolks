//
//  ActivityDetailsViewControllerIntegrationTests.swift
//  LazyFolksiOSAppTests
//
//  Created by Luis Francisco Piura Mejia on 24/11/21.
//

import XCTest
import LazyFolksiOSApp
import LazyFolksiOS
import LazyFolksEngine

final class ActivityDetailsViewControllerIntegrationTests: XCTestCase {
    
    func test_detailsView_shouldHaveLocalizedTitles() {
        let sut = makeSUT()
        
        XCTAssertEqual(sut.typeFieldTitle, ActivityDetailsPresenter.typeFieldTitle)
        XCTAssertEqual(sut.participantsFieldTitle, ActivityDetailsPresenter.participantsFieldTitle)
        XCTAssertEqual(sut.priceFieldTitle, ActivityDetailsPresenter.priceFieldTitle)
    }
    
    // MARK: - Helpers
    
    private func makeSUT(
        title: String = "",
        type: String = "",
        price: String = "",
        participants: String = "",
        file: StaticString = #filePath,
        line: UInt = #line
    ) -> ActivityDetailsViewController {
        let details = ActivityDetailsComposer.compose(
            windowBounds: .zero,
            viewData: ActivityDetailsViewData(
                title: title,
                type: type,
                participants: participants,
                price: price
            )
        )
        
        trackMemoryLeaks(details, file: file, line: line)
        details.loadViewIfNeeded()
        
        return details
    }
    
}
