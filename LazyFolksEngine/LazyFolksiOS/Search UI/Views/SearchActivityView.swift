//
//  SearchActivityView.swift
//  LazyFolksiOS
//
//  Created by Luis Francisco Piura Mejia on 22/11/21.
//

import UIKit

public final class SearchActivityView: UIView {
    
    // MARK: - Properties
    
    public private(set) var title: String?
    public private(set) var subtitle: String?
    public private(set) var typePlaceholder: String?
    public private(set) var participantsPlaceholder: String?
    public private(set) var minPricePlaceholder: String?
    public private(set) var maxPricePlaceholder: String?
    public private(set) var searchButtonTitle: String?
    
    var searchHandler: (() -> Void)?
    var didTypeChangeHandler: ((String?) -> Void)?
    var didParticipantsChangeHandler: ((String?) -> Void)?
    var didMinPriceChangeHandler: ((String?) -> Void)?
    var didMaxPriceChangeHandler: ((String?) -> Void)?
           
    
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
        UIStackView.makeStackView(
            subviews: [typeTextField, participantsTextField, minPriceTextField, maxPriceTextField, searchButton],
            margins: UIEdgeInsets(top: 20, left: 25, bottom: 0, right: 25),
            spacing: 20
        )
    }()
    
    private lazy var topStackView: UIStackView = {
        UIStackView.makeStackView(
            subviews: [headerLabel, subHeaderLabel],
            margins: UIEdgeInsets(top: 0, left: 25, bottom: 0, right: 25),
            spacing: 20
        )
    }()
    
    private lazy var mainStackView: UIStackView = {
        UIStackView.makeStackView(subviews: [topStackView, containerView], spacing: 60)
    }()
    
    private lazy var headerLabel: UILabel = {
        let label = UILabel.makeLabel(text: title, numberOfLines: 1, textStyle: .largeTitle)
        NSLayoutConstraint.activate([
            label.heightAnchor.constraint(equalToConstant: 80)
        ])
        return label
    }()
    
    private lazy var subHeaderLabel: UILabel = {
        UILabel.makeLabel(text: subtitle, numberOfLines: 0, textStyle: .title2)
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView.makeView(color: .gray)
        view.addSubview(fieldsStackView)
        NSLayoutConstraint.activate([
            fieldsStackView.topAnchor.constraint(equalTo: view.topAnchor),
            fieldsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            fieldsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            view.bottomAnchor.constraint(greaterThanOrEqualTo: fieldsStackView.bottomAnchor)
        ])
        return view
    }()
    
    public private(set) lazy var participantsTextField: UITextField = {
        UITextField.makeTexField(placeholder: participantsPlaceholder, keyboardType: .numberPad)
    }()
    
    public private(set) lazy var typeTextField: UITextField = {
        UITextField.makeTexField(placeholder: typePlaceholder)
    }()
    
    public private(set) lazy var minPriceTextField: UITextField = {
        UITextField.makeTexField(placeholder: minPricePlaceholder, keyboardType: .decimalPad)
    }()
    
    public private(set) lazy var maxPriceTextField: UITextField = {
        UITextField.makeTexField(placeholder: maxPricePlaceholder, keyboardType: .decimalPad)
    }()
    
    public private(set) lazy var searchButton: LoadingButton = {
        let button = LoadingButton(
            title: searchButtonTitle,
            color: .orange1
        )
        NSLayoutConstraint.activate([
            button.heightAnchor.constraint(equalToConstant: 45)
        ])
        button.disableButton()
        return button
    }()
    
    // MARK: - Init
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    public convenience init(
        bounds: CGRect,
        title: String,
        subtitle: String,
        typePlaceholder: String,
        participantsPlaceholder: String,
        minPricePlaceholder: String,
        maxPricePlaceholder: String,
        searchButtonTitle: String
    ) {
        self.init(frame: bounds)
        
        self.title = title
        self.subtitle = subtitle
        self.typePlaceholder = typePlaceholder
        self.participantsPlaceholder = participantsPlaceholder
        self.minPricePlaceholder = minPricePlaceholder
        self.maxPricePlaceholder = maxPricePlaceholder
        self.searchButtonTitle = searchButtonTitle
        
        setupSubviews()
        containerView.addCurveTop(frame: bounds)
        addGradientBackground(frame: bounds)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Methods
    
    func adjustInsets(keyboardFrame: CGRect) {
        let intersection = keyboardFrame.intersection(frame)
        let additionalSpace: CGFloat = 50
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: intersection.height + additionalSpace, right: 0)
    }
    
    func hideKeyboard() {
        scrollView.contentInset = .zero
    }
    
    private func setupSubviews() {
        addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
        ])
        searchButton.addTarget(self, action: #selector(searchActivity), for: .touchUpInside)
        typeTextField.addTarget(self, action: #selector(didEnterType), for: .editingChanged)
        minPriceTextField.addTarget(self, action: #selector(didEnterMinPrice), for: .editingChanged)
        participantsTextField.addTarget(self, action: #selector(didEnterParticipants), for: .editingChanged)
        maxPriceTextField.addTarget(self, action: #selector(didEnterMaxPrice), for: .editingChanged)
    }
    
    @objc private func searchActivity() {
        searchHandler?()
        endEditing(true)
    }
    
    @objc private func didEnterType() {
        didTypeChangeHandler?(typeTextField.text)
    }
    
    @objc private func didEnterParticipants() {
        didParticipantsChangeHandler?(participantsTextField.text)
    }
    
    @objc private func didEnterMinPrice() {
        didMinPriceChangeHandler?(minPriceTextField.text)
    }
    
    @objc private func didEnterMaxPrice() {
        didMaxPriceChangeHandler?(maxPriceTextField.text)
    }
}
