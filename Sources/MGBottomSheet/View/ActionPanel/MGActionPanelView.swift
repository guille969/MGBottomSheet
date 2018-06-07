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
    func panelDidSelectItem(_ action: ActionSheet)
}

let kActionsViewHeigth = 48.0

class MGActionPanelView: UIView {
    
    public var actionsPanelTitleView: MGPanelTitleView!
    public var collectionView: MGBottomSheetCollectionView!
    public var widthConstraint: NSLayoutConstraint!
    public var heightConstraint: NSLayoutConstraint!
    
    private var leadingConstraint: NSLayoutConstraint!
    private var trailingConstraint: NSLayoutConstraint!
    
    public var columns: Int = 2
    
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
    
    public func configureTitle(_ title: String?, withAppearance appearance: MGBottomSheetAppearanceAttributes) {
        self.actionsPanelTitleView.configureTitle(title, withAppearance: appearance)
    }
    
    public func configureActions(_ actions: [ActionSheet], withAppearance appearance: MGBottomSheetAppearanceAttributes, andView parent: UIView) {
        self.collectionView.configure(withActions: actions, withAppearance: appearance)
        self.resize(forNumberOfAction: actions.count, columns: self.columns, andView: parent)
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
        self.configureConstraints(withParentView: view)
        self.configureSizeClasses()
        self.configureSubViews()
    }
    
    private func configureConstraints(withParentView view: UIView) {
        self.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(self)
        self.leadingConstraint = self.leading(withView: view)
        self.trailingConstraint = self.trailing(withView: view)
        _ = self.bottom(withView: view)
        _ = self.centerX(withView: view)
        self.heightConstraint = self.height(constant: 165.0)
        self.widthConstraint = self.width(constant: 512.0)
    }
    
    private func configureSizeClasses() {
        if self.traitCollection.horizontalSizeClass == .regular && self.traitCollection.verticalSizeClass == .regular {
            self.widthConstraint.isActive = true
            self.leadingConstraint.isActive = false
            self.trailingConstraint.isActive = false
        }
        else {
            self.widthConstraint.isActive = false
            self.leadingConstraint.isActive = true
            self.trailingConstraint.isActive = true
        }
    }
    
    private func configureSubViews() {
        self.actionsPanelTitleView = MGPanelTitleView(withParentView: self, andDelegate: self)
        self.collectionView = MGBottomSheetCollectionView(withView: self, andSibilig: self.actionsPanelTitleView)
        self.collectionView.collectionDelegate = self
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
        guard let width: NSLayoutConstraint = self.widthConstraint, let leading: NSLayoutConstraint = self.leadingConstraint, let trailing: NSLayoutConstraint = self.trailingConstraint else { return }
        
        if traitCollection.horizontalSizeClass == .regular && traitCollection.verticalSizeClass == .regular {
            width.isActive = true
            leading.isActive = false
            trailing.isActive = false
        }
        else {
            width.isActive = false
            leading.isActive = true
            trailing.isActive = true
        }
    }
}

//MARK: - MGPanelTitleViewDelegate

extension MGActionPanelView: MGPanelTitleViewDelegate {
    func titleDidHide() {
        self.collectionView.topConstraint.constant = 8.0
    }
}

extension MGActionPanelView: MGBottomSheetCollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItem item: ActionSheet) {
        self.delegate?.panelDidSelectItem(item)
    }
    
    func collectionView(_ collectionView: UICollectionView, sizeForItemAtIndexPath indexPath: IndexPath) -> CGSize {
        guard UI_USER_INTERFACE_IDIOM() == .pad else { return CGSize(width: self.frame.size.width, height: 48.0) }
        return CGSize(width: self.frame.size.width / CGFloat(self.columns), height: 48.0)
    }
}
