//
//  SearchViewComposer.swift
//  LazyFolksiOSApp
//
//  Created by Luis Francisco Piura Mejia on 23/11/21.
//

import Foundation
import LazyFolksiOS
import LazyFolksEngine
import UIKit

public final class SearchViewComposer {
    private init() {}
    
    static public func compose(windowBounds: CGRect) -> SearchActivityViewController {
        let searchView = SearchActivityView(
            title: SearchActivityPresenter.title,
            subtitle: SearchActivityPresenter.subtitle,
            typePlaceholder: SearchActivityPresenter.typePlaceholder,
            participantsPlaceholder: SearchActivityPresenter.participantsPlaceholder,
            minPricePlaceholder: SearchActivityPresenter.minPricePlaceholder,
            maxPricePlaceholder: SearchActivityPresenter.maxPricePlaceholder
        )
        let search = SearchActivityViewController(searchView: searchView, bounds: windowBounds)
        
        return search
    }
}
