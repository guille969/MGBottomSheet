//
//  ViewController.swift
//  iOS Example
//
//  Created by Guillermo García Rebolo on 6/6/18.
//  Copyright © 2018 Guillermo García Rebolo. All rights reserved.
//

import UIKit
import MGBottomSheet

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func tapMenuButton(_ sender: UIButton) {
        self.present(self.generateBottomSheet(), animated: true, completion: nil)
    }
    
    //MARK: - Private Methods
    
    private func generateBottomSheet() -> MGBottomSheet {
        let bottomSheet: MGBottomSheet = MGBottomSheet.mgBottomSheetWithTitle("Actions")
        
        let deleteAction: ActionSheet = ActionSheet.actionWithTitle("DELETE", imageIcon: UIImage(named: "FavouriteFilled")) { [weak self] in
            self?.callback()
        }
        
        let markAction: ActionSheet = ActionSheet.actionWithTitle("MARK", imageIcon: UIImage(named: "FavouriteFilled")) { [weak self] in
            self?.callback()
        }
        
        let lightAction: ActionSheet = ActionSheet.actionWithTitle("LIGHT", imageIcon: UIImage(named: "FavouriteFilled")) { [weak self] in
            self?.callback()
        }
        
        markAction.setActionDisabled()
        
        bottomSheet.addAction(deleteAction)
        bottomSheet.addAction(markAction)
        bottomSheet.addAction(lightAction)
        
        return bottomSheet
    }
    
    private func callback() {
        print("Executed callback")
    }
}

