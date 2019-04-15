//
//  AnimationView.swift
//  AnimationTest
//
//  Created by Wiliam Vabrinskas on 9/30/16.
//  Copyright © 2016 PAProjectDev. All rights reserved.
//

import UIKit

open class WVCheckMark: UIView {
    fileprivate var lineWidth:CGFloat = 4.0
    fileprivate var lineColor: CGColor = UIColor.green.cgColor
    fileprivate var loadingLineColor: CGColor = UIColor.darkGray.cgColor
    fileprivate var duration: CGFloat = 0.8
    fileprivate var damping: CGFloat = 10
    fileprivate var originalRect: CGRect!
    
    override open func draw(_ rect: CGRect) {
        super.draw(rect)
        originalRect = rect
    }
    
    fileprivate func springAnimation() -> CASpringAnimation {
        //checkmark animation
        let spring = CASpringAnimation(keyPath: "lineWidth")
        spring.damping = damping
        spring.toValue = lineWidth
        spring.duration = spring.settlingDuration
        spring.repeatCount = 0
        spring.fillMode = .both
        spring.isRemovedOnCompletion = false
        return spring
    }
    
    fileprivate func createX(rect: CGRect) {
        
        creatCircle(rect: rect)
        
        let plusShapeLeft = CAShapeLayer()
        plusShapeLeft.position = CGPoint(x: 0, y: 0)
        plusShapeLeft.lineWidth = 0
        plusShapeLeft.strokeColor = lineColor
        let pathLeft = UIBezierPath()
        pathLeft.move(to: CGPoint(x: rect.midX - 10, y: rect.midY - 10))
        pathLeft.addLine(to: CGPoint(x: rect.midX + 10, y: rect.midY + 10))
        plusShapeLeft.path = pathLeft.cgPath
        plusShapeLeft.add(springAnimation(), forKey: nil)
        
        let plusShapeRight = CAShapeLayer()
        plusShapeRight.position = CGPoint(x: 0, y: 0)
        plusShapeRight.lineWidth = 0
        plusShapeRight.strokeColor = lineColor
        let pathRight = UIBezierPath()
        pathRight.move(to: CGPoint(x: rect.midX + 10, y: rect.midY - 10))
        pathRight.addLine(to: CGPoint(x: rect.midX - 10, y: rect.midY + 10))
        plusShapeRight.path = pathRight.cgPath
        plusShapeRight.add(springAnimation(), forKey: nil)
        
        self.layer.addSublayer(plusShapeRight)
        self.layer.addSublayer(plusShapeLeft)
    }
    
    fileprivate func createCheckmark(rect: CGRect) {
        creatCircle(rect: originalRect)
        
        //create checkmark
        let checkShape = CAShapeLayer()
        checkShape.position = CGPoint(x: rect.midX + (rect.size.width * 0.25), y: rect.midY - (rect.size.height * 0.15))
        checkShape.path = UIBezierPath(rect: CGRect(x: 0, y: 0, width: rect.size.width / 2, height: rect.size.height / 2)).cgPath
        checkShape.lineWidth = 0
        checkShape.fillColor = UIColor.clear.cgColor
        checkShape.strokeColor = lineColor
        checkShape.strokeStart = 0
        checkShape.strokeEnd = 0.36
        checkShape.setAffineTransform(CGAffineTransform(rotationAngle: 2.4))
        checkShape.add(springAnimation(), forKey: nil)
        
        //add shapes to layer
        self.layer.addSublayer(checkShape)
    }
    
    fileprivate func createStroke(rect: CGRect) {
        let rectShape = CAShapeLayer()
        rectShape.bounds = bounds
        rectShape.position = CGPoint(x: rect.midX, y: rect.midY)
        rectShape.cornerRadius = bounds.width / 2
        rectShape.path = UIBezierPath(ovalIn: rect).cgPath
        rectShape.lineWidth = lineWidth
        rectShape.strokeColor = loadingLineColor
        rectShape.fillColor = UIColor.clear.cgColor
        rectShape.strokeStart = 0
        rectShape.strokeEnd = 0
        
        let start = CABasicAnimation(keyPath: "strokeStart")
        start.toValue = 1.0
        start.beginTime = CFTimeInterval(duration / 2.0)
        start.speed = 2.0
        let end = CABasicAnimation(keyPath: "strokeEnd")
        end.toValue = 1.0
        
        let group = CAAnimationGroup()
        group.animations = [end,start]
        group.duration = CFTimeInterval(duration)
        group.autoreverses = false
        group.repeatCount = .infinity
        group.timingFunction = nil
        group.fillMode = .both
        group.isRemovedOnCompletion = false
        rectShape.add(group, forKey: nil)
        
        //add shapes to layer
        self.layer.addSublayer(rectShape)
    }
    
    fileprivate func creatCircle(rect: CGRect) {
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
        
        let easeOut = CAMediaTimingFunction(name: .easeOut)
        
        let start = CABasicAnimation(keyPath: "strokeStart")
        start.toValue = 0
        let end = CABasicAnimation(keyPath: "strokeEnd")
        end.toValue = 1.0
        
        let group = CAAnimationGroup()
        group.animations = [end,start]
        group.duration = CFTimeInterval(duration)
        group.autoreverses = false
        group.repeatCount = 0
        group.timingFunction = easeOut
        group.fillMode = .both
        group.isRemovedOnCompletion = false
        rectShape.add(group, forKey: nil)
        
        //add shapes to layer
        self.layer.addSublayer(rectShape)
    }
    
    open func set(color:CGColor, width: CGFloat, damping: CGFloat, duration: CGFloat) {
        setColor(color: color)
        setLineWidth(width: width)
        setDamping(damp: damping)
        setDuration(speed: duration)
    }
    
    open func setColor(color: CGColor) {
        lineColor = color
    }
    
    open func setLineWidth(width: CGFloat) {
        lineWidth = width
    }
    
    open func setLoadingLineColor(color: CGColor) {
        loadingLineColor = color
    }
    
    open func setDuration(speed: CGFloat) {
        duration = speed
    }
    
    open func setDamping(damp: CGFloat) {
        damping = damp
    }
    
    open func start(completion: (() -> Void)? = nil) {
        clear()
        
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        
        createCheckmark(rect: originalRect)
        CATransaction.commit()
    }
    
    open func startX(completion: (() -> Void)? = nil) {
        clear()
        
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        
        createX(rect: originalRect)
        CATransaction.commit()
    }
    
    open func startLoading() {
        clear()
        createStroke(rect: originalRect)
    }
    
    fileprivate func clear() {
        if let t = self.layer.sublayers {
            for l in t {
                if l is CAShapeLayer {
                    l.removeFromSuperlayer()
                }
            }
        }
        
    }
    
}

