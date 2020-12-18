//
//  MenuViewController.swift
//  SideBarMenu
//
//  Created by Ary on 17/12/2020.
//  Copyright © 2020 Ary. All rights reserved.
//

import UIKit

class MenuViewController: UITableViewController {

    weak var delegate: MenuViewControllerDelegate?
    var dataSource: [MenuItem] = []
    override func viewDidLoad() {
        super.viewDidLoad()

        dataSource = [MenuItem(description: "Caixa de Entrada", image: #imageLiteral(resourceName: "inbox")),
                        MenuItem(description: "Enviados", image: #imageLiteral(resourceName: "sent")),
                        MenuItem(description: "Rascunho", image: #imageLiteral(resourceName: "draft")),
                        MenuItem(description: "Arquivado", image: #imageLiteral(resourceName: "archive")),
                        MenuItem(description: "Spam", image: #imageLiteral(resourceName: "spam"))]
    
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
        return dataSource.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        cell.textLabel?.text = dataSource[indexPath.row].description
        cell.imageView?.image = dataSource[indexPath.row].image
        return cell
    }
 
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedItem = dataSource[indexPath.row].description
        delegate?.didSelectItem(item: selectedItem)
        self.dismiss(animated: true, completion: nil)
    }
}

struct MenuItem {
    let description: String
    let image: UIImage
}


protocol MenuViewControllerDelegate:AnyObject {
    
    func didSelectItem(item:String)
}
