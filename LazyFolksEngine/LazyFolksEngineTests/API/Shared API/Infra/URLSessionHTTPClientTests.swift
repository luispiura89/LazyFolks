//
//  URLSessionHTTPClient.swift
//  LazyFolksEngineTests
//
//  Created by Luis Francisco Piura Mejia on 19/11/21.
//

import XCTest
import LazyFolksEngine

final class URLSessionHTTPClientTests: XCTestCase {
    
    override func setUp() {
        URLProtocolStub.removeStub()
    }
    
    override func tearDown() {
        URLProtocolStub.removeStub()
    }
    
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
    
    func test_get_shouldDeliverErrorForAnyHTTPRequestWithUnexpectedValues() {
        /*
         The only two expected scenarios are:
         1. non-nil data, non-nil response and nil error
         2. nil data, nil response and non-nil error
         
         any other combination should throw an error
         */
        
        XCTAssertNotNil(errorResultFor(makeSUT(with: (data: anyData(), response: anyHTTPURLResponse(), error: anyNSError()))))
        XCTAssertNotNil(errorResultFor(makeSUT(with: (data: anyData(), response: anyNonHTTPURLResponse(), error: anyNSError()))))
        XCTAssertNotNil(errorResultFor(makeSUT(with: (data: nil, response: nil, error: nil))))
        XCTAssertNotNil(errorResultFor(makeSUT(with: (data: nil, response: anyHTTPURLResponse(), error: anyNSError()))))
        XCTAssertNotNil(errorResultFor(makeSUT(with: (data: nil, response: anyNonHTTPURLResponse(), error: anyNSError()))))
        XCTAssertNotNil(errorResultFor(makeSUT(with: (data: anyData(), response: nil, error: anyNSError()))))
        XCTAssertNotNil(errorResultFor(makeSUT(with: (data: anyData(), response: nil, error: nil))))
        XCTAssertNotNil(errorResultFor(makeSUT(with: (data: anyData(), response: anyNonHTTPURLResponse(), error: nil))))
        XCTAssertNotNil(errorResultFor(makeSUT(with: (data: nil, response: anyHTTPURLResponse(), error: nil))))
        XCTAssertNotNil(errorResultFor(makeSUT(with: (data: nil, response: anyNonHTTPURLResponse(), error: nil))))
    }
    
    func test_get_sendsGetRequestToSpecifiedURL() {
        var expectedURL: URL?
        let sut = makeSUT(
            with: (data: anyData(), response: anyHTTPURLResponse(), error: nil),
            requestObserver: { expectedURL = $0 }
        )
        
        let exp = expectation(description: "wait for get method")
        sut.get(from: anyURL()) { _ in
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 1.0)
        XCTAssertEqual(expectedURL, anyURL())
    }
    
    // MARK: - Helpers
    
    private func makeSUT(
        with values: (data: Data?, response: URLResponse? , error: NSError?),
        requestObserver: ((URL?) -> Void)? = nil
    ) -> HTTPClient {
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [URLProtocolStub.self]
        URLProtocolStub.stub(
            with: URLProtocolStub.Stub(
                data: values.data,
                response: values.response,
                error: values.error),
            observer: requestObserver)
        let session = URLSession(configuration: configuration)
        return URLSessionHTTPClient(session: session)
    }
    
    private func anyHTTPURLResponse() -> HTTPURLResponse {
        HTTPURLResponse(url: anyURL(), statusCode: 200, httpVersion: nil, headerFields: nil)!
    }
    
    private func anyNonHTTPURLResponse() -> URLResponse {
        URLResponse(url: anyURL(), mimeType: nil, expectedContentLength: 0, textEncodingName: nil)
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
