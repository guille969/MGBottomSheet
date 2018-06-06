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
}
