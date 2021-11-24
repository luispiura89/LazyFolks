//
//  UITextField+Make.swift
//  LazyFolksiOS
//
//  Created by Luis Francisco Piura Mejia on 24/11/21.
//

import UIKit

extension UITextField {
    
    static func makeTexField(placeholder: String?, keyboardType: UIKeyboardType = .default) -> UITextField {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.backgroundColor = .white
        textField.textColor = .darkGray
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.autocorrectionType = .no
        textField.keyboardType = keyboardType
        textField.autocapitalizationType = .none
        NSLayoutConstraint.activate([
            textField.heightAnchor.constraint(equalToConstant: 45)
        ])
        let placeHolder = NSAttributedString(string: placeholder ?? "", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        textField.attributedPlaceholder = placeHolder
        return textField
    }

}
