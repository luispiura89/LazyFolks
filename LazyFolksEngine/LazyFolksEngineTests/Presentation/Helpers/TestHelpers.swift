//
//  TestHelpers.swift
//  LazyFolksEngineTests
//
//  Created by Luis Francisco Piura Mejia on 24/11/21.
//

import LazyFolksEngine
import Foundation
import XCTest

func localized(
    _ key: String,
    bundle: Bundle,
    table: String,
    file: StaticString = #filePath,
    line: UInt = #line
) -> String {
    let localized = bundle.localizedString(forKey: key, value: nil, table: table)
    if localized == key {
        XCTFail("Please provide a localization for the key \(key)", file: file, line: line)
    }
    return localized
}
