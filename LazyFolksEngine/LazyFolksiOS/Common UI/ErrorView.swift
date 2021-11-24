//
//  ErrorView.swift
//  LazyFolksiOS
//
//  Created by Luis Francisco Piura Mejia on 22/11/21.
//

import UIKit

public final class ErrorView: UIButton {
    
    // MARK: - Properties
    
    public var message: String? {
        get { title(for: .normal) }
        set { setErrorMessage(message: newValue) }
    }
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.red.withAlphaComponent(0.6)
        translatesAutoresizingMaskIntoConstraints = false
        titleLabel?.numberOfLines = 0
        titleLabel?.textAlignment = .center
        titleLabel?.font = .preferredFont(forTextStyle: .headline)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private methods
    
    private func setErrorMessage(message: String?) {
        setTitle(message, for: .normal)
        
        if message == nil {
            UIView.animate(withDuration: 0.5) { [weak self] in
                self?.alpha = 0
            }
        } else {
            UIView.animate(withDuration: 0.5) { [weak self] in
                self?.alpha = 1
            }
        }
    }
    
}
