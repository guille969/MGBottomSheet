//
//  MGBottomSheet.swift
//  MGBottomSheetController
//
//  Created by Guillermo García Rebolo on 23/1/17.
//  Copyright © 2017 Guillermo Garcia Rebolo. All rights reserved.
//

import UIKit

let kActionSheetCellIdentifier = "ActionSheetCell"
let kActionsViewHeigth = 48.0

public class MGBottomSheet: UIViewController {
    
    public enum MGBottomSheetNumColumns : CGFloat {
        case oneColumn = 1
        case twoColumns = 2
    }

    @IBOutlet weak var overlayView: UIView!
    @IBOutlet weak var actionsPanel: UIView!
    @IBOutlet weak var actionsPanelTitleView: UIView!
    @IBOutlet weak var actionsPanelTitleLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var actionsPanelHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var panelTitleViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var collectionViewTopConstraint: NSLayoutConstraint!
    
    fileprivate var actions: Array<ActionSheet> = []
    fileprivate var tap = UITapGestureRecognizer()
    fileprivate var titlePanel: String?
    fileprivate var numberColumns : CGFloat = MGBottomSheetNumColumns.oneColumn.rawValue
    
    /**
     Variable to set a custom appearance for the MGBottomSheet
     
     - Author:
     Guillermo Garcia Rebolo
     
     - Version:
     1.0.3
     */
    
    public var appearance: MGBottomSheetAppearanceAttributes?
    
    fileprivate static var bundle:Bundle {
        let podBundle = Bundle(for: MGBottomSheet.self)
        let bundleURL = podBundle.url(forResource: "MGBottomSheet", withExtension: "bundle")
        return Bundle(url: bundleURL!)!
    }
    
    /**
     Class methods for instantiate the MGBottomSheet
     
     - Author:
     Guillermo Garcia Rebolo
     
     - returns
     MGBottomSheet instance.
     
     - parameters:
        - title: The main title of the bottom sheet.
     
     - Version:
     1.0.3
     
     This method creates an instance for use the MGBottomSheet in your code and let you access
     to its methods.
     */
    
    public class func mgBottomSheetWithTitle(_ title: String?) -> MGBottomSheet {
        let view = MGBottomSheet(nibName: "MGBottomSheet", bundle: bundle)

        view.titlePanel = title
        view.appearance = MGBottomSheetAppearanceAttributes.configureDefaultTextStyle()
        view.modalPresentationStyle = .overCurrentContext
        view.modalTransitionStyle = .crossDissolve
        view.numberColumns = MGBottomSheetNumColumns.twoColumns.rawValue
        
        return view
    }
    
    /**
     Override of the UIKit method viewDidLoad
     
     - Author:
     Guillermo Garcia Rebolo
     
     - Version:
     1.0.3
     */
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        self.tap = UITapGestureRecognizer(target: self, action: #selector(dismissBottomSheet(_:)))
        self.overlayView.addGestureRecognizer(tap)
    }
    
