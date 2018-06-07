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
    
    private func configureBaseView() {
        self.overlayView = MGOverlayView(withView: self.view, andDelegate: self)
        self.actionsPanel = MGActionPanelView(withView: self.view, andDelegate: self)
    }
    
    private func configureView() {
        self.actionsPanel.configureTitle(withTitle: self.titlePanel, actions: self.actions, appearance: self.attributes, andDelegate: self)
        self.actionsPanel.configureView(forNumberOfAction: self.actions.count, columns: self.columns, andView: self.view)
        self.actionsPanel.show()
    }
    
    //MARK: - Internal Methods

    internal func add(action: ActionSheet) {
        self.actions.append(action)
    }
}

//MARK: - MGBottomSheetCollectionViewDelegate

extension MGBottomSheetBaseView: MGBottomSheetCollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItem item: ActionSheet) {
        guard let completion: MGCompletion = item.completion else { return }
        self.actionsPanel.hide()
        self.dismiss(animated: true) {
            completion()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, sizeForItemAtIndexPath indexPath: IndexPath) -> CGSize {
        guard UI_USER_INTERFACE_IDIOM() == .pad else { return CGSize(width: self.actionsPanel.frame.size.width, height: 48.0) }
        return CGSize(width: self.actionsPanel.frame.size.width / CGFloat(self.columns), height: 48.0)
    }
}

//MARK: - MGActionPanelViewDelegate

extension MGBottomSheetBaseView: MGActionPanelViewDelegate {
    func panelWillShow() {
        self.overlayView.show(withDelay: 0.2)
    }
    
    func panelWillHide() {
        self.overlayView.hide(withDelay: 0.2)
    }
}

//MARK: - MGOverlayViewDelegate

extension MGBottomSheetBaseView: MGOverlayViewDelegate {
    func didTapView() {
        self.actionsPanel.hide()
        self.dismiss(animated: true, completion: nil)
    }
}
