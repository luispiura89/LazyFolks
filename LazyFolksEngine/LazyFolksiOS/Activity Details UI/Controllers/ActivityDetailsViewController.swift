//
//  ActivityDetailsViewController.swift
//  LazyFolksiOS
//
//  Created by Luis Francisco Piura Mejia on 24/11/21.
//

import UIKit

public final class ActivityDetailsViewController: UIViewController {
    
    private var detailsView: ActivityDetailsView?
    
    public convenience init(
        detailsView: ActivityDetailsView
    ) {
        self.init()
        self.detailsView = detailsView
    }
    
    public override func loadView() {
        view = detailsView
    }
    
}
