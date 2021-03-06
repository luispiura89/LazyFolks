//
//  HTTPClient.swift
//  LazyFolksEngine
//
//  Created by Luis Francisco Piura Mejia on 19/11/21.
//

import Foundation

public protocol HTTPClient {
    typealias GetResult = Result<(Data, HTTPURLResponse), Error>
    typealias GetCompletion = (GetResult) -> Void
    
    func get(from url: URL, completion: @escaping GetCompletion)
}
