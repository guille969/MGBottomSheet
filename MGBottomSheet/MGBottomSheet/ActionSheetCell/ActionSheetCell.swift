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
    
    /**
     Implementation of the method awakeFromNib od UICollectionViewCell
     
     - Author:
     Guillermo Garcia Rebolo
     
     - Version:
     1.0.3
     */
    
    override public func awakeFromNib() {
        super.awakeFromNib()
    }
    
    /**
     Methods for configure an action sheet cell
     
     - Author:
     Guillermo Garcia Rebolo
     
     - returns
     ActionSheetCell instance.
     
     - parameters:
        - action: The action sheet.
        - font: The font for the cell text.
        - textColor: The color for the cell text.
        - imageTint: The tint for the cell image.
     
     - Version:
     1.0.3
     */
    
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
