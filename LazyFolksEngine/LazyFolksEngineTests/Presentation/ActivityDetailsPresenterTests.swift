//
//  ActivityDetailsPresenterTests.swift
//  LazyFolksEngineTests
//
//  Created by Luis Francisco Piura Mejia on 24/11/21.
//

import XCTest
import LazyFolksEngine

final class ActivityDetailsPresenterTests: XCTestCase {
    
    func test_presenter_shouldLocalizeTitles() {
        let bundle = Bundle(for: ActivityDetailsPresenter.self)
        let table = "ActivityDetails"
        XCTAssertEqual(
            ActivityDetailsPresenter.typeFieldTitle,
            localized("TYPE_FIELD_TITLE", bundle: bundle, table: table)
        )
        XCTAssertEqual(
            ActivityDetailsPresenter.participantsFieldTitle,
            localized("PARTICIPANTS_FIELD_TITLE", bundle: bundle, table: table)
        )
        XCTAssertEqual(
            ActivityDetailsPresenter.priceFieldTitle,
            localized("PRICE_FIELD_TITLE", bundle: bundle, table: table)
        )
    }
    
}
