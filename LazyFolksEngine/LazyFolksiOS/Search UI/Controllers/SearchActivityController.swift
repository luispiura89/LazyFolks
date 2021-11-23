//
//  SearchActivityController.swift
//  LazyFolksiOS
//
//  Created by Luis Francisco Piura Mejia on 23/11/21.
//

import Foundation

public final class SearchActivityController {
    
    public typealias SearchHandler = (String, Int, Double, Double) -> Void

    private let searchHandler: SearchHandler
    private var isSearching = false
    var activityType: String = ""
    var participants: Int = 0
    var minPrice: Double = 0.0
    var maxPrice: Double = 0.0
    
    public init(searchHandler: @escaping SearchHandler) {
        self.searchHandler = searchHandler
    }
    
    func searchActivity() {
        guard !isSearching else { return }
        searchHandler(activityType, participants, minPrice, maxPrice)
    }
    
}
