//
//  AnimationView.swift
//  AnimationTest
//
//  Created by Wiliam Vabrinskas on 9/30/16.
//  Copyright © 2016 PAProjectDev. All rights reserved.
//

import Foundation
import UIKit

public class CheckMark: UIView {
    private var lineWidth:CGFloat = 4.0
    private var lineColor: CGColor = UIColor.green.cgColor
    
    override public func draw(_ rect: CGRect) {
        super.draw(rect)
    }
    
    private func createCheckmark(rect: CGRect) {
        //checkmark animation
        let startCheck = CASpringAnimation(keyPath: "lineWidth")
        startCheck.damping = 10
        startCheck.toValue = lineWidth
        startCheck.duration = startCheck.settlingDuration
        startCheck.repeatCount = 0
        startCheck.fillMode = kCAFillModeBoth
        startCheck.isRemovedOnCompletion = false
        
        //create checkmark
        let checkShape = CAShapeLayer()
        checkShape.position = CGPoint(x: rect.midX + 15, y: rect.midY - 12)
        checkShape.path = UIBezierPath(rect: CGRect(x: 0, y: 0, width: 30, height: 30)).cgPath
        checkShape.lineWidth = 0
        checkShape.fillColor = UIColor.clear.cgColor
        checkShape.strokeColor = lineColor
        checkShape.strokeStart = 0
        checkShape.strokeEnd = 0.36
        checkShape.setAffineTransform(CGAffineTransform(rotationAngle: 2.4))
        checkShape.add(startCheck, forKey: nil)
        
        //add shapes to layer
        self.layer.addSublayer(checkShape)
    }
    
    private func creatCircle(rect: CGRect) {
        // Create Circle
        let rectShape = CAShapeLayer()
        rectShape.bounds = bounds
        rectShape.position = CGPoint(x: rect.midX, y: rect.midY)
        rectShape.cornerRadius = bounds.width / 2
        rectShape.path = UIBezierPath(ovalIn: rect).cgPath
        rectShape.lineWidth = lineWidth
        rectShape.strokeColor = lineColor
        rectShape.fillColor = UIColor.clear.cgColor
        rectShape.strokeStart = 0
        rectShape.strokeEnd = 0
        
        let easeOut = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        
        let start = CABasicAnimation(keyPath: "strokeStart")
        start.toValue = 0
        let end = CABasicAnimation(keyPath: "strokeEnd")
        end.toValue = 1.0
        
        let group = CAAnimationGroup()
        group.animations = [end,start]
        group.duration = 0.8
        group.autoreverses = false
        group.repeatCount = 0
        group.timingFunction = easeOut
        group.fillMode = kCAFillModeBoth
        group.isRemovedOnCompletion = false
        rectShape.add(group, forKey: nil)
        
        //add shapes to layer
        self.layer.addSublayer(rectShape)
    }
    
    public func setColor(color: CGColor) {
        lineColor = color
    }
    
    public func setLineWidth(width: CGFloat) {
        lineWidth = width
    }
    
    public func start(rect: CGRect) {
        createCheckmark(rect: rect)
        creatCircle(rect: rect)
    }
}
