//
//  LoginVC.swift
//  FMS
//
//  Created by tami on 3/5/21.
//

import UIKit

class LoginVC: UIViewController {
    
    let constants = Constants()
    //Labels
    @IBOutlet weak var logoTextLabel: UILabel!
    @IBOutlet weak var welcomeTextLabel: UILabel!
    @IBOutlet weak var continueLabel: UILabel!
    
    //TextFields
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    //Buttons
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var forgotButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        design()
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}



extension LoginVC {
    
    func design (){
        
        loginButton.layer.cornerRadius = 10.0
        loginButton.layer.masksToBounds = true
        
        logoTextLabel.font = constants.fontSemiBold36
        welcomeTextLabel.font = constants.fontSemiBold20
        continueLabel.font = constants.fontRegular14
        
        
        forgotButton.titleLabel?.font = constants.fontSemiBold13
        loginButton.titleLabel?.font = constants.fontSemiBold17
        
        
        loginTextField.font = constants.fontRegular17
        passwordTextField.font = constants.fontRegular17

        textFieldBottomLine(textField: loginTextField)
        textFieldBottomLine(textField: passwordTextField)
        
    }
    
    
    func textFieldBottomLine( textField: UITextField) {
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: textField.frame.height - 2, width: textField.frame.width / 1.1195, height: 1)
        bottomLine.backgroundColor = UIColor.init(red: 48/255, green: 173/255, blue: 90/255, alpha: 1).cgColor
        textField.borderStyle = .none
        textField.layer.addSublayer(bottomLine)
    }
}
