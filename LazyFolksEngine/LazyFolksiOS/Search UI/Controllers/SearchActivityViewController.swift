//
//  SearchActivityViewController.swift
//  LazyFolksiOS
//
//  Created by Luis Francisco Piura Mejia on 22/11/21.
//

import UIKit
import LazyFolksEngine

public final class SearchActivityViewController: UIViewController {
    
    public private(set) var searchView: SearchActivityView?
    private var errorView = ErrorView(frame: .zero)
    private var windowBounds: CGRect?
    private var searchController: SearchActivityController?
    
    public override func loadView() {
        view = searchView
    }
    
    public convenience init(
        searchView: SearchActivityView,
        bounds: CGRect,
        searchController: SearchActivityController? = nil
    ) {
        self.init()
        self.searchView = searchView
        self.windowBounds = bounds
        self.searchController = searchController
        self.searchView?.searchHandler = searchController?.searchActivity
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        searchView?.addGradientBackground(frame: windowBounds)
        searchView?.addCurveTop(frame: windowBounds)
    }
    
    public func didFinishLoadWithError(message: String?) {
        errorView.message = message
        if message == nil {
            errorView.removeFromSuperview()
        } else {
            guard let searchView = searchView else { return }
            searchView.addSubview(errorView)
            errorView.topAnchor.constraint(equalTo: searchView.topAnchor).isActive = true
            errorView.leadingAnchor.constraint(equalTo: searchView.leadingAnchor).isActive = true
            searchView.trailingAnchor.constraint(equalTo: errorView.trailingAnchor).isActive = true
        }
    }
}

extension SearchActivityViewController: LoadingView {
    public func didLoadingStateChanged(_ data: LoadingViewData) {
        searchView?.searchButton.isLoading = data.isLoading
        searchController?.isSearching = data.isLoading
    }
}

extension SearchActivityViewController: LoadingErrorView {
    public func displayErrorMessage(_ data: ErrorViewData) {
        let message = data.errorMessage
        errorView.message = message
        if message == nil {
            errorView.removeFromSuperview()
        } else {
            guard let searchView = searchView else { return }
            searchView.addSubview(errorView)
            errorView.topAnchor.constraint(equalTo: searchView.topAnchor).isActive = true
            errorView.leadingAnchor.constraint(equalTo: searchView.leadingAnchor).isActive = true
            searchView.trailingAnchor.constraint(equalTo: errorView.trailingAnchor).isActive = true
        }
    }
}
