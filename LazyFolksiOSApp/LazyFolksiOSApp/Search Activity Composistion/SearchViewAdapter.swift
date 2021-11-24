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
    
    init(controller: SearchActivityViewController) {
        self.controller = controller
    }
    
    func didLoad(_ data: SearchActivityViewData) {}
    
    func updateEnteredData(_ data: InputedData?) {
        controller?.updateInputedData(values: data)
    }
    
}
