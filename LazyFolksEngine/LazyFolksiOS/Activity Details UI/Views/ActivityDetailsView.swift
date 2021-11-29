//
//  ActivityDetailsView.swift
//  LazyFolksiOS
//
//  Created by Luis Francisco Piura Mejia on 24/11/21.
//

import UIKit
import LazyFolksEngine

public final class ActivityDetailsView: UIScrollView {
    
    // MARK: - Properties
    
    private var viewData: ActivityDetailsViewData?
    public private(set) var typeFieldTitle: String?
    public private(set) var participantsFieldTitle: String?
    public private(set) var priceFieldTitle: String?
    
    // MARK: - Subviews
    
    private lazy var mainStackView: UIStackView = {
        UIStackView.makeStackView(
            subviews: [headerStackView, containerView],
            spacing: 60
        )
    }()
    
    private lazy var headerStackView: UIStackView = {
        UIStackView.makeStackView(
            subviews: [activityTitleLabel],
            margins: UIEdgeInsets(top: 25, left: 25, bottom: 0, right: 25),
            spacing: 60,
            alignment: .center
        )
    }()
    
    private lazy var infoStackView: UIStackView = {
        UIStackView.makeStackView(
            subviews: [typeItemView, participantsItemView, priceItemView],
            margins: UIEdgeInsets(top: 20, left: 25, bottom: 0, right: 25),
            spacing: 10
        )
    }()
    
    public private(set) lazy var typeItemView: ActivityDetailsItemView = {
        ActivityDetailsItemView(title: typeFieldTitle, info: viewData?.type, icon: .typeIcon)
    }()
    
    public private(set) lazy var participantsItemView: ActivityDetailsItemView = {
        ActivityDetailsItemView(title: participantsFieldTitle, info: viewData?.participants, icon: .participantsIcon)
    }()
    
    public private(set) lazy var priceItemView: ActivityDetailsItemView = {
        ActivityDetailsItemView(title: priceFieldTitle, info: viewData?.price, icon: .priceIcon)
    }()
    
    private lazy var activityTitleLabel: UILabel = {
        UILabel.makeLabel(text: viewData?.title, numberOfLines: 0, textStyle: .title1)
    }()

    
    private lazy var containerView: UIView = {
        let view = UIView.makeView(color: .gray)
        view.addSubview(infoStackView)
        NSLayoutConstraint.activate([
            infoStackView.topAnchor.constraint(equalTo: view.topAnchor),
            infoStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            infoStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            view.bottomAnchor.constraint(greaterThanOrEqualTo: infoStackView.bottomAnchor),
        ])
        return view
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .gray
        alwaysBounceHorizontal = false
        showsVerticalScrollIndicator = false
        showsHorizontalScrollIndicator = false
    }
    
    public convenience init(
        frame: CGRect,
        viewData: ActivityDetailsViewData,
        typeFieldTitle: String,
        participantsFieldTitle: String,
        priceFieldTitle: String
    ) {
        self.init(frame: frame)
        self.viewData = viewData
        self.typeFieldTitle = typeFieldTitle
        self.participantsFieldTitle = participantsFieldTitle
        self.priceFieldTitle = priceFieldTitle
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
            mainStackView.widthAnchor.constraint(equalToConstant: frame.width),
            trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor),
            bottomAnchor.constraint(equalTo: mainStackView.bottomAnchor)
        ])
    }

}
