//
//  AnaliticsVC.swift
//  FMS
//
//  Created by tami on 3/8/21.
//

import UIKit

class AnaliticsVC: UIViewController {
    let constants = Constants()
    let getAnalytics = AnalyticsNetworking()
    let userDefaults = UserDefaults.standard
    
    
    @IBOutlet weak var analyticsLabel: UILabel!
    @IBOutlet weak var filtrationLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        design()
        
        
        
        get()
        
        
        // Do any additional setup after loading the view.
    }
    

    @IBAction func logOut(_ sender: UIButton) {
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
    
    
    @IBAction func historyButtonTapped(_ sender: UIButton) {
        let historyVC = storyboard?.instantiateViewController(withIdentifier: constants.historyVC) as! HistoryVC
        present(historyVC, animated: true, completion: nil)
    }
    
    
    
    func get() {
        getAnalytics.getAnalytics { (data) in
            print(data)
        }
    }
}





extension AnaliticsVC{
    func design (){
        
        
        //Fonts + sizes
        analyticsLabel.font = constants.fontBold34
        filtrationLabel.font = constants.fontSemiBold16
        
        
        
       
    }
}
