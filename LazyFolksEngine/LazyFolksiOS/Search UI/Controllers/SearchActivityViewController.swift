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

public final class SearchActivityViewController: UIViewController, KeyboardObservable {
    
    public private(set) var searchView: SearchActivityView?
    public private(set) var errorView = ErrorView(frame: .zero)
    private var searchController: SearchActivityController?
    private var delegate: SearchActivityViewControllerDelegate?
    var keyboardObserver: KeyboardObserver?
    
    public override func loadView() {
        view = searchView
    }
    
    public convenience init(
        searchView: SearchActivityView,
        searchController: SearchActivityController? = nil,
        delegate: SearchActivityViewControllerDelegate? = nil
    ) {
        self.init()
        self.searchView = searchView
        self.searchController = searchController
        self.delegate = delegate
        self.searchView?.searchHandler = searchController?.searchActivity
        self.searchView?.didTypeChangeHandler = delegate?.updateType
        self.searchView?.didParticipantsChangeHandler = delegate?.updateParticipants
        self.searchView?.didMinPriceChangeHandler = delegate?.updateMinPrice
        self.searchView?.didMaxPriceChangeHandler = delegate?.updateMaxPrice
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        startKeyboardObserving { [weak searchView] keyboardFrame in
            searchView?.adjustInsets(keyboardFrame: keyboardFrame)
        } onHide: { [weak searchView] in
            searchView?.hideKeyboard()
        }

    }
    
    public func updateInputedData(values: (String, String, String, String)) {
        searchView?.searchButton.enableButton()
        searchController?.updateData(values: values)
    }
    
    public func disableSearchAction() {
        searchView?.searchButton.disableButton()
    }
    
    public override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return [.portrait]
    }
    
    deinit {
        stopKeyboardObserving()
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
            errorView.topAnchor.constraint(equalTo: searchView.safeAreaLayoutGuide.topAnchor).isActive = true
            errorView.leadingAnchor.constraint(equalTo: searchView.leadingAnchor).isActive = true
            searchView.trailingAnchor.constraint(equalTo: errorView.trailingAnchor).isActive = true
        }
    }
}
