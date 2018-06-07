//
//  MGOverlayView.swift
//  MGBottomSheet iOS
//
//  Created by Guillermo García Rebolo on 7/6/18.
//  Copyright © 2018 Guillermo García Rebolo. All rights reserved.
//

import UIKit

class MGOverlayView: UIView {
    
    //MARK: - Public Methods
    
    public func configureView(withView parent: UIView) {
        self.backgroundColor = .clear
        parent.addSubview(self)
        self.translatesAutoresizingMaskIntoConstraints = false
        _ = self.top(withView: parent, toSafeArea: false)
        _ = self.bottom(withView: parent)
        _ = self.leading(withView: parent)
        _ = self.trailing(withView: parent)
    }
    
    public func show(withDelay delay: Double) {
        self.animateBackgroundColor(UIColor(red:0.24, green:0.31, blue:0.33, alpha:0.6), withDelay: delay)
    }
    
    public func hide(withDelay delay: Double) {
        self.animateBackgroundColor(.clear, withDelay: delay)
    }
    
    //MARK: - Private Methods
    
    private func animateBackgroundColor(_ color: UIColor, withDelay delay: Double) {
        UIView.animate(withDuration: 0.2, delay: delay, animations: {
            self.backgroundColor = color
        }, completion: nil)
    }
}
