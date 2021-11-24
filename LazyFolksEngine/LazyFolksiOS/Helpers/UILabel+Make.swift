//
//  UILabel+Make.swift
//  LazyFolksiOS
//
//  Created by Luis Francisco Piura Mejia on 24/11/21.
//

import UIKit

extension UILabel {
    
    static func makeLabel(
        text: String?,
        numberOfLines: Int,
        textStyle: UIFont.TextStyle,
        textColor: UIColor? = .white
    ) -> UILabel {
        let label = UILabel()
        label.textColor = textColor
        label.font = .preferredFont(forTextStyle: textStyle)
        label.adjustsFontForContentSizeCategory = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = numberOfLines
        label.text = text
        return label
    }
    
}
