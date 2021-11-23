//
//  SearchActivityView.swift
//  LazyFolksiOS
//
//  Created by Luis Francisco Piura Mejia on 22/11/21.
//

import UIKit

public final class SearchActivityView: UIView {
    
    // MARK: - Properties
    
    var isLoading: Bool {
        get { searchButton.isLoading }
        set { searchButton.isLoading = newValue }
    }
    
    public private(set) var title: String?
    public private(set) var subtitle: String?
    public private(set) var typePlaceholder: String?
    public private(set) var participantsPlaceholder: String?
    public private(set) var minPricePlaceholder: String?
    public private(set) var maxPricePlaceholder: String?
           
    
    // MARK: - Subviews
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.addSubview(mainStackView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            mainStackView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            mainStackView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor),
        ])
        return scrollView
    }()
    
    private lazy var fieldsStackView: UIStackView = {
        makeStackView(
            subviews: [typeTextField, participantsTextField, minPriceTextField, maxPriceTextField, searchButton],
            margins: UIEdgeInsets(top: 20, left: 25, bottom: 0, right: 25),
            spacing: 20
        )
    }()
    
    private lazy var topStackView: UIStackView = {
        makeStackView(
            subviews: [headerLabel, subHeaderLabel],
            margins: UIEdgeInsets(top: 0, left: 25, bottom: 0, right: 25),
            spacing: 20
        )
    }()
    
    private lazy var mainStackView: UIStackView = {
        makeStackView(subviews: [topStackView, containerView], spacing: 60)
    }()
    
    private lazy var headerLabel: UILabel = {
        let label = makeLabel(text: title, numberOfLines: 1, textStyle: .largeTitle)
        NSLayoutConstraint.activate([
            label.heightAnchor.constraint(equalToConstant: 80)
        ])
        return label
    }()
    
    private lazy var subHeaderLabel: UILabel = {
        makeLabel(text: subtitle, numberOfLines: 0, textStyle: .title2)
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 248.0/255.0, green: 248/255.0, blue: 248/255.0, alpha: 1.0)
        view.addSubview(fieldsStackView)
        NSLayoutConstraint.activate([
            fieldsStackView.topAnchor.constraint(equalTo: view.topAnchor),
            fieldsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            fieldsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            view.bottomAnchor.constraint(greaterThanOrEqualTo: fieldsStackView.bottomAnchor)
        ])
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var participantsTextField: UITextField = {
        makeTexField(placeholder: participantsPlaceholder)
    }()
    
    private lazy var typeTextField: UITextField = {
        makeTexField(placeholder: typePlaceholder)
    }()
    
    private lazy var minPriceTextField: UITextField = {
        makeTexField(placeholder: minPricePlaceholder)
    }()
    
    private lazy var maxPriceTextField: UITextField = {
        makeTexField(placeholder: maxPricePlaceholder)
    }()
    
    private lazy var searchButton: LoadingButton = {
        let button = LoadingButton(title: "Search", color: UIColor(red: 255.0/255.0, green: 149.0/255.0, blue: 0.0/255.0, alpha: 1.0))
        NSLayoutConstraint.activate([
            button.heightAnchor.constraint(equalToConstant: 45)
        ])
        return button
    }()
    
    // MARK: - Init
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    public convenience init(
        title: String,
        subtitle: String,
        typePlaceholder: String,
        participantsPlaceholder: String,
        minPricePlaceholder: String,
        maxPricePlaceholder: String
    ) {
        self.init(frame: CGRect.zero)
        
        self.title = title
        self.subtitle = subtitle
        self.typePlaceholder = typePlaceholder
        self.participantsPlaceholder = participantsPlaceholder
        self.minPricePlaceholder = minPricePlaceholder
        self.maxPricePlaceholder = maxPricePlaceholder
        
        addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Methods
    
    func addGradientBackground(frame: CGRect? = nil) {
        let gradientFrame = frame ?? bounds
        let colorTop =  UIColor(red: 255.0/255.0, green: 149.0/255.0, blue: 0.0/255.0, alpha: 1.0).cgColor
        let colorBottom = UIColor(red: 255.0/255.0, green: 94.0/255.0, blue: 58.0/255.0, alpha: 1.0).cgColor
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0, 1]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.frame = gradientFrame
        
        layer.insertSublayer(gradientLayer, at:0)
    }
    
    func addCurveTop(frame: CGRect? = nil) {
        let pathFrame = frame ?? containerView.bounds
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: 0, y: pathFrame.maxY))
        path.addLine(to: CGPoint(x: pathFrame.maxX, y: pathFrame.maxY))
        path.addLine(to: CGPoint(x: pathFrame.maxX, y: -10))
        path.addQuadCurve(to: CGPoint(x: 0, y: -10), controlPoint: CGPoint(x: pathFrame.midX, y: 0))
        path.close()
        
        let layer = CAShapeLayer()
        layer.path = path.cgPath
        layer.fillColor = containerView.backgroundColor?.cgColor
        layer.strokeColor = containerView.backgroundColor?.cgColor
        
        containerView.layer.insertSublayer(layer, at: 0)
    }
    
    // MARK: - Private methods
    
    private func makeTexField(placeholder: String?) -> UITextField {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.backgroundColor = .white
        textField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textField.heightAnchor.constraint(equalToConstant: 45)
        ])
        let placeHolder = NSAttributedString(string: placeholder ?? "", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        textField.attributedPlaceholder = placeHolder
        return textField
    }
    
    
    private func makeStackView(subviews: [UIView], margins: UIEdgeInsets? = nil, spacing: CGFloat) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: subviews)
        stackView.axis = .vertical
        stackView.spacing = spacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        margins.map { stackView.layoutMargins = $0 }
        stackView.isLayoutMarginsRelativeArrangement = true
        return stackView
    }
    
    private func makeLabel(text: String?, numberOfLines: Int, textStyle: UIFont.TextStyle) -> UILabel {
        let label = UILabel()
        label.textColor = .white
        label.font = .preferredFont(forTextStyle: textStyle)
        label.adjustsFontForContentSizeCategory = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = numberOfLines
        label.text = text
        return label
    }
}
