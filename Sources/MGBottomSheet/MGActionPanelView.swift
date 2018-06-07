//
//  MGActionPanelView.swift
//  MGBottomSheet iOS
//
//  Created by Guillermo García Rebolo on 7/6/18.
//  Copyright © 2018 Guillermo García Rebolo. All rights reserved.
//

import UIKit

class MGActionPanelView: UIView {
    
    private var widthConstraint: NSLayoutConstraint!
    
    //MARK: - Public Methods
    
    public func configure(withParentView view: UIView) {
        self.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(self)
        _ = self.leading(withView: view)
        _ = self.trailing(withView: view)
        _ = self.bottom(withView: view)
        _ = self.centerX(withView: view)
        self.widthConstraint = self.width(constant: 512.0)
        self.widthConstraint.isActive = false
        if self.traitCollection.horizontalSizeClass == .regular && self.traitCollection.verticalSizeClass == .regular {
            self.widthConstraint.isActive = true
        }
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        if traitCollection.horizontalSizeClass == .regular && traitCollection.verticalSizeClass == .regular {
            self.widthConstraint.isActive = true
        }
        else { self.widthConstraint.isActive = false }
    }
}
