//
//  ActivityDetailsPresenter.swift
//  LazyFolksEngine
//
//  Created by Luis Francisco Piura Mejia on 24/11/21.
//

import Foundation

public final class ActivityDetailsPresenter {
    
    // MARK: - Properties
    
    public static var typeFieldTitle: String {
        localize(
            key: "TYPE_FIELD_TITLE",
            comment: "Type title")
    }
    
    public static var priceFieldTitle: String {
        localize(
            key: "PRICE_FIELD_TITLE",
            comment: "Price title")
    }
    
    public static var participantsFieldTitle: String {
        localize(
            key: "PARTICIPANTS_FIELD_TITLE",
            comment: "Participants title")
    }
    
    private static func localize(key: String, comment: String) -> String {
        NSLocalizedString(
            key,
            tableName: "ActivityDetails",
            bundle: Bundle(for: Self.self),
            value: "",
            comment: comment)
    }
}
