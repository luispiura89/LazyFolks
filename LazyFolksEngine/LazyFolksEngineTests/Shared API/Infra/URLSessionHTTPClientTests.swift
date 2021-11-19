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
        
        let exp = expectation(description: "Wait for get")
        var receivedResult: NSError?
        sut.get(from: anyURL()) { result in
            if case let .failure(error) = result {
                receivedResult = error as NSError
            }
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 1.0)
        XCTAssertEqual(receivedResult?.code, anyNSError().code)
    }
    
    func test_get_deliversDataOnSuccessfulHTTPRequest() {
        let sut = makeSUT(with: (data: anyData(), response: anyHTTPURLResponse(), error: nil))
        
        let exp = expectation(description: "Wait for get")
        var receivedResult: (data: Data, response: HTTPURLResponse)?
        sut.get(from: anyURL()) { result in
            if case let .success(response) = result {
                receivedResult = response
            }
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 1.0)
        XCTAssertEqual(receivedResult?.data, anyData())
        XCTAssertEqual(receivedResult?.response.statusCode, anyHTTPURLResponse().statusCode)
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
    
    private func anyData() -> Data {
        Data("Any data".utf8)
    }
    
    private func anyHTTPURLResponse() -> HTTPURLResponse {
        HTTPURLResponse(url: anyURL(), statusCode: 200, httpVersion: nil, headerFields: nil)!
    }
}
