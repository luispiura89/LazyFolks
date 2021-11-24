//
//  ActivityDetailsViewData.swift
//  LazyFolksEngine
//
//  Created by Luis Francisco Piura Mejia on 24/11/21.
//

import Foundation

public struct ActivityDetailsViewData {
    public let title: String
    public let participants: String
    public let price: String
    public let type: String
    
    public init(title: String, type: String, participants: String, price: String) {
        self.title = title
        self.participants = participants
        self.price = price
        self.type = type
    }
}
