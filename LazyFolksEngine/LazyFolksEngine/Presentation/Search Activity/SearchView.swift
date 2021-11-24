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
    typealias InputedData = (String, String, String, String)
    
    func didLoad(_ data: SearchActivityViewData)
    func updateEnteredData(_ data: InputedData?)
}
