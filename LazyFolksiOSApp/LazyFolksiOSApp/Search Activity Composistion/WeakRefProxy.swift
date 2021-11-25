//
//  WeakRefProxy.swift
//  LazyFolksiOSApp
//
//  Created by Luis Francisco Piura Mejia on 23/11/21.
//

import LazyFolksEngine

/// Class created to avoid the leak of implementation details in the presenter
/// With this class there's no need to specify that views in the presenter are weak
/// and that the views should be `AnyObject` type

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
    
    func removeErrorMessage() {
        reference?.removeErrorMessage()
    }
}
