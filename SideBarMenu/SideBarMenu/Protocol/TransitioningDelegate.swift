//
//  TransitioningDelegate.swift
//  SideBarMenu
//
//  Created by Ary on 18/12/2020.
//  Copyright © 2020 Ary. All rights reserved.
//

import UIKit

final class TransitioningDelegate: NSObject, UIViewControllerTransitioningDelegate {
    
    init(from presented: UIViewController, to presenting: UIViewController) {
        super.init()
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return LeftToRightTransition()
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return RightToLeftTransition()
    }
    
    // MARK: - UIViewControllerTransitioningDelegate
    
    internal func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        
        return PresentationController(presentedViewController: presented, presenting: presenting)
    }
    
}

