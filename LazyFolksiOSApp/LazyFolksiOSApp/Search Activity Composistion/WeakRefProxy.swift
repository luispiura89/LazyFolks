//
//  WeakRefProxy.swift
//  LazyFolksiOSApp
//
//  Created by Luis Francisco Piura Mejia on 23/11/21.
//

import LazyFolksEngine

final class WeakRefProxy<T: AnyObject> {
    
    private weak var reference: T?
    
    init(reference: T) {
        self.reference = reference
    }
}

extension WeakRefProxy: LoadingView where T: LoadingView {
    func didLoadingStateChanged(_ data: LoadingViewData) {
        reference?.didLoadingStateChanged(data)
    }
}

extension WeakRefProxy: LoadingErrorView where T: LoadingErrorView {
    func displayErrorMessage(_ data: ErrorViewData) {
        reference?.displayErrorMessage(data)
    }
}
