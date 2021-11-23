//
//  SearchActivityPresenter.swift
//  LazyFolksEngine
//
//  Created by Luis Francisco Piura Mejia on 23/11/21.
//

import Foundation

public final class SearchActivityPresenter {
    
    public static var title: String {
        localize(
            key: "SEARCH_ACTIVITY_VIEW_TITLE",
            comment: "Search activity screen title")
    }
    
    public static var subtitle: String {
        localize(
            key: "SEARCH_ACTIVITY_VIEW_SUBTITLE",
            comment: "Search activity subtitle")
    }
    
    public static var typePlaceholder: String {
        localize(
            key: "SEARCH_ACTIVITY_TYPE_PLACEHOLDER",
            comment: "Type field placeholder")
    }
    
    public static var participantsPlaceholder: String {
        localize(
            key: "SEARCH_ACTIVITY_PARTICIPANTS_PLACEHOLDER",
            comment: "Participants field placeholder")
    }
    
    public static var minPricePlaceholder: String {
        localize(
            key: "SEARCH_ACTIVITY_MIN_PRICE_PLACEHOLDER",
            comment: "Min price field placeholder")
    }
    
    public static var maxPricePlaceholder: String {
        localize(
            key: "SEARCH_ACTIVITY_MAX_PRICE_PLACEHOLDER",
            comment: "Max price field placeholder")
    }
    
    private static func localize(key: String, comment: String) -> String {
        NSLocalizedString(
            key,
            tableName: "SearchActivity",
            bundle: Bundle(for: Self.self),
            value: "",
            comment: comment)
    }
    
}
