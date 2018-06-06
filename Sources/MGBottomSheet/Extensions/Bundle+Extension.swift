//
//  Bundle+Extension.swift
//  MGBottomSheet iOS
//
//  Created by Guillermo García Rebolo on 6/6/18.
//  Copyright © 2018 Guillermo García Rebolo. All rights reserved.
//

import Foundation

extension Bundle {
    
    //MARK: - Public Methods
    
    //MARK: - Private Methods
    
    public class func libraryBundle() -> Bundle {
        let bundle: Bundle = Bundle(for: ActionSheetCell.self)
        guard let podBundle: Bundle = self.podBundle(fromBundle: bundle) else { return bundle }
        return podBundle
    }
    
    //MARK: - Private Methods
    
    private class func podBundle(fromBundle bundle: Bundle) -> Bundle? {
        guard let bundleURL: URL = bundle.url(forResource: "MGBottomSheet", withExtension: "bundle") else { return nil }
        guard let podBundle: Bundle = Bundle(url: bundleURL) else { return nil }
        return podBundle
    }
}
