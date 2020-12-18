//
//  PresentationController.swift
//  SideBarMenu
//
//  Created by Ary on 18/12/2020.
//  Copyright © 2020 Ary. All rights reserved.
//

import UIKit

class PresentationController:UIPresentationController, UIGestureRecognizerDelegate {
    
    var panDirection:CGFloat = .zero {
        
        didSet{
            
            if oldValue < panDirection {
                blackAlpha += 0.01
                
            }else
                if oldValue > panDirection {
                    blackAlpha -= 0.01
            }
        }
    }
    var blackAlpha:CGFloat = 0.75 {
        
        didSet{
            
            if blackAlpha > 0.75 {
                blackAlpha = 0.75
            }
            if blackAlpha < 0.25 {
                blackAlpha = 0.25
            }
        }
    }
    private lazy var dimmingView: UIView! = {
        guard let container = containerView else { return nil }
        
        let view = UIView(frame: container.bounds)
        view.backgroundColor = UIColor.black.withAlphaComponent(0.75)
        view.addGestureRecognizer(
            UITapGestureRecognizer(target: self, action: #selector(didTap(tap:)))
        )
        return view
    }()
    let panGesture = UIPanGestureRecognizer()
    
    override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
        
        panGesture.addTarget(self, action: #selector(didPan(pan:)))
        presentedViewController.view.addGestureRecognizer(panGesture)
        panGesture.delegate = self
        
    }
    
    //This method stopped up/down pangesture of UITableView and allow only vertical scroll
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        
        if let panGestureRecognizer = gestureRecognizer as? UIPanGestureRecognizer {
            let translation = panGestureRecognizer.translation( in: presentedViewController.view)
            if abs(translation.x) > abs(translation.y) {
                return true
            }
            return false
        }
        return false
    }
    
    // MARK: delegates presentation
    override func presentationTransitionWillBegin() {
        
        guard let container = containerView else {return}
        container.addSubview(dimmingView)
        dimmingView.alpha = .zero
        UIView.animate(withDuration: 0.25) {
            self.dimmingView.alpha = 1.0
        }
    }
    
    override func dismissalTransitionDidEnd(_ completed: Bool) {
        
        dimmingView.alpha = 1.0
        UIView.animate(withDuration: 0.25) {
            self.dimmingView.alpha = .zero
        }
        if completed {
            dimmingView.removeFromSuperview()
        }
    }
    
    @objc func didTap(tap: UITapGestureRecognizer) {
        presentedViewController.dismiss(animated: true, completion: nil)
        
    }
    
    @objc func didPan(pan: UIPanGestureRecognizer) {
        
        guard let view = pan.view, let superView = view.superview,
            let presented = presentedView else { return }
        
        let translation = pan.translation(in: superView)
      
        if pan.state == .changed {
            
            if translation.x <= 0 {
               
                presented.frame.origin.x = translation.x
            }
            
            //control the dimmingView alpha
            panDirection = presented.frame.origin.x
            dimmingView.backgroundColor = UIColor.black.withAlphaComponent(blackAlpha)
        }
        if pan.state == .ended {
            
            var limitOffSet = presented.frame.width / 2
            limitOffSet.negate()
            if presented.frame.origin.x <=  limitOffSet {
                
                presentedViewController.dismiss(animated: true, completion: nil)
                
            }else {
                
                UIView.animate(withDuration: 0.3) {
                    
                    presented.frame.origin.x = 0
                    self.blackAlpha = 0.75
                    self.dimmingView.backgroundColor = UIColor.black.withAlphaComponent(self.blackAlpha)
                }
            }
        }
    }
    
    override var frameOfPresentedViewInContainerView: CGRect {
        
        guard let container = containerView else { return .zero }
        
        return CGRect(x: 0, y: 0, width: container.bounds.width - 100, height: container.bounds.height)
    }
    
}
