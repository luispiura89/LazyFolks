//
//  LoadingButton.swift
//  LazyFolksiOS
//
//  Created by Luis Francisco Piura Mejia on 22/11/21.
//

import UIKit

public final class LoadingButton: UIButton {
    
    // MARK: Properties
    
    public var isLoading: Bool {
        get { activityIndicator.isAnimating }
        set {
            if newValue {
                setTitle(nil, for: .normal)
                activityIndicator.startAnimating()
            } else {
                setTitle(title, for: .normal)
                activityIndicator.stopAnimating()
            }
        }
    }
    
    private var title: String?
    
    // MARK: - Subviews
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.color = .white
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(title: String?, color: UIColor?) {
        self.init(frame: .zero)
        self.title = title
        
        setTitle(title, for: .normal)
        backgroundColor = color
        translatesAutoresizingMaskIntoConstraints = false
        clipsToBounds = true
        layer.cornerRadius = 5
        addSubview(activityIndicator)
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor),
            activityIndicator.widthAnchor.constraint(equalToConstant: 20),
            activityIndicator.heightAnchor.constraint(equalToConstant: 20),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    func disableButton() {
        isEnabled = false
        alpha = 0.2
    }
    
    func enableButton() {
        isEnabled = true
        alpha = 1
    }
}
