//
//  ErrorView.swift
//  LazyFolksEngine
//
//  Created by Luis Francisco Piura Mejia on 23/11/21.
//

public struct ErrorViewData {
    public let errorMessage: String?
}

public protocol ErrorView {
    func displayErrorMessage(_ data: ErrorViewData)
}
