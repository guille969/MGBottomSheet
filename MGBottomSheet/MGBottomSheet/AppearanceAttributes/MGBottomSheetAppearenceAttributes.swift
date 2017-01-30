//
//  MGBottomSheetAppearanceAttributes.swift
//  MGBottomSheetController
//
//  Created by Guillermo García Rebolo on 23/1/17.
//  Copyright © 2017 Guillermo Garcia Rebolo. All rights reserved.
//

import UIKit

public class MGBottomSheetAppearanceAttributes: NSObject {
    
    /**
     Variable to set the text font of the section actions
     
     - Author:
     Guillermo Garcia Rebolo
     
     - Version:
     1.0.3
     */
    
    public var sectionFont = UIFont()
    
    /**
     Variable to set the text font of the actions
     
     - Author:
     Guillermo Garcia Rebolo
     
     - Version:
     1.0.3
     */
    
    public var textFont = UIFont()
    
    /**
     Variable to set the text color of the section actions
     
     - Author:
     Guillermo Garcia Rebolo
     
     - Version:
     1.0.3
     */
    
    public var sectionColor = UIColor()
    
    /**
     Variable to set the text color of the actions
     
     - Author:
     Guillermo Garcia Rebolo
     
     - Version:
     1.0.3
     */
    
    public var textColor = UIColor()
    
    /**
     Variable to set the image tint of the actions
     
     - Author:
     Guillermo Garcia Rebolo
     
     - Version:
     1.0.3
     */
    
    public var imageTint = UIColor()
    
    /**
     Class method for configure the initial appearance of the MGBottomSheet
     
     - Author:
     Guillermo Garcia Rebolo
     
     - Version:
     1.0.3
     */
    
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
