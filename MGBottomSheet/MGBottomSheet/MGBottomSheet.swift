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

public class MGBottomSheet: UIViewController  {

    @IBOutlet weak var overlayView: UIView!
    @IBOutlet weak var actionsPanel: UIView!
    @IBOutlet weak var actionsPanelTitleView: UIView!
    @IBOutlet weak var actionsPanelTitleLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var actionsPanelHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var panelTitleViewHeightConstraint: NSLayoutConstraint!
    
    fileprivate var actions: Array<ActionSheet> = []
    fileprivate var tap = UITapGestureRecognizer()
    fileprivate var titlePanel: String?
    public var appearance: MGBottomSheetAppearanceAttributes?
    
    fileprivate static var bundle:Bundle {
        let podBundle = Bundle(for: MGBottomSheet.self)
        let bundleURL = podBundle.url(forResource: "MGBottomSheet", withExtension: "bundle")
        return Bundle(url: bundleURL!)!
    }
    
    public class func mgBottomSheetWithTitle(_ title: String?) -> MGBottomSheet {
        let view = MGBottomSheet(nibName: "MGBottomSheet", bundle: bundle)

        view.titlePanel = title
        view.appearance = MGBottomSheetAppearanceAttributes.configureDefaultTextStyle()
        view.modalPresentationStyle = .overCurrentContext
        view.modalTransitionStyle = .crossDissolve
        
        return view
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        self.tap = UITapGestureRecognizer(target: self, action: #selector(dismissBottomSheet(_:)))
        self.overlayView.addGestureRecognizer(tap)
    }
    
    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.configureView()
    }

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
    
    //MARK: Public Methods
    
    public func addAction(_ action: ActionSheet) {
        self.actions.append(action)
    }
    
    
    //MARK: - Private Methods
    
    fileprivate func registerCellsForCollectionView() {
        self.collectionView.register(UINib(nibName: "ActionSheetCell", bundle: MGBottomSheet.bundle), forCellWithReuseIdentifier: kActionSheetCellIdentifier)
    }
    
    fileprivate func resizeViewForNumberOfActions(_ numberActions: Int) {
        var actionsPanelHeight:CGFloat = 0.0
        let maxActionsPanelHeight:CGFloat = (self.view.frame.size.height * 0.7)
        
        if UI_USER_INTERFACE_IDIOM() == .pad {
            let numberLines:Float = ceilf(Float(numberActions) / 2)
            actionsPanelHeight = self.panelTitleViewHeightConstraint.constant + (CGFloat(kActionsViewHeigth) * CGFloat(numberLines))
        }
        else {
            actionsPanelHeight = self.panelTitleViewHeightConstraint.constant + (CGFloat(kActionsViewHeigth) * CGFloat(numberActions))
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
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1;
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.actions.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kActionSheetCellIdentifier, for: indexPath)
        
        if let actionSheetCell = cell as? ActionSheetCell {
            actionSheetCell.actionSheetCellWithAction(self.actions[indexPath.row], font: self.appearance!.textFont, textColor: self.appearance!.textColor, imageTint: self.appearance!.imageTint)
        }
        
        return cell
    }
}

//MARK: - CollectionViewDelegate

extension MGBottomSheet: UICollectionViewDelegateFlowLayout {

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if UI_USER_INTERFACE_IDIOM() == .pad {
            return CGSize.init(width: self.actionsPanel.frame.size.width / 2, height: 48.0)
        }
        return CGSize.init(width: self.actionsPanel.frame.size.width, height: 48.0)
    }
    
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
