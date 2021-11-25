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
            subviews: [typeStackView, participantsStackView, priceStackView],
            margins: UIEdgeInsets(top: 0, left: 25, bottom: 0, right: 25),
            spacing: 0
        )
    }()
    
    private lazy var typeStackView: UIStackView = {
        UIStackView.makeStackView(
            subviews: [
                typeIconImageView,
                typeTitleLabel,
                typeLabel
            ],
            margins: UIEdgeInsets(top: 20, left: 25, bottom: 0, right: 25),
            spacing: 5,
            alignment: .center
        )
    }()
    
    private lazy var participantsStackView: UIStackView = {
        UIStackView.makeStackView(
            subviews: [
                participantsIconImageView,
                participantsTitleLabel,
                participantsLabel
            ],
            margins: UIEdgeInsets(top: 20, left: 25, bottom: 0, right: 25),
            spacing: 5,
            alignment: .center
        )
    }()
    
    private lazy var priceStackView: UIStackView = {
        UIStackView.makeStackView(
            subviews: [
                priceIconImageView,
                priceTitleLabel,
                priceLabel
            ],
            margins: UIEdgeInsets(top: 20, left: 25, bottom: 0, right: 25),
            spacing: 5,
            alignment: .center
        )
    }()
    
    private lazy var activityTitleLabel: UILabel = {
        UILabel.makeLabel(text: viewData?.title, numberOfLines: 0, textStyle: .title1)
    }()
    
    public private(set) lazy var participantsLabel: UILabel = {
        makeParticipantsViews().info
    }()
    
    private lazy var participantsTitleLabel: UILabel = {
        makeParticipantsViews().title
    }()
    
    private lazy var participantsIconImageView: UIImageView = {
        makeParticipantsViews().icon
    }()
    
    public private(set) lazy var priceLabel: UILabel = {
        makePriceViews().info
    }()
    
    private lazy var priceTitleLabel: UILabel = {
        makePriceViews().title
    }()
    
    private lazy var priceIconImageView: UIImageView = {
        makePriceViews().icon
    }()
    
    public private(set) lazy var typeLabel: UILabel = {
        makeTypeViews().info
    }()
    
    private lazy var typeTitleLabel: UILabel = {
        makeTypeViews().title
    }()
    
    private lazy var typeIconImageView: UIImageView = {
        makeTypeViews().icon
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView.makeView(color: UIColor(named: "Gray", in: Bundle(for: Self.self), compatibleWith: nil))
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
        backgroundColor = .white
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
            trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor),
            bottomAnchor.constraint(equalTo: mainStackView.bottomAnchor)
        ])
    }
    
    private func makeTypeViews() -> (title: UILabel, info: UILabel, icon: UIImageView) {
        makeFieldViews(fieldTitle: typeFieldTitle, fieldValue: viewData?.type, iconName: "TypeIcon")
    }
    
    private func makePriceViews() -> (title: UILabel, info: UILabel, icon: UIImageView) {
        makeFieldViews(fieldTitle: priceFieldTitle, fieldValue: viewData?.price, iconName: "PriceIcon")
    }
    
    private func makeParticipantsViews() -> (title: UILabel, info: UILabel, icon: UIImageView) {
        makeFieldViews(fieldTitle: participantsFieldTitle, fieldValue: viewData?.participants, iconName: "ParticipantsIcon")
    }
    
    private func makeFieldViews(
        fieldTitle: String?,
        fieldValue: String?,
        iconName: String
    ) -> (title: UILabel, info: UILabel, icon: UIImageView) {
        let info = UILabel.makeLabel(
            text: fieldValue,
            numberOfLines: 0,
            textStyle: .title2,
            textColor: UIColor(named: "Orange1", in: Bundle(for: Self.self), compatibleWith: nil)
        )
        
        let title = UILabel.makeLabel(
            text: fieldTitle,
            numberOfLines: 0,
            textStyle: .title2,
            textColor: UIColor(named: "Orange1", in: Bundle(for: Self.self), compatibleWith: nil)
        )
        
        let image = UIImage(named: iconName, in: Bundle(for: Self.self), compatibleWith: nil)
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 45),
            imageView.heightAnchor.constraint(equalToConstant: 45),
        ])
        imageView.contentMode = .scaleAspectFit
        return (title, info, imageView)
    }
}