    /**
     Override of the UIKit method viewWillAppear
     
     - Author:
     Guillermo Garcia Rebolo
     
     - Version:
     1.0.3
     */
    
    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.configureView()
    }
    
    /**
     Override of the UIKit method didReceiveMemoryWarning
     
     - Author:
     Guillermo Garcia Rebolo
     
     - Version:
     1.0.3
     */

    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func dismissBottomSheet(_ sender: UITapGestureRecognizer) {
        self.hideActionsPanel()
        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK: - Layout
    
    fileprivate func configureView() {
        self.configureLabels()
        self.registerCellsForCollectionView()
        self.resizeViewForNumberOfActions(self.actions.count)
        
        self.showActionsPanel()
    }
    
    fileprivate func configureLabels() {
        if self.titlePanel == nil || self.titlePanel == "" {
            self.hideTitlePanelView()
        }
        else {
            self.actionsPanelTitleLabel.text = self.titlePanel
            self.actionsPanelTitleLabel.font = self.appearance?.textFont;
            self.actionsPanelTitleLabel.textColor = self.appearance?.textColor;
        }
    }
    
    fileprivate func showActionsPanel() {
        self.addAnimationActionsPanel(0)
        self.actionsPanel.isHidden = false
    }
    
    fileprivate func hideActionsPanel() {
        self.addAnimationActionsPanel(1)
        self.actionsPanel.isHidden = true
    }
    
    fileprivate func hideTitlePanelView() {
        self.panelTitleViewHeightConstraint.constant = 0.0
        self.collectionViewTopConstraint.constant = 8.0
        self.actionsPanelTitleView.isHidden = true
    }
    
    fileprivate func addAnimationActionsPanel(_ direction: Int) {
        let subType:String = direction == 0 ? kCATransitionFromTop : kCATransitionFromBottom
        
        let animation:CATransition = CATransition.init()
        animation.fillMode = kCAFillModeBoth
        animation.duration = 0.4
        animation.timingFunction = CAMediaTimingFunction.init(name: kCAMediaTimingFunctionEaseInEaseOut)
        animation.type = kCATransitionPush
        animation.subtype = subType
        
        self.actionsPanel.layer.add(animation, forKey: "transition")
    }
    
    //MARK: - Public Methods
    
    /**
     Method for add an action to the MGBottomSheet
     
     - Author:
     Guillermo Garcia Rebolo
     
     - parameters:
     - action: ActionSheet action for display at the MGBottomSheet.
     
     - Version:
     1.0.3
     */
    
    public func addAction(_ action: ActionSheet) {
        self.actions.append(action)
    }
    
    /**
     Method for set the number of columns for iPad to the MGBottomSheet
     
     - Author:
     Guillermo Garcia Rebolo
     
     - parameters:
     - numberColumns: Number of columns for iPad for the MGBottomSheet.
     
     - Version:
     1.0.4
     */
    
    public func configureNumberColumns(_ numberColumns: MGBottomSheetNumColumns) {
        self.numberColumns = numberColumns.rawValue
    }
    
    //MARK: - Private Methods
    
    fileprivate func registerCellsForCollectionView() {
        self.collectionView.register(UINib(nibName: "ActionSheetCell", bundle: MGBottomSheet.bundle), forCellWithReuseIdentifier: kActionSheetCellIdentifier)
    }
    
    fileprivate func resizeViewForNumberOfActions(_ numberActions: Int) {
        var actionsPanelHeight:CGFloat = 0.0
        let maxActionsPanelHeight:CGFloat = (self.view.frame.size.height * 0.7)
        let topBottomSpace = self.collectionViewTopConstraint.constant + 8
        
        if UI_USER_INTERFACE_IDIOM() == .pad {
            let numberLines:Float = ceilf(Float(numberActions) / 2)
            actionsPanelHeight = self.panelTitleViewHeightConstraint.constant + (CGFloat(kActionsViewHeigth) * CGFloat(numberLines)) + topBottomSpace
        }
        else {
            actionsPanelHeight = self.panelTitleViewHeightConstraint.constant + (CGFloat(kActionsViewHeigth) * CGFloat(numberActions)) + topBottomSpace
        }
        
        if actionsPanelHeight > maxActionsPanelHeight {
            actionsPanelHeight = maxActionsPanelHeight
            self.collectionView.isScrollEnabled = true
        }
        
        self.actionsPanelHeightConstraint.constant = actionsPanelHeight
    }
}

//MARK: - CollectionViewDataSource

extension MGBottomSheet: UICollectionViewDataSource {
    
    /**
     Implementation of method numberOfSections of UICollectionViewDataSource
     
     - Author:
     Guillermo Garcia Rebolo
     
     - Version:
     1.0.3
     */
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1;
    }
    
    /**
     Implementation of method collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int of UICollectionViewDataSource
     
     - Author:
     Guillermo Garcia Rebolo
     
     - Version:
     1.0.3
     */
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.actions.count
    }
    
    /**
     Implementation of method collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell of UICollectionViewDataSource
     
     - Author:
     Guillermo Garcia Rebolo
     
     - Version:
     1.0.3
     */
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kActionSheetCellIdentifier, for: indexPath)
        
        if let actionSheetCell = cell as? ActionSheetCell {
            actionSheetCell.actionSheetCellWithAction(self.actions[indexPath.row], font: self.appearance!.textFont, textColor: self.appearance!.textColor, imageTint: self.appearance!.imageTint)
        }
        
        return cell
    }
}

//MARK: - CollectionViewDelegate

extension MGBottomSheet: UICollectionViewDelegate {
    
    /**
     Implementation of method collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) of UICollectionViewDelegate
     
     - Author:
     Guillermo Garcia Rebolo
     
     - Version:
     1.0.3
     */
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let completion = self.actions[indexPath.row].completion
        
        if let function = completion {
            self.hideActionsPanel()
            self.dismiss(animated: true, completion: {
                function()
            })
        }
        
    }
}

//MARK: - CollectionViewDelegateFlowLayout

extension MGBottomSheet: UICollectionViewDelegateFlowLayout {
    
    /**
     Implementation of method collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize of UICollectionViewDelegateFlowLayout
     
     - Author:
     Guillermo Garcia Rebolo
     
     - Version:
     1.0.3
     */

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if UI_USER_INTERFACE_IDIOM() == .pad {
            return CGSize.init(width: self.actionsPanel.frame.size.width / numberColumns, height: 48.0)
        }
        return CGSize.init(width: self.actionsPanel.frame.size.width, height: 48.0)
    }
}
