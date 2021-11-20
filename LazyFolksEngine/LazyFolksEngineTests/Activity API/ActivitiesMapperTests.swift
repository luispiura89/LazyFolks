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
    
    // MARK: - Helpers
    
    private func makeNoActivityFoundData() -> Data {
        try! JSONSerialization.data(withJSONObject: ["error": "Any error"])
    }
}

private extension HTTPURLResponse {
    convenience init?(code: Int) {
        self.init(url: anyURL(), statusCode: code, httpVersion: nil, headerFields: nil)
    }
}
