//
//  UIView+Extension.swift
//  MGBottomSheet iOS
//
//  Created by Guillermo García Rebolo on 6/6/18.
//  Copyright © 2018 Guillermo García Rebolo. All rights reserved.
//

import UIKit

extension UIView {
    
    func upDownAnimation(withDirection direction: Int) {
        let subType:String = direction == 0 ? kCATransitionFromTop : kCATransitionFromBottom
        
        let animation:CATransition = CATransition.init()
        animation.fillMode = kCAFillModeBoth
        animation.duration = 0.4
        animation.timingFunction = CAMediaTimingFunction.init(name: kCAMediaTimingFunctionEaseInEaseOut)
        animation.type = kCATransitionPush
        animation.subtype = subType
        
        self.layer.add(animation, forKey: "transition")
    }
    
    func top(withView view: UIView, constant: CGFloat = 0.0, toSafeArea safeArea: Bool = true) -> NSLayoutConstraint {
        guard #available(iOS 11, *), safeArea else {
            let constraint: NSLayoutConstraint = NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1.0, constant: constant)
            view.addConstraint(constraint)
            return constraint
        }
        let guide = view.safeAreaLayoutGuide
        let constraint: NSLayoutConstraint = self.topAnchor.constraint(equalTo: guide.topAnchor, constant: constant)
        constraint.isActive = true
        return constraint
    }
    
    func bottom(withView view: UIView, constant: CGFloat = 0.0, toSafeArea safeArea: Bool = true) -> NSLayoutConstraint {
        guard #available(iOS 11, *), safeArea else {
            let constraint: NSLayoutConstraint = NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1.0, constant: constant)
            view.addConstraint(constraint)
            return constraint
        }
        let guide = view.safeAreaLayoutGuide
        let constraint: NSLayoutConstraint = self.bottomAnchor.constraint(equalTo: guide.bottomAnchor, constant: constant)
        constraint.isActive = true
        return constraint
    }
    
    func leading(withView view: UIView, constant: CGFloat = 0.0, toSafeArea safeArea: Bool = true) -> NSLayoutConstraint {
        guard #available(iOS 11, *), safeArea else {
            let constraint: NSLayoutConstraint = NSLayoutConstraint(item: self, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1.0, constant: constant)
            view.addConstraint(constraint)
            return constraint
        }
        let guide = view.safeAreaLayoutGuide
        let constraint: NSLayoutConstraint = self.leftAnchor.constraint(equalTo: guide.leftAnchor, constant: constant)
        constraint.isActive = true
        return constraint
    }
    
    func trailing(withView view: UIView, constant: CGFloat = 0.0, toSafeArea safeArea: Bool = true) -> NSLayoutConstraint {
        guard #available(iOS 11, *), safeArea else {
            let constraint: NSLayoutConstraint = NSLayoutConstraint(item: self, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1.0, constant: constant)
            view.addConstraint(constraint)
            return constraint
        }
        let guide = view.safeAreaLayoutGuide
        let constraint: NSLayoutConstraint = self.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: constant)
        constraint.isActive = true
        return constraint
    }
    
    func width(constant: CGFloat = 0.0, multiplier: CGFloat = 1.0) -> NSLayoutConstraint {
        let constraint: NSLayoutConstraint = NSLayoutConstraint(item: self, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: multiplier, constant: constant)
        self.addConstraint(constraint)
        return constraint
    }
    
    func height(constant: CGFloat = 0.0, multiplier: CGFloat = 1.0) -> NSLayoutConstraint {
        let constraint: NSLayoutConstraint = NSLayoutConstraint(item: self, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: multiplier, constant: constant)
        self.addConstraint(constraint)
        return constraint
    }
    
    func relationalHeight(toView view: UIView, multiplier: CGFloat = 1.0, constant: CGFloat = 0.0) -> NSLayoutConstraint {
        let constraint: NSLayoutConstraint = NSLayoutConstraint(item: self, attribute: .height, relatedBy: .equal, toItem: view, attribute: .height, multiplier: multiplier, constant: constant)
        view.addConstraint(constraint)
        return constraint
    }
    
    func relationalWidth(toView view: UIView, multiplier: CGFloat = 1.0, constant: CGFloat = 0.0) -> NSLayoutConstraint {
        let constraint: NSLayoutConstraint = NSLayoutConstraint(item: self, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: multiplier, constant: constant)
        view.addConstraint(constraint)
        return constraint
    }
    
    func centerX(withView view: UIView, constant: CGFloat = 0.0) -> NSLayoutConstraint {
        let constraint: NSLayoutConstraint = NSLayoutConstraint(item: self, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: constant)
        view.addConstraint(constraint)
        return constraint
    }
    
    func centerY(withView view: UIView, constant: CGFloat = 0.0) -> NSLayoutConstraint {
        let constraint: NSLayoutConstraint = NSLayoutConstraint(item: self, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1, constant: constant)
        view.addConstraint(constraint)
        return constraint
    }
    
    func top(toBottom view: UIView, fromView parent: UIView, constant: CGFloat = 0.0) -> NSLayoutConstraint {
        let constraint: NSLayoutConstraint = NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: constant)
        parent.addConstraint(constraint)
        return constraint
    }
    
    func left(toRight view: UIView, fromView parent: UIView, constant: CGFloat = 0.0) -> NSLayoutConstraint {
        let constraint: NSLayoutConstraint = NSLayoutConstraint(item: self, attribute: .left, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1, constant: constant)
        parent.addConstraint(constraint)
        return constraint
    }
}
