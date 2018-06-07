//
//  MGBottomSheetHandler.swift
//  MGBottomSheet
//
//  Created by Guillermo García Rebolo on 6/6/18.
//  Copyright © 2018 Guillermo García Rebolo. All rights reserved.
//

import UIKit

public class MGBottomSheetBaseView: UIViewController {
    
    var overlayView: MGOverlayView!
    var actionsPanel: MGActionPanelView!
    
    internal var actions: [ActionSheet] = []
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
        self.actionsPanel.configureActions(self.actions, withAppearance: self.attributes, andView: self.view)
        self.actionsPanel.show()
    }
    
    //MARK: - Internal Methods

    internal func add(action: ActionSheet) {
        self.actions.append(action)
    }
    
    internal func configureBaseView() {
        self.overlayView = MGOverlayView(withView: self.view, andDelegate: self)
        self.actionsPanel = MGActionPanelView(withView: self.view, andDelegate: self)
    }
}

//MARK: - MGActionPanelViewDelegate

extension MGBottomSheetBaseView: MGActionPanelViewDelegate {
    func panelDidSelectItem(_ action: ActionSheet) {
        guard let completion: MGCompletion = action.completion else { return }
        self.actionsPanel.hide()
        self.dismiss(animated: true) {
            completion()
        }
    }
    
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
