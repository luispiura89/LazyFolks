//
//  ActivityDetailsViewData.swift
//  LazyFolksEngine
//
//  Created by Luis Francisco Piura Mejia on 24/11/21.
//

import Foundation

public struct ActivityDetailsViewData {
    public let title: String
    public let participants: Int
    public let minPrice: Double
    public let maxPrice: Double
    
    public init(title: String, participants: Int, minPrice: Double, maxPrice: Double) {
        self.title = title
        self.participants = participants
        self.minPrice = minPrice
        self.maxPrice = maxPrice
    }
}
