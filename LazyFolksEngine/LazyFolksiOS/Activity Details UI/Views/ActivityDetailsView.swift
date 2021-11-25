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
            subviews: [typeStackView, participantsStackView, priceStackView],
            margins: UIEdgeInsets(top: 20, left: 25, bottom: 0, right: 25),
            spacing: 10
        )
    }()
    
    private lazy var typeStackView: UIStackView = {
        makeFieldContainer(title: typeTitleLabel, info: typeLabel, icon: typeIconImageView)
    }()
    
    private lazy var participantsStackView: UIStackView = {
        makeFieldContainer(title: participantsTitleLabel, info: participantsLabel, icon: participantsIconImageView)
    }()
    
    private lazy var priceStackView: UIStackView = {
        makeFieldContainer(title: priceTitleLabel, info: priceLabel, icon: priceIconImageView)
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
        backgroundColor = UIColor(named: "Gray", in: Bundle(for: Self.self), compatibleWith: nil)
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
            textStyle: .subheadline,
            textColor: UIColor(named: "Orange1", in: Bundle(for: Self.self), compatibleWith: nil)
        )
        
        let title = UILabel.makeLabel(
            text: fieldTitle,
            numberOfLines: 0,
            textStyle: .headline,
            textColor: UIColor(named: "Orange1", in: Bundle(for: Self.self), compatibleWith: nil)
        )
        
        let image = UIImage(named: iconName, in: Bundle(for: Self.self), compatibleWith: nil)
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 40),
            imageView.heightAnchor.constraint(equalToConstant: 40),
        ])
        imageView.contentMode = .scaleAspectFit
        return (title, info, imageView)
    }
    
    private func makeFieldContainer(title: UILabel, info: UILabel, icon: UIImageView) -> UIStackView {
        let textfields = UIStackView.makeStackView(
            subviews: [
                title,
                info
            ],
            margins: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0),
            spacing: 8
        )
        let container = UIStackView.makeStackView(
            subviews: [
                icon,
                textfields
            ],
            margins: UIEdgeInsets(top: 20, left: 16, bottom: 20, right: 16),
            spacing: 20,
            alignment: .leading,
            axis: .horizontal
        )
        container.backgroundColor = .white
        container.clipsToBounds = true
        container.layer.cornerRadius = 5
        return container
    }
}
