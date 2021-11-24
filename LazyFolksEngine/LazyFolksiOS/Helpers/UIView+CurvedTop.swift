//
//  UIView+CurvedTop.swift
//  LazyFolksiOS
//
//  Created by Luis Francisco Piura Mejia on 24/11/21.
//

import UIKit

extension UIView {
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
        layer.fillColor = backgroundColor?.cgColor
        layer.strokeColor = backgroundColor?.cgColor
        
        self.layer.insertSublayer(layer, at: 0)
    }
}
