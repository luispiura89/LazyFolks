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

final class SearchActivityAcceptanceTests: XCTestCase {
    
    func test_sceneDelegate_shouldRenderSearchActivityScreen() {
        let scene = SceneDelegate()
        
        let window = UIWindowSpy()
        scene.window = window
        
        scene.configureWindow()
        
        XCTAssertEqual(window.makeKeyAndVisibleCallCount, 1)
        let rootViewController = scene.window?.rootViewController as? SearchActivityViewController
        XCTAssertNotNil(rootViewController)
        
    }
    
    // MARK: - Helpers
    
    private class UIWindowSpy: UIWindow {
        var makeKeyAndVisibleCallCount = 0

        override func makeKeyAndVisible() {
            makeKeyAndVisibleCallCount = 1
        }
    }
    
}
