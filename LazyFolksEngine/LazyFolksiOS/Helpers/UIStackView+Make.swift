//
//  UIStackView+Make.swift
//  LazyFolksiOS
//
//  Created by Luis Francisco Piura Mejia on 24/11/21.
//

import UIKit

extension UIStackView {

    static func makeStackView(
        subviews: [UIView],
        margins: UIEdgeInsets? = nil,
        spacing: CGFloat,
        alignment: Alignment = .fill,
        axis: NSLayoutConstraint.Axis = .vertical
    ) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: subviews)
        stackView.axis = axis
        stackView.spacing = spacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        margins.map { stackView.layoutMargins = $0 }
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.alignment = alignment
        return stackView
    }
    
}
