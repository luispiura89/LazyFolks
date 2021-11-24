//
//  ActivityDetailsViewControllerSnapshotTests.swift
//  LazyFolksiOSTests
//
//  Created by Luis Francisco Piura Mejia on 24/11/21.
//

import LazyFolksiOS
import LazyFolksEngine
import XCTest

final class ActivityDetailsViewControllerSnapshotTests: XCTestCase {
    
    func test_activityDetails_shouldRenderActivityData() {
        let sut = makeSUT()
        
        record(snapshot: sut.snapshot(for: .iPhone13(style: .light)), named: "ACTIVITY_DETAILS_light")
        record(snapshot: sut.snapshot(for: .iPhone13(style: .dark)), named: "ACTIVITY_DETAILS_dark")
    }
    
    private func makeSUT() -> ActivityDetailsViewController {
        let bounds = SnapshotConfiguration.iPhone13(style: .light).frame
        let details = ActivityDetailsViewController(
            detailsView: ActivityDetailsView(
                frame: bounds,
                viewData: ActivityDetailsViewData(
                    title: "A title",
                    participants: 2,
                    minPrice: 0.2,
                    maxPrice: 0.5)
            )
        )
        details.loadViewIfNeeded()
        return details
    }
    
}
