//
//  ActionSheet.swift
//  MGBottomSheetController
//
//  Created by Guillermo García Rebolo on 23/1/17.
//  Copyright © 2017 Guillermo Garcia Rebolo. All rights reserved.
//

import UIKit

/// The MGBottomSheet completion
public typealias MGCompletion = () -> Void

/// The class for the actions of the MGBottomSheet
public class ActionSheet {
    
    var title: String
    var iconImage: UIImage
    var iconImageTint: UIColor
    var disabled: Bool
    var completion: MGCompletion?
    
    init() {
        self.title = ""
        self.iconImage = UIImage()
        self.iconImageTint = .blue
        self.disabled = false
        self.completion = nil
    }
    
    /// Clas methods for instantiate an ActionSheet
    ///
    /// - Parameters:
    ///   - title: The main title of the action sheet.
    ///   - imageIcon: Image of the action sheet.
    ///   - completion: action for execute when the action sheet is selected.
    /// - Returns: ActionSheet instance
    public class func actionWithTitle(_ title: String, imageIcon: UIImage, completion: MGCompletion? = nil) -> ActionSheet {
        let actionSheet = ActionSheet()
        actionSheet.title = title;
        actionSheet.iconImage = imageIcon.withRenderingMode(.alwaysTemplate)
        actionSheet.iconImageTint = UIColor.clear
        actionSheet.completion = completion
        
        return  actionSheet
    }
    
    /// Disables a desired action of the MGBottomSheet
    public func setActionDisabled() {
        self.disabled = true
    }
    
    /// Sets the image tint of the action for MGBottomSheet
    ///
    /// - Parameter imageTint: The color for the image tint of the action.
    public func setActionImageColor(_ imageTint: UIColor) {
        self.iconImageTint = imageTint
    }

}
