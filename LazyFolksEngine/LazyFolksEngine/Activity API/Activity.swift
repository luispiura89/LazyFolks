//
//  Activity.swift
//  LazyFolksEngine
//
//  Created by Luis Francisco Piura Mejia on 20/11/21.
//

import Foundation

public struct Activity: Equatable {
    let description: String
    let type: String
    let participants: Int
    let price: Double
    
    public init(description: String, type: String, participants: Int, price: Double) {
        self.description = description
        self.type = type
        self.participants = participants
        self.price = price
    }
}
