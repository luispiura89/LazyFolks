//
//  SearchActivityValidator.swift
//  LazyFolksiOSApp
//
//  Created by Luis Francisco Piura Mejia on 23/11/21.
//

import LazyFolksEngine
import LazyFolksiOS

/// Class in charge of handling the `SearchActivityViewController` validations
/// it was created as a protocol implementation to decouple the `SearchActivityViewController` from specific types

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
        type?.isEmpty == false
        && participants?.isEmpty == false
        && minPrice?.isEmpty == false
        && maxPrice?.isEmpty == false
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
