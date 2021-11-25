//
//  SearchViewAdapter.swift
//  LazyFolksiOSApp
//
//  Created by Luis Francisco Piura Mejia on 23/11/21.
//

import LazyFolksEngine
import LazyFolksiOS

/// Class created to decouple the `SearchActivityViewController` from domain types
/// such as `Activity`. The presenter will notify this class when the fetch activity data
/// completes successfully and this class will drive the message to `SearchActivityViewController`

final class SearchViewAdapter: SearchView {
    
    private weak var controller: SearchActivityViewController?
    private let navigationHandler: (Activity) -> Void
    
    init(
        controller: SearchActivityViewController,
        navigationHandler: @escaping (Activity) -> Void
    ) {
        self.controller = controller
        self.navigationHandler = navigationHandler
    }
    
    func didLoad(_ data: SearchActivityViewData) {
        navigationHandler(data.activity)
    }
    
    func didEnteredInvalidData() {
        controller?.disableSearchAction()
    }
    
    func didEnteredValidData(_ data: InputedData) {
        controller?.updateInputedData(values: data)
    }
    
}
