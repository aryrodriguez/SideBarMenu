//
//  TransitionsController.swift
//  SideBarMenu
//
//  Created by Ary on 18/12/2020.
//  Copyright © 2020 Ary. All rights reserved.
//

import UIKit

let duration: TimeInterval = 0.3
class RightToLeftTransition: NSObject, UIViewControllerAnimatedTransitioning {
    
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let container = transitionContext.containerView
        let toView = transitionContext.view(forKey: .from)!
        container.addSubview(toView)
        
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseIn, animations: {
            toView.frame.size.width = 0
        }, completion: { _ in
            toView.removeFromSuperview()
            transitionContext.completeTransition(true)
        })
    }
}

class LeftToRightTransition: NSObject, UIViewControllerAnimatedTransitioning {
   
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let container = transitionContext.containerView
        let fromView = transitionContext.view(forKey: .to)!
        let sizeLimit = container.frame.width * 0.2
        container.addSubview(fromView)
        fromView.frame.origin = .zero
        fromView.frame.size.width = 0
        
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseOut, animations: {
            
            fromView.frame.size.width = container.frame.width - sizeLimit
        }, completion: { _ in
            transitionContext.completeTransition(true)
        })
    }
    
}
