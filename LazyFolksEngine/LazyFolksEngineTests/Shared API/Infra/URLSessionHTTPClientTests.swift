//
//  URLSessionHTTPClient.swift
//  LazyFolksEngineTests
//
//  Created by Luis Francisco Piura Mejia on 19/11/21.
//

import XCTest
import LazyFolksEngine

final class URLSessionHTTPClientTests: XCTestCase {
    
    func test_get_shouldDeliverErrorOnHTTPRequestError() {
        let sut = makeSUT(with: (data: nil, response: nil, error: anyNSError()))
        let error = anyNSError()
        
        let exp = expectation(description: "Wait for get")
        var receivedResult: NSError?
        sut.get(from: anyURL()) { result in
            if case let .failure(error) = result {
                receivedResult = error as NSError
            }
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 1.0)
        XCTAssertEqual(receivedResult?.code, error.code)
    }
    
    // MARK: - Helpers
    
    private func makeSUT(with values: (data: Data?, response: URLResponse? , error: NSError? )) -> HTTPClient {
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [URLProtocolStub.self]
        URLProtocolStub.stub(
            with: URLProtocolStub.Stub(
                data: values.data,
                response: values.response,
                error: values.error))
        let session = URLSession(configuration: configuration)
        return URLSessionHTTPClient(session: session)
    }
    
    private func anyURL() -> URL {
        URL(string: "https://any-url.com")!
    }
    
    private func anyNSError() -> NSError {
        NSError(domain: "Any error", code: -1, userInfo: nil)
    }
}
