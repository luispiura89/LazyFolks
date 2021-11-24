//
//  UIView+Make.swift
//  LazyFolksiOS
//
//  Created by Luis Francisco Piura Mejia on 24/11/21.
//

import UIKit

extension UIView {
    static func makeView(color: UIColor?) -> UIView {
        let view = UIView()
        view.backgroundColor = color
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
}
