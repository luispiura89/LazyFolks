//
//  SearchActivityView.swift
//  LazyFolksEngine
//
//  Created by Luis Francisco Piura Mejia on 23/11/21.
//

public struct SearchActivityViewData {
    public let activity: Activity
}

public protocol SearchView {
    func didLoad(_ data: SearchActivityViewData)
}
