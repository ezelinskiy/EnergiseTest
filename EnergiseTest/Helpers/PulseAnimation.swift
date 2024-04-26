//
//  PulseAnimation.swift
//  EnergiseTest
//
//  Created by Evgeniy Zelinskiy on 26.04.2024.
//

import UIKit

class PulseAnimation: CALayer {
   
    var radius: CGFloat = 200.0
    var fromValueForRadius: Float = 0.0
    var fromValueForAlpha: Float = 0.45
    var keyTimeForHalfOpacity: Float = 0.2
    var animationDuration: TimeInterval = 2.0
    var pulseInterval: TimeInterval = 0.0
    var useTimingFunction: Bool = true
    var animationGroup: CAAnimationGroup = CAAnimationGroup()
    var repetitions: Float = Float.infinity
    var manualFrameForAnimation: Bool = false
    var manualAnimationFrame: CGRect = CGRectZero

    override init(layer: Any) {
        super.init(layer: layer)
    }
    
    override public init() {
        super.init()
        
        self.contentsScale = UIScreen.main.scale
        self.opacity = 0.0
        self.backgroundColor = UIColor.blue.cgColor
        self.radius = 60
        self.repetitions = Float.infinity
    }
    
    init(repeatCount: Float=Float.infinity, radius: CGFloat, position: CGPoint) {
        super.init()
        
        self.contentsScale = UIScreen.main.scale
        self.opacity = 0.0
        self.backgroundColor = UIColor.blue.cgColor
        self.radius = radius
        self.repetitions = repeatCount
        self.position = position
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setPulseRadius(radius: CGFloat) {
        self.radius = radius
        let tempPos = self.position
        let diameter = self.radius * 2
        
        self.bounds = CGRect(x: 0.0, y: 0.0, width: diameter, height: diameter)
        self.cornerRadius = self.radius
        self.position = tempPos
    }
    
    func setPulseFrame(frame: CGRect) {
        let tempPos = self.position
        self.bounds = CGRect(x: 0.0, y: 0.0, width: frame.size.width, height: frame.size.height)
        self.cornerRadius = frame.size.height / 2
        self.position = tempPos
    }
    
    func setupAnimationGroup() {
        self.animationGroup = CAAnimationGroup()
        self.animationGroup.duration = self.animationDuration + self.pulseInterval
        self.animationGroup.repeatCount = self.repetitions
        self.animationGroup.isRemovedOnCompletion = false
        
        if self.useTimingFunction {
            let defaultCurve = CAMediaTimingFunction(name: CAMediaTimingFunctionName.default)
            self.animationGroup.timingFunction = defaultCurve
        }
        
        self.animationGroup.animations = [createScaleAnimation(), createOpacityAnimation()]
    }
    
    func createScaleAnimation() -> CABasicAnimation {
        let scaleAnimation = CABasicAnimation(keyPath: "transform.scale.xy")
        scaleAnimation.fromValue = NSNumber(value: self.fromValueForRadius)
        scaleAnimation.toValue = NSNumber(value: 1.0)
        scaleAnimation.duration = self.animationDuration
        
        return scaleAnimation
    }
    
    func createOpacityAnimation() -> CAKeyframeAnimation {
        let opacityAnimation = CAKeyframeAnimation(keyPath: "opacity")
        opacityAnimation.duration = self.animationDuration
        opacityAnimation.values = [self.fromValueForAlpha, 0.8, 0]
        opacityAnimation.keyTimes = [0, self.keyTimeForHalfOpacity as NSNumber, 1]
        opacityAnimation.isRemovedOnCompletion = false
        
        return opacityAnimation
    }
    
    func start() {
        DispatchQueue.global(qos: .background).async {
            self.setupAnimationGroup()
            self.manualFrameForAnimation ? self.setPulseFrame(frame: self.manualAnimationFrame) : self.setPulseRadius(radius: self.radius)
            
            if (self.pulseInterval != Double.infinity) {
                DispatchQueue.main.async {
                    self.add(self.animationGroup, forKey: "pulse")
                }
            }
        }
    }
    
    func stop() {
        self.removeAllAnimations()
    }
    
}
