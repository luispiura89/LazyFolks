//
//  UIStackView+Make.swift
//  LazyFolksiOS
//
//  Created by Luis Francisco Piura Mejia on 24/11/21.
//

import UIKit

extension UIStackView {

    static func makeStackView(subviews: [UIView], margins: UIEdgeInsets? = nil, spacing: CGFloat) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: subviews)
        stackView.axis = .vertical
        stackView.spacing = spacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        margins.map { stackView.layoutMargins = $0 }
        stackView.isLayoutMarginsRelativeArrangement = true
        return stackView
    }
    
}
