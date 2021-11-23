//
//  ActivityMapperTests.swift
//  LazyFolksEngineTests
//
//  Created by Luis Francisco Piura Mejia on 19/11/21.
//

import XCTest
import LazyFolksEngine

final class ActivitiesMapperTests: XCTestCase {
    
    func test_map_shouldThrowAnErrorOnNon200HTTPResponse() throws {
        let non200HTTPCodes = [199, 300, 400, 499, 500]
        let invalidJSONData = anyData()
        
        try non200HTTPCodes.forEach { code in
            XCTAssertThrowsError(try ActivitiesMapper.map(invalidJSONData, for: HTTPURLResponse(code: code)!)) {
                XCTAssertEqual($0 as? ActivitiesMapper.Error, ActivitiesMapper.Error.invalidData)
            }
        }
    }
    
    func test_map_shouldThrowAnErrorOn200HTTPResponseAndErrorData() {
        let noActivityFoundData = makeNoActivityFoundData()
        
        XCTAssertThrowsError(try ActivitiesMapper.map(noActivityFoundData, for: HTTPURLResponse(code: 200)!)) {
            XCTAssertEqual($0 as? ActivitiesMapper.Error, ActivitiesMapper.Error.noActivityWasFound)
        }
    }
    
    func test_map_shouldReturnDataOn200HTTPResponseAndActivityData() {
        let activity = makeActivity(
            description: "A description",
            type: "A type",
            participants: 10,
            price: 2.0)
        let activityData = makeActivityData(json: activity.json)
        
        let result = try? ActivitiesMapper.map(activityData, for: HTTPURLResponse(code: 200)!)
        
        XCTAssertEqual(activity.model, result)
    }
    
    // MARK: - Helpers
    
    private func makeNoActivityFoundData() -> Data {
        try! JSONSerialization.data(withJSONObject: ["error": "Any error"])
    }
    
    private func makeActivityData(json: [String: Any]) -> Data {
        try! JSONSerialization.data(withJSONObject: json)
    }
    
    private func makeActivity(
        description: String,
        type: String,
        participants: Int,
        price: Double
    ) -> (model: Activity, json: [String: Any]) {
        let json: [String: Any] = [
            "activity": description,
            "type": type,
            "price": price,
            "participants": participants
        ]
        
        let model = Activity(
            description: description,
            type: type,
            participants: participants,
            price: price
        )
        
        return (model, json)
    }
}

private extension HTTPURLResponse {
    convenience init?(code: Int) {
        self.init(url: anyURL(), statusCode: code, httpVersion: nil, headerFields: nil)
    }
}
