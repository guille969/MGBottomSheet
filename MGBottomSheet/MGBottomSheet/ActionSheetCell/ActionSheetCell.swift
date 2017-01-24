//
//  ActionSheetCell.swift
//  MGBottomSheetController
//
//  Created by Guillermo García Rebolo on 23/1/17.
//  Copyright © 2017 Guillermo Garcia Rebolo. All rights reserved.
//

import UIKit

public class ActionSheetCell: UICollectionViewCell {
    
    @IBOutlet weak var actionImage: UIImageView!
    @IBOutlet weak var actionTitleLabel: UILabel!
    
    override public func awakeFromNib() {
        super.awakeFromNib()
    }
    
    public func actionSheetCellWithAction(_ action: ActionSheet, font: UIFont, textColor: UIColor, imageTint: UIColor) {
        self.actionTitleLabel.font = font;
        self.actionTitleLabel.textColor = textColor
        
        self.actionTitleLabel.text = action.title
        self.actionImage.image = action.iconImage
        
        if (!action.disabled) {
            self.actionTitleLabel.textColor = textColor
            self.actionImage.tintColor = imageTint
            self.isUserInteractionEnabled = true;
        }
        else {
            self.actionTitleLabel.textColor = UIColor.lightGray
            self.actionImage.tintColor = UIColor.lightGray
            self.isUserInteractionEnabled = false
        }
    }

}
