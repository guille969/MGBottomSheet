//
//  MGBottomSheetAppearanceAttributes.swift
//  MGBottomSheetController
//
//  Created by Guillermo García Rebolo on 23/1/17.
//  Copyright © 2017 Guillermo Garcia Rebolo. All rights reserved.
//

import UIKit

/// The class for configure the custom appearance of the bottom sheet
public class MGBottomSheetAppearanceAttributes {
    
    /// Variable to set the text font of the section actions
    public var sectionFont: UIFont
    
    /// Variable to set the text font of the actions
    public var textFont: UIFont

    /// Variable to set the text color of the section actions
    public var sectionColor: UIColor
    
    /// Variable to set the text color of the actions
    public var textColor: UIColor

    /// Variable to set the image tint of the actions
    public var imageTint: UIColor

    
    /// Return the deafult appearance for the MGBottomSheet spinner fully configurable
    open class var `default` : MGBottomSheetAppearanceAttributes {
        get {
            return MGBottomSheetAppearanceAttributes()
        }
    }
    
    //MARK: - Private Methods
    
    private init() {
        self.sectionFont = UIFont.systemFont(ofSize: 16)
        self.textFont = UIFont.systemFont(ofSize: 14)
        self.sectionColor = .lightGray
        self.textColor = .black
        self.imageTint = .black
    }
}
