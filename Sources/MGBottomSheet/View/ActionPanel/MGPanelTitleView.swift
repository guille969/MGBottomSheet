//
//  MGPanelTitleView.swift
//  MGBottomSheet iOS
//
//  Created by Guillermo García Rebolo on 7/6/18.
//  Copyright © 2018 Guillermo García Rebolo. All rights reserved.
//

import UIKit

protocol MGPanelTitleViewDelegate: class {
    func titleDidHide()
}

class MGPanelTitleView: UIView {
    
    public var actionsPanelTitleLabel: UILabel!
    public var heightConstraint: NSLayoutConstraint!
    
    private weak var delegate: MGPanelTitleViewDelegate?
    
    init(withParentView parent: UIView, andDelegate delegate: MGPanelTitleViewDelegate) {
        super.init(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        self.delegate = delegate
        self.configureView(withParent: parent)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //MARK: - Public Methods
    
    public func configureTitle(_ title: String?, withAppearance appearance: MGBottomSheetAppearanceAttributes) {
        if title == nil || title == "" {
            self.hideTitlePanelView()
        }
        else {
            self.actionsPanelTitleLabel.text = title
            self.actionsPanelTitleLabel.font = appearance.textFont;
            self.actionsPanelTitleLabel.textColor = appearance.textColor;
        }
    }
    
    //MARK: - Private Methods
    
    private func configureView(withParent parent: UIView) {
        self.translatesAutoresizingMaskIntoConstraints = false
        parent.addSubview(self)
        _ = self.top(withView: parent)
        _ = self.leading(withView: parent)
        _ = self.trailing(withView: parent)
        self.heightConstraint = self.height(constant: 56.0)
        self.configureTitleLabel()
    }
    
    private func hideTitlePanelView() {
        self.heightConstraint.constant = 0.0
        self.delegate?.titleDidHide()
        self.isHidden = true
    }
    
    private func configureTitleLabel() {
        self.actionsPanelTitleLabel = UILabel()
        self.actionsPanelTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.actionsPanelTitleLabel.textAlignment = .left
        self.actionsPanelTitleLabel.numberOfLines = 1
        self.actionsPanelTitleLabel.font = UIFont.systemFont(ofSize: 18.0, weight: .bold)
        self.addSubview(self.actionsPanelTitleLabel)
        _ = self.actionsPanelTitleLabel.centerY(withView: self)
        _ = self.actionsPanelTitleLabel.leading(withView: self, constant: 16.0)
        _ = self.actionsPanelTitleLabel.trailing(withView: self, constant: -16.0)
    }
}
