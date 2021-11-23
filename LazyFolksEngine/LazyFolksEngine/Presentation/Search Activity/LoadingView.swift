//
//  LoadingView.swift
//  LazyFolksEngine
//
//  Created by Luis Francisco Piura Mejia on 23/11/21.
//

public struct LoadingViewData {
    public let isLoading: Bool
}

public protocol LoadingView {
    func didLoadingStateChanged(_ data: LoadingViewData)
}
