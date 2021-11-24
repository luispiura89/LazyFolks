//
//  ActivityEndpoint.swift
//  LazyFolksEngine
//
//  Created by Luis Francisco Piura Mejia on 20/11/21.
//

import Foundation

public enum ActivityEndpoint {
    case get(type: String, participants: String, minRange: String, maxRange: String)
    
    public func requestURL(baseURL: URL) -> URL {
        switch self {
        case let .get(type, participants, minRange, maxRange):
            var components = URLComponents(string: baseURL.absoluteString)!
            components.path.append("activity")
            components.queryItems = [
                URLQueryItem(name: "type", value: type),
                URLQueryItem(name: "participants", value: participants),
                URLQueryItem(name: "minprice", value: minRange),
                URLQueryItem(name: "maxprice", value: maxRange),
            ]
            return components.url!
        }
    }
}
