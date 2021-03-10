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
        keyBoardShowAndHide()
        textFieldsDelegate()
    }
    
    @IBAction func logInButtonTapped(_ sender: UIButton) {
        ApiCalling().logInApiCalling(email: loginTextField.text!, password: passwordTextField.text!)
    }
}

extension LoginVC: UITextFieldDelegate {
    func textFieldsDelegate(){
        loginTextField.delegate = self
        passwordTextField.delegate = self
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == loginTextField {
            textField.resignFirstResponder()//
            passwordTextField.becomeFirstResponder()//TF2 will respond immediately after TF1 resign.
        } else if textField == passwordTextField  {
            textField.resignFirstResponder()
        }
        return true
    }
}

extension LoginVC {
    
    
    func keyBoardShowAndHide(){
        NotificationCenter.default.addObserver(self, selector: #selector(LoginVC.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        // call the 'keyboardWillHide' function when the view controlelr receive notification that keyboard is going to be hidden
        NotificationCenter.default.addObserver(self, selector: #selector(LoginVC.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
    
    @objc func keyboardWillShow(notification: NSNotification) {
        
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            // if keyboard size is not available for some reason, dont do anything
            return
        }
        
        // move the root view up by the distance of keyboard height
        self.view.frame.origin.y = 0 - keyboardSize.height + 90
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        // move back the root view origin to zero
        self.view.frame.origin.y = 0
    }
    
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
