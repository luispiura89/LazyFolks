//
//  ActivityEndpointTests.swift
//  LazyFolksEngineTests
//
//  Created by Luis Francisco Piura Mejia on 20/11/21.
//

import XCTest
import LazyFolksEngine

final class ActivityEndpointTests: XCTestCase {
    
    func test_endpoint_shouldContainsQueryParams() {
        let type = "type"
        let participants = 2
        let minRange = 0.2
        let maxRange = 0.5
        let baseURL = URL(string: "https://www.boredapi.com/api/")!
        let endpoint = ActivityEndpoint.get(
            type: type,
            participants: participants,
            minRange: minRange,
            maxRange: maxRange)
        
        let activitiesEndpointURL = endpoint.requestURL(baseURL: baseURL)
        
        XCTAssertTrue(activitiesEndpointURL.pathComponents.contains("activity"))
        XCTAssertEqual(activitiesEndpointURL.query?.contains("type=type"), true)
        XCTAssertEqual(activitiesEndpointURL.query?.contains("participants=2"), true)
        XCTAssertEqual(activitiesEndpointURL.query?.contains("minprice=0.2"), true)
        XCTAssertEqual(activitiesEndpointURL.query?.contains("maxprice=0.5"), true)
    }
    
}
