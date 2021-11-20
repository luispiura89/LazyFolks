//
//  ActivityMapper.swift
//  LazyFolksEngine
//
//  Created by Luis Francisco Piura Mejia on 19/11/21.
//

import Foundation

public final class ActivitiesMapper {
    
    private init() {}
    
    enum Error: Swift.Error {
        case invalidData
    }
    
    public static func map(_ data: Data, for response: HTTPURLResponse) throws {
        throw Error.invalidData
    }
    
}
