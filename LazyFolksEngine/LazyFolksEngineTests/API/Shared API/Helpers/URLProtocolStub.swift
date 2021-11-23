//
//  URLProtocolStub.swift
//  LazyFolksEngineTests
//
//  Created by Luis Francisco Piura Mejia on 19/11/21.
//

import Foundation

final class URLProtocolStub: URLProtocol {
    
    struct Stub {
        var data: Data?
        var response: URLResponse?
        var error: NSError?
    }
    
    private static var stub: Stub?
    private static var requestObserver: ((URL?) -> Void)?
    
    static func removeStub() {
        stub = nil
        requestObserver = nil
    }
    
    static func stub(with values: Stub, observer: ((URL?) -> Void)? = nil) {
        stub = values
        requestObserver = observer
    }
    
    override class func canInit(with request: URLRequest) -> Bool {
        true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        request
    }
    
    override func startLoading() {
        guard let stub = URLProtocolStub.stub else {
            return
        }
        
        if let requestObserver = URLProtocolStub.requestObserver {
            requestObserver(request.url)
        }
        
        if let error = stub.error {
            client?.urlProtocol(self, didFailWithError: error)
        }
        
        if let data = stub.data {
            client?.urlProtocol(self, didLoad: data)
        }
        
        if let response = stub.response {
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
        }
        
        client?.urlProtocolDidFinishLoading(self)
    }
    
    override func stopLoading() {}
}
