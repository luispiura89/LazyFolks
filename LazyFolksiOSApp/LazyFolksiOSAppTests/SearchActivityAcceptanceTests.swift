//
//  SearchActivityAcceptanceTests.swift
//  LazyFolksiOSAppTests
//
//  Created by Luis Francisco Piura Mejia on 24/11/21.
//

import Foundation
import XCTest
@testable import LazyFolksiOSApp
import LazyFolksiOS
import LazyFolksEngine

final class SearchActivityAcceptanceTests: XCTestCase {
    
    func test_sceneDelegate_shouldRenderSearchActivityScreen() {
        let window = UIWindowSpy()
        let scene = launchApp(with: window)
        
        XCTAssertEqual(window.makeKeyAndVisibleCallCount, 1)
        
        let rootViewController = scene.window?.rootViewController as? SearchActivityViewController
        XCTAssertNotNil(rootViewController)
    }
    
    func test_searchActivity_shouldDisplayDetailsAfterSuccessfulLoadRequest() {
        let type = "Type"
        let participants = 2
        let price = 0.2
        let description = "description"
        let json = makeActivity(description: description, type: type, participants: participants, price: price)
        let window = UIWindow()
        let scene = launchApp(with: window, httpClient: StubHTTPClient(data: makeActivityData(json: json)))
        
        let detailsViewController = displayActivityDetails(scene: scene)
        
        XCTAssertEqual(detailsViewController?.price, "\(price)")
        XCTAssertEqual(detailsViewController?.type, type)
        XCTAssertEqual(detailsViewController?.participants, "\(participants)")
    }
    
    // MARK: - Helpers
    
    private final class UIWindowSpy: UIWindow {
        var makeKeyAndVisibleCallCount = 0

        override func makeKeyAndVisible() {
            makeKeyAndVisibleCallCount = 1
        }
    }
    
    private func displayActivityDetails(scene: SceneDelegate) -> ActivityDetailsViewController? {
        let searchViewController = scene.window?.rootViewController as? SearchActivityViewController
        
        searchViewController?.simulateUserFilledData()
        searchViewController?.simulateUserRequestedActivitySearch()
        RunLoop.current.run(until: Date())
        
        return searchViewController?.presentedViewController as? ActivityDetailsViewController
    }
    
    private func launchApp(with window: UIWindow, httpClient: HTTPClient? = nil) -> SceneDelegate {
        let scene = httpClient.map { SceneDelegate(httpClient: $0) } ?? SceneDelegate()
        scene.window = window
        scene.configureWindow()
        return scene
    }
    
    private final class StubHTTPClient: HTTPClient {
        
        private let data: Data
        
        init(data: Data) {
            self.data = data
        }
        
        func get(from url: URL, completion: @escaping GetCompletion) {
            completion(.success((data, HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)!)))
        }
        
    }
    
    private func makeActivityData(json: [String: Any]) -> Data {
        try! JSONSerialization.data(withJSONObject: json)
    }
    
    private func makeActivity(
        description: String,
        type: String,
        participants: Int,
        price: Double
    ) -> [String: Any] {
        let json: [String: Any] = [
            "activity": description,
            "type": type,
            "price": price,
            "participants": participants
        ]
        return json
    }
    
}
