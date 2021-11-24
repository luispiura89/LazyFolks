//
//  SearchActivityController.swift
//  LazyFolksiOS
//
//  Created by Luis Francisco Piura Mejia on 23/11/21.
//

import Foundation

public final class SearchActivityController {
    
    public typealias SearchValues = (String, String, String, String)
    public typealias SearchHandler = (SearchValues) -> Void

    private let searchHandler: SearchHandler
    private let isSearching: () -> Bool
    private var data: SearchValues?
    
    public init(
        searchHandler: @escaping SearchHandler,
        isSearching: @escaping () -> Bool
    ) {
        self.searchHandler = searchHandler
        self.isSearching = isSearching
    }
    
    func searchActivity() {
        guard !isSearching(), let (type, participants, minPrice, maxPrice) = data else { return }
        searchHandler((type, participants, minPrice, maxPrice))
    }
    
    func updateData(values: (type: String, participants: String, minPrice: String, maxPrice: String)?) {
        data = values
    }
}
