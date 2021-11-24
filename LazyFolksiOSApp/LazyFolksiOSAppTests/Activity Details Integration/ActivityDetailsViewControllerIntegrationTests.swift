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
    
    func test_detailsView_shouldRenderProvidedData() {
        let type = "Type"
        let participants = "10"
        let title = "an activity"
        let price = "0.2"
        let sut = makeSUT(title: title, type: type, price: price, participants: participants)
        
        XCTAssertEqual(sut.type, type)
        XCTAssertEqual(sut.participants, participants)
        XCTAssertEqual(sut.price, price)
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
