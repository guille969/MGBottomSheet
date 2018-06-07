//
//  MGOverlayView.swift
//  MGBottomSheet iOS
//
//  Created by Guillermo García Rebolo on 7/6/18.
//  Copyright © 2018 Guillermo García Rebolo. All rights reserved.
//

import UIKit

protocol MGOverlayViewDelegate: class {
    func didTapView()
}

class MGOverlayView: UIView {
    
    private weak var delegate: MGOverlayViewDelegate?
    private var tap: UITapGestureRecognizer!
    
    public init(withView parent: UIView, andDelegate delegate: MGOverlayViewDelegate) {
        super.init(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        self.delegate = delegate
        self.configureView(withView: parent)
        self.addGestureRecognizer()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //MARK: - Public Methods
    
    public func show(withDelay delay: Double) {
        self.animateBackgroundColor(UIColor(red:0.24, green:0.31, blue:0.33, alpha:0.6), withDelay: delay)
    }
    
    public func hide(withDelay delay: Double) {
        self.animateBackgroundColor(.clear, withDelay: delay)
    }
    
    //MARK: - Private Methods
    
    private func configureView(withView parent: UIView) {
        self.backgroundColor = .clear
        parent.addSubview(self)
        self.translatesAutoresizingMaskIntoConstraints = false
        _ = self.top(withView: parent, toSafeArea: false)
        _ = self.bottom(withView: parent)
        _ = self.leading(withView: parent)
        _ = self.trailing(withView: parent)
    }
    
    private func addGestureRecognizer() {
        self.tap = UITapGestureRecognizer(target: self, action: #selector(tappedView(_:)))
        guard let tap: UITapGestureRecognizer = self.tap else { return }
        self.addGestureRecognizer(tap)
    }
    
    private func animateBackgroundColor(_ color: UIColor, withDelay delay: Double) {
        UIView.animate(withDuration: 0.2, delay: delay, animations: {
            self.backgroundColor = color
        }, completion: nil)
    }
    
    //MARK: - Actions
    
    @objc private func tappedView(_ sender: UITapGestureRecognizer) {
        self.delegate?.didTapView()
    }
}
