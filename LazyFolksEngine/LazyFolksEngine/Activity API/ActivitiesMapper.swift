//
//  ActivityMapper.swift
//  LazyFolksEngine
//
//  Created by Luis Francisco Piura Mejia on 19/11/21.
//

import Foundation

public final class ActivitiesMapper {
    
    private struct DecodableError: Decodable {
        let error: String
    }
    
    private init() {}
    
    public enum Error: Swift.Error, Equatable {
        case invalidData
        case noActivityWasFound
    }
    
    public static func map(_ data: Data, for response: HTTPURLResponse) throws {
        guard response.statusCode == 200,
                let _ = try? JSONDecoder().decode(DecodableError.self, from: data) else {
                    throw Error.invalidData
        }
        
        throw Error.noActivityWasFound
    }
    
}
