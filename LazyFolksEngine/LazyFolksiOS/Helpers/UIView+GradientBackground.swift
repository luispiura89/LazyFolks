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
        let colorTop =  UIColor.orange1.cgColor
        let colorBottom = UIColor.orange2.cgColor
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0, 1]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.frame = gradientFrame
        
        layer.insertSublayer(gradientLayer, at:0)
    }
}
