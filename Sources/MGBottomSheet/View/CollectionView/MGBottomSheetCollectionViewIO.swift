//
//  MGBottomSheetCollectionViewIO.swift
//  MGBottomSheet
//
//  Created by Guillermo García Rebolo on 6/6/18.
//  Copyright © 2018 Guillermo García Rebolo. All rights reserved.
//

import Foundation

protocol MGBottomSheetCollectionViewDelegate: class {
    func collectionView(_ collectionView: UICollectionView, didSelectItem item: ActionSheet)
    func collectionView(_ collectionView: UICollectionView, sizeForItemAtIndexPath indexPath: IndexPath) -> CGSize
}

protocol MGBottomSheetCollectionViewDataSource: class {
    func configure(withActions actions: [ActionSheet], withAppearance appearance: MGBottomSheetAppearanceAttributes)
}
