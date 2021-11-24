//
//  ActivityDetailsView.swift
//  LazyFolksiOS
//
//  Created by Luis Francisco Piura Mejia on 24/11/21.
//

import UIKit
import LazyFolksEngine

public final class ActivityDetailsView: UIView {
    
    // MARK: - Properties
    
    private var viewData: ActivityDetailsViewData?
    
    // MARK: - Subviews
    
    private lazy var mainStackView: UIStackView = {
        UIStackView.makeStackView(
            subviews: [headerStackView, containerView],
            margins: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0),
            spacing: 60
        )
    }()
    
    private lazy var headerStackView: UIStackView = {
        UIStackView.makeStackView(
            subviews: [activityTitleLabel],
            margins: UIEdgeInsets(top: 0, left: 25, bottom: 0, right: 25),
            spacing: 60
        )
    }()
    
    private lazy var infoStackView: UIStackView = {
        UIStackView.makeStackView(
            subviews: [],
            margins: UIEdgeInsets(top: 20, left: 25, bottom: 0, right: 25),
            spacing: 20
        )
    }()
    
    private lazy var activityTitleLabel: UILabel = {
        UILabel.makeLabel(text: viewData?.title, numberOfLines: 0, textStyle: .title2)
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "Gray", in: Bundle(for: Self.self), compatibleWith: nil)
        view.addSubview(infoStackView)
        NSLayoutConstraint.activate([
            infoStackView.topAnchor.constraint(equalTo: view.topAnchor),
            infoStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            infoStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            view.bottomAnchor.constraint(greaterThanOrEqualTo: infoStackView.bottomAnchor),
        ])
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .white
    }
    
    public convenience init(
        frame: CGRect,
        viewData: ActivityDetailsViewData
    ) {
        self.init(frame: frame)
        self.viewData = viewData
        addGradientBackground(frame: frame)
        setupSubviews()
        containerView.addCurveTop(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    private func setupSubviews() {
        addSubview(mainStackView)
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: topAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor),
            bottomAnchor.constraint(equalTo: mainStackView.bottomAnchor)
        ])
    }
}
