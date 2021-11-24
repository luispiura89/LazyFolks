//
//  Activity.swift
//  LazyFolksEngine
//
//  Created by Luis Francisco Piura Mejia on 20/11/21.
//

import Foundation

public struct Activity: Hashable {
    public let description: String
    public let type: String
    public let participants: Int
    public let price: Double
    
    public init(description: String, type: String, participants: Int, price: Double) {
        self.description = description
        self.type = type
        self.participants = participants
        self.price = price
    }
}
