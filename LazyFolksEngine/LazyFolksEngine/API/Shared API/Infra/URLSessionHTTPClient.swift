//
//  URLSessionHTTPClient.swift
//  LazyFolksEngine
//
//  Created by Luis Francisco Piura Mejia on 19/11/21.
//

import Foundation

/// Class in charge of handling the HTTP requests
/// is an `HTTPClient` implementation, that way we could replace it easily if we want
/// to send our request using other Framework.
/// This class is a protocol implementation to keep the rest of the business logic
/// decouple from infrastructure details.

public final class URLSessionHTTPClient: HTTPClient {
    
    private let session: URLSession
    
    public init(session: URLSession) {
        self.session = session
    }
    
    private struct UnexpectedResponseValues: Error {}
    
    public func get(from url: URL, completion: @escaping GetCompletion) {
        session.dataTask(with: url) { data, response, error in
            completion(Result {
                if let error = error {
                    throw error
                } else if let data = data, !data.isEmpty, let response = response as? HTTPURLResponse {
                    return (data, response)
                } else {
                    throw UnexpectedResponseValues()
                }
            })
        }.resume()
    }
}
