//
//  ActionSheetCell.swift
//  MGBottomSheetController
//
//  Created by Guillermo García Rebolo on 23/1/17.
//  Copyright © 2017 Guillermo Garcia Rebolo. All rights reserved.
//

import UIKit

class ActionSheetCell: UICollectionViewCell {
    
    @IBOutlet weak var actionImage: UIImageView!
    @IBOutlet weak var actionTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func actionSheetCellWithAction(_ action: ActionSheet, font: UIFont, textColor: UIColor, imageTint: UIColor) {
        self.actionTitleLabel.font = font;
        self.actionTitleLabel.textColor = textColor
        self.actionTitleLabel.text = action.title
        self.actionImage.image = action.iconImage
        
        guard !action.disabled else {
            self.actionTitleLabel.textColor = UIColor.lightGray
            self.actionImage.tintColor = UIColor.lightGray
            self.isUserInteractionEnabled = false
            return
        }
        self.isUserInteractionEnabled = true
        self.actionTitleLabel.textColor = textColor
        guard action.iconImageTint != UIColor.clear else {
            self.actionImage.tintColor = imageTint
            return
        }
        self.actionImage.tintColor = action.iconImageTint
    }

}
