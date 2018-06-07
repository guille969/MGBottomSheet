//
//  MGBottomSheetHandler.swift
//  MGBottomSheet
//
//  Created by Guillermo García Rebolo on 6/6/18.
//  Copyright © 2018 Guillermo García Rebolo. All rights reserved.
//

import UIKit

let kActionSheetCellIdentifier = "ActionSheetCell"
let kActionsViewHeigth = 48.0

public class MGBottomSheetBaseView: UIViewController {
    
    var overlayView: MGOverlayView!
    var actionsPanel: MGActionPanelView!
    var actionsPanelTitleView: UIView!
    var actionsPanelTitleLabel: UILabel!
    var collectionView: MGBottomSheetCollectionView!
    var actionsPanelHeightConstraint: NSLayoutConstraint!
    var panelTitleViewHeightConstraint: NSLayoutConstraint!
    var collectionViewTopConstraint: NSLayoutConstraint!
    
    internal var actions: [ActionSheet] = []
    internal var tap: UITapGestureRecognizer?
    internal var titlePanel: String?
    internal var columns: Int = 2
    internal var attributes: MGBottomSheetAppearanceAttributes = .default
    
    /// Override of the UIKit method viewDidLoad
    override public func viewDidLoad() {
        super.viewDidLoad()
        self.configureBaseView()
    }
    
    /// Override of the UIKit method viewWillAppear
    ///
    /// - Parameter animated: animated appear
    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.configureView()
    }
    
    /// Override of the UIKit method didReceiveMemoryWarning
    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: - Layout
    
    private func configureView() {
        self.configureLabels()
        self.resizeView(forNumberOfAction: self.actions.count)
        self.collectionView.collectionDelegate = self
        self.collectionView.configure(withActions: self.actions, withAppearance: self.attributes)
        self.showActionsPanel()
    }
    
    private func configureLabels() {
        if self.titlePanel == nil || self.titlePanel == "" {
            self.hideTitlePanelView()
        }
        else {
            self.actionsPanelTitleLabel.text = self.titlePanel
            self.actionsPanelTitleLabel.font = self.attributes.textFont;
            self.actionsPanelTitleLabel.textColor = self.attributes.textColor;
        }
    }
    
    private func showActionsPanel() {
        self.actionsPanel.upDownAnimation(withDirection: 0)
        self.actionsPanel.isHidden = false
        self.overlayView.show(withDelay: 0.2)
    }
    
    private func hideActionsPanel() {
        self.actionsPanel.upDownAnimation(withDirection: 1)
        self.actionsPanel.isHidden = true
        self.overlayView.hide(withDelay: 0.2)
    }
    
    private func hideTitlePanelView() {
        self.panelTitleViewHeightConstraint.constant = 0.0
        self.collectionViewTopConstraint.constant = 8.0
        self.actionsPanelTitleView.isHidden = true
    }
    
    //MARK: - Internal Methods

    internal func add(action: ActionSheet) {
        self.actions.append(action)
    }
    
    //MARK: - Private Methos
    
    private func resizeView(forNumberOfAction numberActions: Int) {
        var actionsPanelHeight:CGFloat = 0.0
        let maxActionsPanelHeight:CGFloat = (self.view.frame.size.height * 0.7)
        let topBottomSpace = self.collectionViewTopConstraint.constant + 8
        
        if UI_USER_INTERFACE_IDIOM() == .pad {
            let numberLines:Float = ceilf(Float(numberActions) / Float(columns))
            actionsPanelHeight = self.panelTitleViewHeightConstraint.constant + (CGFloat(kActionsViewHeigth) * CGFloat(numberLines)) + topBottomSpace
        }
        else {
            actionsPanelHeight = self.panelTitleViewHeightConstraint.constant + (CGFloat(kActionsViewHeigth) * CGFloat(numberActions)) + topBottomSpace
        }
        
        if actionsPanelHeight > maxActionsPanelHeight {
            actionsPanelHeight = maxActionsPanelHeight
            self.collectionView.isScrollEnabled = true
        }
        
        self.actionsPanelHeightConstraint.constant = actionsPanelHeight
    }
    
    //MARK: - Actions
    
    @objc func dismissBottomSheet(_ sender: UITapGestureRecognizer) {
        self.hideActionsPanel()
        self.dismiss(animated: true, completion: nil)
    }
}

//MARK: - MGBottomSheetCollectionViewDelegate

extension MGBottomSheetBaseView: MGBottomSheetCollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItem item: ActionSheet) {
        guard let completion: MGCompletion = item.completion else { return }
        self.hideActionsPanel()
        self.dismiss(animated: true) {
            completion()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, sizeForItemAtIndexPath indexPath: IndexPath) -> CGSize {
        guard UI_USER_INTERFACE_IDIOM() == .pad else { return CGSize(width: self.actionsPanel.frame.size.width, height: 48.0) }
        return CGSize(width: self.actionsPanel.frame.size.width / CGFloat(self.columns), height: 48.0)
    }
}
