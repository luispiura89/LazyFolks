//
//  SearchActivityValidator.swift
//  LazyFolksiOSApp
//
//  Created by Luis Francisco Piura Mejia on 23/11/21.
//

import LazyFolksEngine
import LazyFolksiOS

final class SearchActivityValidator: SearchActivityViewControllerDelegate {
    
    var presenter: SearchActivityPresenter?
    
    private var type: String?
    private var participants: String?
    private var minPrice: String?
    private var maxPrice: String?
    
    func updateType(value: String?) {
        type = value
        updateView()
    }
    
    func updateParticipants(value: String?) {
        participants = value
        updateView()
    }
    
    func updateMinPrice(value: String?) {
        minPrice = value
        updateView()
    }
    
    func updateMaxPrice(value: String?) {
        maxPrice = value
        updateView()
    }
    
    private func isDataValid() -> Bool {
        type != nil && participants != nil && minPrice != nil && maxPrice != nil
    }
    
    func updateView() {
        if isDataValid() {
            presenter?.updateView(
                inputedData: (
                    type: type ?? "",
                    participants: participants ?? "",
                    minPrice: minPrice ?? "",
                    maxPrice: maxPrice ?? "")
            )
        } else {
            presenter?.updateView(inputedData: nil)
        }
    }
}
