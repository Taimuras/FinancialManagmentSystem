//
//  SettingsVC.swift
//  FMS
//
//  Created by tami on 3/8/21.
//

import UIKit

class SettingsVC: UIViewController {
    let constants = Constants()
    let userDefaults = UserDefaults.standard
    
    @IBOutlet weak var counterPartContainer: UIView!
    @IBOutlet weak var projectsContainer: UIView!
    @IBOutlet weak var sectionsContainer: UIView!
    @IBOutlet weak var walletsContainer: UIView!
    
    
    @IBOutlet weak var settignsLabel: UILabel!
    @IBOutlet weak var segmentedOutlet: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        design()
        
        // Do any additional setup after loading the view.
    }
    

    @IBAction func historyButtonTapped(_ sender: UIButton) {
        let historyVC = storyboard?.instantiateViewController(withIdentifier: constants.historyVC) as! HistoryVC
        present(historyVC, animated: true, completion: nil)
    }
    
    
    
    @IBAction func logOutButtonTapped(_ sender: UIButton) {
        let dialogMessage = UIAlertController(title: "Выход", message: "Вы уверены, что хотите выйти?", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Отмена", style: .cancel) { (action) -> Void in
//            print("Cancel button tapped")
        }
        let ok = UIAlertAction(title: "Да", style: .destructive, handler: { (action) -> Void in
//             print("Ok button tapped")
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let mainTabBarController = storyboard.instantiateViewController(identifier: "LoginNavigationController")
            (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(mainTabBarController)

            self.userDefaults.removeObject(forKey: "AccessToken")
            self.userDefaults.removeObject(forKey: "RefreshToken")
            self.userDefaults.removeObject(forKey: "Admin")
             
        })
        
        //Add OK and Cancel button to dialog message
        dialogMessage.addAction(ok)
        dialogMessage.addAction(cancel)
        
        
        // Present dialog message to user
        self.present(dialogMessage, animated: true, completion: nil)
    }
    
    
    
    
    @IBAction func segmentedSelected(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            counterPartContainer.alpha = 1
            projectsContainer.alpha = 0
            sectionsContainer.alpha = 0
            walletsContainer.alpha = 0
        } else if sender.selectedSegmentIndex == 1{
            counterPartContainer.alpha = 0
            projectsContainer.alpha = 1
            sectionsContainer.alpha = 0
            walletsContainer.alpha = 0
        }else if sender.selectedSegmentIndex == 2{
            counterPartContainer.alpha = 0
            projectsContainer.alpha = 0
            sectionsContainer.alpha = 1
            walletsContainer.alpha = 0
        }else if sender.selectedSegmentIndex == 3{
            counterPartContainer.alpha = 0
            projectsContainer.alpha = 0
            sectionsContainer.alpha = 0
            walletsContainer.alpha = 1
        }
        
    }
    
}


extension SettingsVC{
    func design(){
   

        settignsLabel.font = constants.fontBold34
//        addLabel.font = constants.fontSemiBold16
        
       
        
        
    }
}

