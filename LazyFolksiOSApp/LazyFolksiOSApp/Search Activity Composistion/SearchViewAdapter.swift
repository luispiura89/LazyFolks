//
//  SearchViewAdapter.swift
//  LazyFolksiOSApp
//
//  Created by Luis Francisco Piura Mejia on 23/11/21.
//

import LazyFolksEngine
import LazyFolksiOS

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
    
    func updateEnteredData(_ data: InputedData?) {
        controller?.updateInputedData(values: data)
    }
    
}
