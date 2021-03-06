//
//  ForgotVC.swift
//  FMS
//
//  Created by tami on 3/5/21.
//

import UIKit

class ForgotVC: UIViewController {
    let constants = Constants()
    @IBOutlet weak var logoLabel: UILabel!
    @IBOutlet weak var forgotUrPassLabel: UILabel!
    @IBOutlet weak var bigTextLabel: UILabel!
    
    @IBOutlet weak var backButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        design()
        // Do any additional setup after loading the view.
    }
    

    @IBAction func backButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
}


extension ForgotVC {
    func design (){
        
        backButton.layer.cornerRadius = 10.0
        backButton.layer.masksToBounds = true
        
        logoLabel.font = constants.fontSemiBold36
        forgotUrPassLabel.font = constants.fontSemiBold20
        bigTextLabel.font = constants.fontRegular13
        
        
    }
}
