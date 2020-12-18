//
//  ViewController.swift
//  SideBarMenu
//
//  Created by Ary on 17/12/2020.
//  Copyright © 2020 Ary. All rights reserved.
//

import UIKit

class ViewController: UIViewController, MenuViewControllerDelegate {

    var transitionDelegate: TransitioningDelegate!
    override func viewDidLoad() {
        super.viewDidLoad()
        configureMenuBar() 
    }

    func configureMenuBar() {
        let menuBarButtonItem = UIBarButtonItem(title: "≡", style: .done, target: self, action:#selector(tapMenu(_:)))
        let attribute = [NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: 30), NSAttributedString.Key.foregroundColor: UIColor.black]
        menuBarButtonItem.setTitleTextAttributes(attribute, for: .normal)
        navigationItem.leftBarButtonItem = menuBarButtonItem
    }

    @objc func tapMenu(_ button:UIBarButtonItem) {
        
        guard let menuViewController = storyboard?.instantiateViewController(withIdentifier: "MenuViewController") as? MenuViewController else {return}
       
        transitionDelegate = TransitioningDelegate(from: self, to: menuViewController)
        menuViewController.transitioningDelegate = transitionDelegate
        menuViewController.delegate = self
        menuViewController.modalPresentationStyle = .custom
        present(menuViewController, animated:true)
    }
    
    func didSelectItem(item: String) {
        self.navigationItem.title = item
    }
}

