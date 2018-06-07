//
//  MGBottomSheetBaseView+Configuration.swift
//  MGBottomSheet
//
//  Created by Guillermo García Rebolo on 7/6/18.
//  Copyright © 2018 Guillermo García Rebolo. All rights reserved.
//

extension MGBottomSheetBaseView {
    
    func configureBaseView() {
        self.enableSafeArea()
        self.configureOverlay()
        self.configureActionsPanel()
        self.configurePatientTitleView()
        self.configureCollectionView()
        self.configureTitleLabel()
    }
    
    private func enableSafeArea() {
        guard #available(iOS 11, *) else { return }
        let guide: UILayoutGuide = self.view.safeAreaLayoutGuide
        self.view.leadingAnchor.constraint(equalTo: guide.leadingAnchor).isActive = true
        self.view.trailingAnchor.constraint(equalTo: guide.trailingAnchor).isActive = true
        self.view.topAnchor.constraint(equalTo: guide.topAnchor).isActive = true
        self.view.bottomAnchor.constraint(equalTo: guide.bottomAnchor).isActive = true
        self.view.layoutIfNeeded()
    }
    
    private func configureOverlay() {
        self.overlayView = UIView()
        self.overlayView.backgroundColor = UIColor(red:0.24, green:0.31, blue:0.33, alpha:0.6)
        self.overlayView.fillView(self.view)
        self.tap = UITapGestureRecognizer(target: self, action: #selector(dismissBottomSheet(_:)))
        guard let tap: UITapGestureRecognizer = self.tap else { return }
        self.overlayView.addGestureRecognizer(tap)
    }
    
    private func configureActionsPanel() {
        self.actionsPanel = MGActionPanelView()
        self.actionsPanel.configure(withParentView: self.view)
        self.actionsPanelHeightConstraint = self.actionsPanel.height(constant: 165.0)
    }
    
    private func configurePatientTitleView() {
        self.actionsPanelTitleView = UIView()
        self.actionsPanelTitleView.translatesAutoresizingMaskIntoConstraints = false
        self.actionsPanel.addSubview(self.actionsPanelTitleView)
        _ = self.actionsPanelTitleView.top(withView: self.actionsPanel)
        _ = self.actionsPanelTitleView.leading(withView: self.actionsPanel)
        _ = self.actionsPanelTitleView.trailing(withView: self.actionsPanel)
        self.panelTitleViewHeightConstraint = self.actionsPanelTitleView.height(constant: 56.0)
    }
    
    private func configureCollectionView() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        self.collectionView = MGBottomSheetCollectionView(frame: CGRect(x: 0, y: 0, width: 100, height: 50), collectionViewLayout: layout)
        self.collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.actionsPanel.addSubview(self.collectionView)
        _ = self.collectionView.leading(withView: self.actionsPanel)
        _ = self.collectionView.trailing(withView: self.actionsPanel)
        _ = self.collectionView.bottom(withView: self.actionsPanel)
        self.collectionViewTopConstraint = self.collectionView.top(toBottom: self.actionsPanelTitleView, fromView: self.actionsPanel)
    }
    
    private func configureTitleLabel() {
        self.actionsPanelTitleLabel = UILabel()
        self.actionsPanelTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.actionsPanelTitleLabel.textAlignment = .left
        self.actionsPanelTitleLabel.numberOfLines = 1
        self.actionsPanelTitleLabel.font = UIFont.systemFont(ofSize: 18.0, weight: .bold)
        self.actionsPanelTitleView.addSubview(self.actionsPanelTitleLabel)
        _ = self.actionsPanelTitleLabel.centerY(withView: self.actionsPanelTitleView)
        _ = self.actionsPanelTitleLabel.leading(withView: self.actionsPanelTitleView, constant: 16.0)
        _ = self.actionsPanelTitleLabel.trailing(withView: self.actionsPanelTitleView, constant: -16.0)
    }
}
