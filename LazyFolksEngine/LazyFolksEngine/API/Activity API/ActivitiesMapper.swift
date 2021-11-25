//
//  ActivityMapper.swift
//  LazyFolksEngine
//
//  Created by Luis Francisco Piura Mejia on 19/11/21.
//

import Foundation

/// Class in charge of mapping the `Data` received from the `HTTPClient`
/// either into valid data or into an error

public final class ActivitiesMapper {
    
    private struct DecodableError: Decodable {
        let error: String
    }
    
    private struct DecodableActivity: Decodable {
        let activity: String
        let type: String
        let participants: Int
        let price: Double
        
        var mappedActivity: Activity {
            Activity(description: activity, type: type, participants: participants, price: price)
        }
    }
    
    private init() {}
    
    public enum Error: Swift.Error, Equatable {
        case invalidData
        case noActivityWasFound
    }
    
    public static func map(_ data: Data, for response: HTTPURLResponse) throws -> Activity {
        guard isOK(response), let activity = try? JSONDecoder().decode(DecodableActivity.self, from: data) else {
                  throw mapError(from: data)
        }
        
        return activity.mappedActivity
    }
    
    private static func mapError(from data: Data) -> Error {
        (try? JSONDecoder().decode(DecodableError.self, from: data)).map { _ in
            Error.noActivityWasFound
        } ?? Error.invalidData
    }
    
    private static func isOK(_ response: HTTPURLResponse) -> Bool {
        response.statusCode == 200
    }
}
