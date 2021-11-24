//
//  UIView+GradientBackground.swift
//  LazyFolksiOS
//
//  Created by Luis Francisco Piura Mejia on 24/11/21.
//

import UIKit

extension UIView {
    func addGradientBackground(frame: CGRect? = nil) {
        let gradientFrame = frame ?? bounds
        let colorTop =  UIColor(named: "Orange1", in: Bundle(for: Self.self), compatibleWith: nil)?.cgColor
        let colorBottom = UIColor(named: "Orange2", in: Bundle(for: Self.self), compatibleWith: nil)?.cgColor
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop ?? UIColor.white.cgColor, colorBottom ?? UIColor.white.cgColor]
        gradientLayer.locations = [0, 1]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.frame = gradientFrame
        
        layer.insertSublayer(gradientLayer, at:0)
    }
}
