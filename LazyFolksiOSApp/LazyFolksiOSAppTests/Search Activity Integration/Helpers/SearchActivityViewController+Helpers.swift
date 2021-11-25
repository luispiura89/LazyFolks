//
//  SearchActivityViewController+Helpers.swift
//  LazyFolksiOSAppTests
//
//  Created by Luis Francisco Piura Mejia on 24/11/21.
//

import LazyFolksiOS
import UIKit

extension SearchActivityViewController {
    
    var header: String? {
        searchView?.title
    }
    
    var subtitle: String? {
        searchView?.subtitle
    }
    
    var typePlaceholder: String? {
        searchView?.typePlaceholder
    }
    
    var participantsPlaceholder: String? {
        searchView?.participantsPlaceholder
    }
    
    var minPricePlaceholder: String? {
        searchView?.minPricePlaceholder
    }
    
    var maxPricePlaceholder: String? {
        searchView?.maxPricePlaceholder
    }
    
    var searchButtonTitle: String? {
        searchView?.searchButtonTitle
    }
    
    var isShowingLoadingIndicator: Bool {
        searchView?.searchButton.isLoading == true
    }
    
    var canSendSearchRequest: Bool {
        searchView?.searchButton.isEnabled == true
    }
    
    var isShowingErrorMessage: Bool {
        errorView.message != nil
    }
    
    func simulateUserRequestedActivitySearch() {
        searchView?.searchButton.simulate(event: .touchUpInside)
    }
    
    func simulateUserFilledData() {
        searchView?.typeTextField.text = "Type"
        searchView?.participantsTextField.text = "2"
        searchView?.minPriceTextField.text = "0.2"
        searchView?.maxPriceTextField.text = "0.5"
        searchView?.typeTextField.simulate(event: .editingChanged)
        searchView?.participantsTextField.simulate(event: .editingChanged)
        searchView?.minPriceTextField.simulate(event: .editingChanged)
        searchView?.maxPriceTextField.simulate(event: .editingChanged)
    }
    
    func deletetypeField() {
        searchView?.typeTextField.text = ""
        searchView?.typeTextField.simulate(event: .editingChanged)
    }
}

extension UIControl {
    func simulate(event: UIControl.Event) {
        allTargets.forEach { target in
            actions(forTarget: target, forControlEvent: event)?.forEach {
                (target as NSObject).perform(Selector($0))
            }
        }
    }
}
