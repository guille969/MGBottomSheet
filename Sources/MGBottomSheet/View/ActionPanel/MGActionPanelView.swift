//
//  MGActionPanelView.swift
//  MGBottomSheet iOS
//
//  Created by Guillermo García Rebolo on 7/6/18.
//  Copyright © 2018 Guillermo García Rebolo. All rights reserved.
//

import UIKit

protocol MGActionPanelViewDelegate: class {
    func panelWillShow()
    func panelWillHide()
}

class MGActionPanelView: UIView {
    
    public var widthConstraint: NSLayoutConstraint!
    public var heightConstraint: NSLayoutConstraint!
    
    public var actionsPanelTitleView: MGPanelTitleView!
    public var collectionView: MGBottomSheetCollectionView!
    
    private weak var delegate: MGActionPanelViewDelegate?
    
    init(withView parent: UIView, andDelegate delegate: MGActionPanelViewDelegate) {
        super.init(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        self.delegate = delegate
        self.configure(withParentView: parent)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //MARK: - Public Methods
    
    public func configureTitle(withTitle title: String?, actions: [ActionSheet], appearance: MGBottomSheetAppearanceAttributes, andDelegate delegate: MGBottomSheetCollectionViewDelegate) {
        self.actionsPanelTitleView.configureTitle(title, withAppearance: appearance)
        self.collectionView.collectionDelegate = delegate
        self.collectionView.configure(withActions: actions, withAppearance: appearance)
    }
    
    public func configureView(forNumberOfAction numberActions: Int, columns: Int, andView parent: UIView) {
        self.resize(forNumberOfAction: numberActions, columns: columns, andView: parent)
    }
    
    public func show() {
        self.upDownAnimation(withDirection: 0)
        self.isHidden = false
        self.delegate?.panelWillShow()
    }
    
    public func hide() {
        self.upDownAnimation(withDirection: 1)
        self.isHidden = true
        self.delegate?.panelWillHide()
    }
    
    //MARK: - Private Methods
    
    private func configure(withParentView view: UIView) {
        self.backgroundColor = .white
        self.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(self)
        _ = self.leading(withView: view)
        _ = self.trailing(withView: view)
        _ = self.bottom(withView: view)
        _ = self.centerX(withView: view)
        self.heightConstraint = self.height(constant: 165.0)
        self.widthConstraint = self.width(constant: 512.0)
        self.widthConstraint.isActive = false
        if self.traitCollection.horizontalSizeClass == .regular && self.traitCollection.verticalSizeClass == .regular {
            self.widthConstraint.isActive = true
        }
        self.configureSubViews()
    }
    
    private func configureSubViews() {
        self.actionsPanelTitleView = MGPanelTitleView(withParentView: self, andDelegate: self)
        self.collectionView = MGBottomSheetCollectionView(withView: self, andSibilig: self.actionsPanelTitleView)
    }
    
    private func resize(forNumberOfAction numberActions: Int, columns: Int, andView parent: UIView) {
        var actionsPanelHeight: CGFloat = 0.0
        let maxActionsPanelHeight: CGFloat = (parent.frame.size.height * 0.7)
        let topBottomSpace = self.collectionView.topConstraint.constant + 8
        
        if UI_USER_INTERFACE_IDIOM() == .pad {
            let numberLines:Float = ceilf(Float(numberActions) / Float(columns))
            actionsPanelHeight = self.actionsPanelTitleView.heightConstraint.constant + (CGFloat(kActionsViewHeigth) * CGFloat(numberLines)) + topBottomSpace
        }
        else {
            actionsPanelHeight = self.actionsPanelTitleView.heightConstraint.constant + (CGFloat(kActionsViewHeigth) * CGFloat(numberActions)) + topBottomSpace
        }
        
        if actionsPanelHeight > maxActionsPanelHeight {
            actionsPanelHeight = maxActionsPanelHeight
            self.collectionView.isScrollEnabled = true
        }
        
        self.heightConstraint.constant = actionsPanelHeight
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        guard let width: NSLayoutConstraint = self.widthConstraint else { return }
        
        if traitCollection.horizontalSizeClass == .regular && traitCollection.verticalSizeClass == .regular {
            width.isActive = true
        }
        else { width.isActive = false }
    }
}

//MARK: - MGPanelTitleViewDelegate

extension MGActionPanelView: MGPanelTitleViewDelegate {
    func titleDidHide() {
        self.collectionView.topConstraint.constant = 8.0
    }
}
