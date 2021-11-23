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
    
    private static var noActivityFoundErrorMessage: String {
        localize(
            key: "NO_ACTIVITY_FOUND_ERROR_MESSAGE",
            comment: "No activity found error")
    }
    
    private static var generalLoadingErrorMessage: String {
        localize(
            key: "GENERAL_LOADING_ERROR_MESSAGE",
            comment: "General error")
    }
    
    private let loadingView: LoadingView
    private let errorView: ErrorView
    
    public init(loadingView: LoadingView, errorView: ErrorView) {
        self.loadingView = loadingView
        self.errorView = errorView
    }
    
    public func startSearchingActivity() {
        loadingView.didLoadingStateChanged(LoadingViewData(isLoading: true))
        errorView.displayErrorMessage(ErrorViewData(errorMessage: nil))
    }
    
    public func didFinishLoading(with error: Error) {
        loadingView.didLoadingStateChanged(LoadingViewData(isLoading: false))
        if let error = error as? ActivitiesMapper.Error, error == .noActivityWasFound {
            errorView.displayErrorMessage(ErrorViewData(errorMessage: SearchActivityPresenter.noActivityFoundErrorMessage))
        } else {
            errorView.displayErrorMessage(ErrorViewData(errorMessage: SearchActivityPresenter.generalLoadingErrorMessage))
        }
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
