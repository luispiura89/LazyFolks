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
        
        let receivedResult = errorResultFor(sut)
        
        XCTAssertEqual(receivedResult?.code, anyNSError().code)
    }
    
    func test_get_deliversDataOnSuccessfulHTTPRequest() {
        let sut = makeSUT(with: (data: anyData(), response: anyHTTPURLResponse(), error: nil))
        
        let receivedResult = successfulResultFor(sut)
        
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
    
    private func resultFor(_ sut: HTTPClient) -> HTTPClient.GetResult {
        let exp = expectation(description: "Wait for get")
        
        var receivedResult: HTTPClient.GetResult!
        
        sut.get(from: anyURL()) {
            receivedResult = $0
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 1.0)
        return receivedResult
    }
    
    private func errorResultFor(_ sut: HTTPClient, file: StaticString = #filePath, line: UInt = #line) -> NSError? {
        let result = resultFor(sut)
        
        if case let .failure(error) = result {
            return error as NSError
        } else {
            XCTFail("Expected failure got \(result) instead", file: file, line: line)
            return nil
        }
    }
    
    private func successfulResultFor(_ sut: HTTPClient, file: StaticString = #filePath, line: UInt = #line) -> (data: Data, response: HTTPURLResponse)? {
        let result = resultFor(sut)
        
        if case let .success(response) = result {
            return response
        } else {
            XCTFail("Expected success got \(result) instead", file: file, line: line)
            return nil
        }
    }
}
