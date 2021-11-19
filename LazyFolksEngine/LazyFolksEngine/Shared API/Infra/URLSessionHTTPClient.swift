//
//  URLSessionHTTPClient.swift
//  LazyFolksEngine
//
//  Created by Luis Francisco Piura Mejia on 19/11/21.
//

import Foundation

public final class URLSessionHTTPClient: HTTPClient {
    
    private let session: URLSession
    
    public init(session: URLSession) {
        self.session = session
    }
    
    public func get(from url: URL, completion: @escaping GetCompletion) {
        session.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
            } else if let data = data, let response = response as? HTTPURLResponse {
                completion(.success((data, response)))
            }
        }.resume()
    }
}
