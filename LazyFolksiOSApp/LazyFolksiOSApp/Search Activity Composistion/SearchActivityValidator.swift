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
    
    private enum Field {
        case type(String?)
        case participants(String?)
        case minPrice(String?)
        case maxPrice(String?)
    }
    
    private var type: String?
    private var participants: String?
    private var minPrice: String?
    private var maxPrice: String?
    
    func updateType(value: String?) {
        setValue(for: .type(value))
    }
    
    func updateParticipants(value: String?) {
        setValue(for: .participants(value))
    }
    
    func updateMinPrice(value: String?) {
        setValue(for: .minPrice(value))
    }
    
    func updateMaxPrice(value: String?) {
        setValue(for: .maxPrice(value))
    }
    
    private func setValue(for field: Field) {
        switch field {
        case let .type(value):
            type = value
        case let .participants(value):
            participants = value
        case let .minPrice(value):
            minPrice = value
        case let .maxPrice(value):
            maxPrice = value
        }
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
