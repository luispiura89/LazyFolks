//
//  SearchActivityView.swift
//  LazyFolksiOS
//
//  Created by Luis Francisco Piura Mejia on 22/11/21.
//

import UIKit

final class SearchActivityView: UIView {
    
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
        let stackView = UIStackView(arrangedSubviews: [typeTextField, participantsTextField, minPriceTextField, maxPriceTextField, searchButton])
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.layoutMargins = UIEdgeInsets(top: 20, left: 25, bottom: 0, right: 25)
        stackView.isLayoutMarginsRelativeArrangement = true
        return stackView
    }()
    
    private lazy var topStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [headerLabel, subHeaderLabel])
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 20
        stackView.layoutMargins = UIEdgeInsets(top: 0, left: 25, bottom: 0, right: 25)
        stackView.isLayoutMarginsRelativeArrangement = true
        return stackView
    }()
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [topStackView, containerView])
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 60
        return stackView
    }()
    
    private lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .preferredFont(forTextStyle: .largeTitle)
        label.adjustsFontForContentSizeCategory = true
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.heightAnchor.constraint(equalToConstant: 80)
        ])
        label.text = "Welcome Lazy Folks!"
        return label
    }()
    
    private lazy var subHeaderLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .preferredFont(forTextStyle: .title2)
        label.adjustsFontForContentSizeCategory = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.text = "Please search an activity so you can fight lazyness"
        return label
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
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.backgroundColor = .white
        textField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textField.heightAnchor.constraint(equalToConstant: 45)
        ])
        var placeHolder = NSAttributedString(string: "Number of participants", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        textField.attributedPlaceholder = placeHolder
        return textField
    }()
    
    private lazy var typeTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.backgroundColor = .white
        textField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textField.heightAnchor.constraint(equalToConstant: 45)
        ])
        var placeHolder = NSAttributedString(string: "Type", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        textField.attributedPlaceholder = placeHolder
        return textField
    }()
    
    private lazy var minPriceTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.backgroundColor = .white
        textField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textField.heightAnchor.constraint(equalToConstant: 45)
        ])
        var placeHolder = NSAttributedString(string: "Min Price", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        textField.attributedPlaceholder = placeHolder
        return textField
    }()
    
    private lazy var maxPriceTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.backgroundColor = .white
        textField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textField.heightAnchor.constraint(equalToConstant: 45)
        ])
        var placeHolder = NSAttributedString(string: "Max Price", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        textField.attributedPlaceholder = placeHolder
        return textField
    }()
    
    private lazy var searchButton: UIButton = {
        let button = UIButton()
        button.setTitle("Search", for: .normal)
        button.backgroundColor = UIColor(red: 255.0/255.0, green: 149.0/255.0, blue: 0.0/255.0, alpha: 1.0)
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.heightAnchor.constraint(equalToConstant: 45)
        ])
        button.clipsToBounds = true
        button.layer.cornerRadius = 5
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        translatesAutoresizingMaskIntoConstraints = false
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
    
    func addGradientBackground(frame: CGRect? = nil) {
        let gradientFrame = frame ?? bounds
        let colorTop =  UIColor(red: 255.0/255.0, green: 149.0/255.0, blue: 0.0/255.0, alpha: 1.0).cgColor
        let colorBottom = UIColor(red: 255.0/255.0, green: 94.0/255.0, blue: 58.0/255.0, alpha: 1.0).cgColor
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.5, 0]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.frame = gradientFrame
        
        layer.insertSublayer(gradientLayer, at:0)
    }
    
    func addCurveTop(frame: CGRect? = nil) {
        let pathFrame = frame ?? bounds
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
}
