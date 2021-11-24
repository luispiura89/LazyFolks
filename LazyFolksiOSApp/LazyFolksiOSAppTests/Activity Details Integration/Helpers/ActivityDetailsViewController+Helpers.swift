//
//  ActivityDetailsViewController+Helpers.swift
//  LazyFolksiOSAppTests
//
//  Created by Luis Francisco Piura Mejia on 24/11/21.
//

import LazyFolksiOS

extension ActivityDetailsViewController {
    
    var typeFieldTitle: String? {
        detailsView?.typeFieldTitle
    }
    
    var priceFieldTitle: String? {
        detailsView?.priceFieldTitle
    }
    
    var participantsFieldTitle: String? {
        detailsView?.participantsFieldTitle
    }
    
    var type: String? {
        detailsView?.typeLabel.text
    }
    
    var participants: String? {
        detailsView?.participantsLabel.text
    }
    
    var price: String? {
        detailsView?.priceLabel.text
    }
}
