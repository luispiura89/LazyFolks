//
//  XCTestCase+MemoryLeaks.swift
//  LazyFolksiOSAppTests
//
//  Created by Luis Francisco Piura Mejia on 23/11/21.
//

import XCTest

extension XCTestCase {
    func trackMemoryLeaks(_ instance: AnyObject, file: StaticString = #filePath, line: UInt = #line) {
        addTeardownBlock { [weak instance] in
            XCTAssertNil(
                instance,
                "Instance \(String(describing: instance)) should have been deallocated potential memory leak",
                file: file,
                line: line
            )
        }
    }
}
