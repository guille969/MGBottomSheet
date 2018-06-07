//
//  MGBottomSheetCollectionView.swift
//  MGBottomSheet iOS
//
//  Created by Guillermo García Rebolo on 6/6/18.
//  Copyright © 2018 Guillermo García Rebolo. All rights reserved.
//

import UIKit

class MGBottomSheetCollectionView: UICollectionView {
    
    public weak var collectionDelegate: MGBottomSheetCollectionViewDelegate?
    private var actions: [ActionSheet] = []
    private var attributes: MGBottomSheetAppearanceAttributes!
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        self.configureView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.configureView()
    }
    
    //MARK: - Layout
    
    private func configureView() {
        self.registerCells()
        self.backgroundColor = .white
        self.delegate = self
        self.dataSource = self
    }
    
    fileprivate func registerCells() {
        self.register(UINib(nibName: "ActionSheetCell", bundle: Bundle.libraryBundle()), forCellWithReuseIdentifier: kActionSheetCellIdentifier)
    }

}

//MARK: - CollectionViewDataSource

extension MGBottomSheetCollectionView: UICollectionViewDataSource {
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1;
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.actions.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kActionSheetCellIdentifier, for: indexPath)
        guard let actionSheetCell: ActionSheetCell = cell as? ActionSheetCell else { return cell}
        actionSheetCell.actionSheetCellWithAction(self.actions[indexPath.row], font: self.attributes.textFont, textColor: self.attributes.textColor, imageTint: self.attributes.imageTint)
        return actionSheetCell
    }
}

//MARK: - UICollectionViewDelegate

extension MGBottomSheetCollectionView: UICollectionViewDelegate {
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let action: ActionSheet = self.actions[indexPath.row]
        self.collectionDelegate?.collectionView(self, didSelectItem: action)
    }
}

//MARK: - UICollectionViewDelegateFlowLayout

extension MGBottomSheetCollectionView: UICollectionViewDelegateFlowLayout {
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let size: CGSize = self.collectionDelegate?.collectionView(collectionView, sizeForItemAtIndexPath: indexPath) else { return .zero }
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0.0, left: 0.0, bottom: 8.0, right: 0.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
}

//MARK: - MGBottomSheetCollectionViewDataSource

extension MGBottomSheetCollectionView: MGBottomSheetCollectionViewDataSource {
    func configure(withActions actions: [ActionSheet], withAppearance appearance: MGBottomSheetAppearanceAttributes) {
        self.actions = actions
        self.attributes = appearance
        self.reloadData()
    }
}
