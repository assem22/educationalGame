//
//  MainTabBarController.swift
//  finalProject
//
//  Created by Assem Mukhamadi on 15.12.2020.
//

import UIKit

class MainTabBarController: UITabBarController {

    var user: User!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden=true
        
        guard let viewControllers = viewControllers else {
            return
        }
        for viewController in viewControllers {
            if let viewController = viewController as? ProfileViewController {
                viewController.user = user
            }
            if let viewController = viewController as? MainGameViewController {
                viewController.user = user
            }
        }
    }
}
