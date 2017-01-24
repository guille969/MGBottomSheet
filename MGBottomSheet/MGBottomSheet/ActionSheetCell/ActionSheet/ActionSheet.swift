//
//  ActionSheet.swift
//  MGBottomSheetController
//
//  Created by Guillermo García Rebolo on 23/1/17.
//  Copyright © 2017 Guillermo Garcia Rebolo. All rights reserved.
//

import UIKit

public class ActionSheet: NSObject {
    
    var title = String()
    var iconImage = UIImage()
    var disabled = Bool()
    var completion: (() -> Void)?
    
    override init() {
    }
    
    public class func actionWithTitle(_ title: String, imageIcon: UIImage, completion: (() -> Void)? ) -> ActionSheet {
        
        let actionSheet = ActionSheet()
        actionSheet.title = title;
        actionSheet.iconImage = imageIcon.withRenderingMode(.alwaysTemplate)
        actionSheet.completion = completion
        
        return  actionSheet
    }
    
    public func setActionDisabled() {
        self.disabled = true
    }

}
