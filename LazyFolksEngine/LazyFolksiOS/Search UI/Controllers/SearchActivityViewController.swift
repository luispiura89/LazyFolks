//
//  SearchActivityViewController.swift
//  LazyFolksiOS
//
//  Created by Luis Francisco Piura Mejia on 22/11/21.
//

import UIKit
import LazyFolksEngine

public protocol SearchActivityViewControllerDelegate {
    func updateType(value: String?)
    func updateParticipants(value: String?)
    func updateMinPrice(value: String?)
    func updateMaxPrice(value: String?)
}

public final class SearchActivityViewController: UIViewController {
    
    public private(set) var searchView: SearchActivityView?
    public private(set) var errorView = ErrorView(frame: .zero)
    private var searchController: SearchActivityController?
    private var windowBounds: CGRect?
    private var delegate: SearchActivityViewControllerDelegate?
    
    public override func loadView() {
        view = searchView
    }
    
    public convenience init(
        searchView: SearchActivityView,
        bounds: CGRect,
        searchController: SearchActivityController? = nil,
        delegate: SearchActivityViewControllerDelegate? = nil
    ) {
        self.init()
        self.searchView = searchView
        self.windowBounds = bounds
        self.searchController = searchController
        self.delegate = delegate
        self.searchView?.searchHandler = searchController?.searchActivity
        self.searchView?.didTypeChangeHandler = delegate?.updateType
        self.searchView?.didParticipantsChangeHandler = delegate?.updateParticipants
        self.searchView?.didMinPriceChangeHandler = delegate?.updateMinPrice
        self.searchView?.didMaxPriceChangeHandler = delegate?.updateMaxPrice
    }
    
    public func updateInputedData(values: (String, String, String, String)?) {
        if values != nil {
            searchView?.searchButton.enableButton()
        }
        searchController?.updateData(values: values)
    }
}

extension SearchActivityViewController: LoadingView {
    public func didLoadingStateChanged(_ data: LoadingViewData) {
        searchView?.searchButton.isLoading = data.isLoading
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
