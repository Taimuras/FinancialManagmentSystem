//
//  TabBarController.swift
//  FMS
//
//  Created by tami on 3/8/21.
//

import UIKit

class TabBarController: UITabBarController {
    let constants = Constants()
    
    
    let mainTabBarItem = MainViewController()
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        // Do any additional setup after loading the view.
    }
    


}

extension TabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        guard let index = viewControllers?.firstIndex(of: viewController) else {
            // not sure if there is a case when this wouldn't exist, so just for safety, we'll return false
            return false
        }
        
        if index == 2 {
            let homeView = self.storyboard?.instantiateViewController(withIdentifier: constants.addingModalVC) as! AddingVC
            present(homeView, animated: true, completion: nil)
            return false
        }
        return true
    }
   
}
