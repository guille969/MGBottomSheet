//
//  MGBottomSheet.swift
//  MGBottomSheetController
//
//  Created by Guillermo García Rebolo on 23/1/17.
//  Copyright © 2017 Guillermo Garcia Rebolo. All rights reserved.
//

import UIKit

public class MGBottomSheet: MGBottomSheetBaseView {
    
    /// Number of sheet columns
    public var numberColumns: Int {
        get { return self.columns }
        set { self.columns = newValue }
    }
    
    /// Custom appearance for the MGBottomSheet
    public var appearance: MGBottomSheetAppearanceAttributes {
        get { return self.attributes }
        set { return self.attributes = newValue }
    }
    
    /// Override of the UIKit method viewDidLoad
    override public func viewDidLoad() {
        super.viewDidLoad()
    }
    
    /// Override of the UIKit method viewWillAppear
    ///
    /// - Parameter animated: animated appear
    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    /// Override of the UIKit method didReceiveMemoryWarning
    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: - Layout
    
    /// Creates an instance for use the MGBottomSheet in your code and let you access to its methods
    ///
    /// - Parameter title: The main title of the bottom sheet.
    /// - Returns: MGBottomSheet instance
    public class func mgBottomSheetWithTitle(_ title: String?) -> MGBottomSheet {
        let view = MGBottomSheet(nibName: "MGBottomSheet", bundle: Bundle.libraryBundle())
        
        view.titlePanel = title
        view.attributes = .default
        view.modalTransitionStyle = .crossDissolve
        view.columns = 2
        
        return view
    }
    
    /// Adds an action to the bottom sheet
    ///
    /// - Parameter action: Bottom sheet action
    public func addAction(_ action: ActionSheet) {
        self.add(action: action)
    }
}
