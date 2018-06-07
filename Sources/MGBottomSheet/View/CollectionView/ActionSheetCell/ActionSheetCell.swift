//
//  ActionSheetCell.swift
//  MGBottomSheetController
//
//  Created by Guillermo García Rebolo on 23/1/17.
//  Copyright © 2017 Guillermo Garcia Rebolo. All rights reserved.
//

import UIKit

class ActionSheetCell: UICollectionViewCell {
    
    private var actionImage: UIImageView!
    private var actionTitleLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.configureView()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    //MARK: - Layout
    
    private func configureView() {
        self.configureImageView()
        self.configureTitleLabel()
    }
    
    private func configureImageView() {
        self.actionImage = UIImageView()
        self.actionImage.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.actionImage)
        _ = self.actionImage.leading(withView: self, constant: 16.0, toSafeArea: false)
        _ = self.actionImage.centerY(withView: self)
        _ = self.actionImage.width(constant: 24.0)
        _ = self.actionImage.height(constant: 24.0)
    }
    
    private func configureTitleLabel() {
        self.actionTitleLabel = UILabel()
        self.actionTitleLabel.font = UIFont.systemFont(ofSize: 17.0, weight: .light)
        self.actionTitleLabel.textColor = .lightGray
        self.actionTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.actionTitleLabel)
        _ = self.actionTitleLabel.left(toRight: self.actionImage, fromView: self, constant: 32.0)
        _ = self.actionTitleLabel.trailing(withView: self, constant: -16.0, toSafeArea: false)
        _ = self.actionTitleLabel.centerY(withView: self)
    }
    
    //MARK: - Public Methods
    
    public func actionSheetCellWithAction(_ action: ActionSheet, font: UIFont, textColor: UIColor, imageTint: UIColor) {
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
