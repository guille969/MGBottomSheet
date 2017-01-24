//
//  MGBottomSheetAppearanceAttributes.swift
//  MGBottomSheetController
//
//  Created by Guillermo García Rebolo on 23/1/17.
//  Copyright © 2017 Guillermo Garcia Rebolo. All rights reserved.
//

import UIKit

public class MGBottomSheetAppearanceAttributes: NSObject {
    
    public var sectionFont = UIFont()
    public var textFont = UIFont()
    public var sectionColor = UIColor()
    public var textColor = UIColor()
    public var imageTint = UIColor()
        
    public class func configureDefaultTextStyle() -> MGBottomSheetAppearanceAttributes {
        let appearanceAttributes = MGBottomSheetAppearanceAttributes()
        
        appearanceAttributes.sectionFont = UIFont.systemFont(ofSize: 16)
        appearanceAttributes.textFont = UIFont.systemFont(ofSize: 14)
        
        appearanceAttributes.sectionColor = UIColor.lightGray
        appearanceAttributes.textColor = UIColor.black
        
        appearanceAttributes.imageTint = UIColor.black
        
        return appearanceAttributes
    }

}
