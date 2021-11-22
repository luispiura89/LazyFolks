//
//  SearchActivityViewController.swift
//  LazyFolksiOS
//
//  Created by Luis Francisco Piura Mejia on 22/11/21.
//

import UIKit

public final class SearchActivityViewController: UIViewController {
    
    private var searchView = SearchActivityView(frame: .zero)
    private var snapshotFrame: CGRect?
    
    public override func loadView() {
        view = searchView
    }
    
    public convenience init(snapshotFrame: CGRect) {
        self.init()
        self.snapshotFrame = snapshotFrame
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        searchView.addGradientBackground(frame: snapshotFrame)
        searchView.addCurveTop(frame: snapshotFrame)
    }
    
}
