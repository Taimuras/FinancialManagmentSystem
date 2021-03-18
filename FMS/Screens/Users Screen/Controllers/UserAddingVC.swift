//
//  UserAddingVC.swift
//  FMS
//
//  Created by tami on 3/17/21.
//

import UIKit


class UserAddingVC: UIViewController {
    let constants = Constants()
    let createUser = NetworkCreateUser()
    
    @IBOutlet weak var userLabel: UILabel!
    
    @IBOutlet weak var photoImageButton: UIButton!
    
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var patronimycTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var newPasswordTextField: UITextField!
    
    
    @IBOutlet weak var cancelButton: UIButton!
    
    @IBOutlet weak var saveButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        design()
        tfDelegates()
        keyBoardShowAndHide()
        self.hideKeyboardWhenTappedAround() 
    }
    
    @IBAction func cancelButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        
        let name = nameTextField.text ?? ""
        let lastName = lastNameTextField.text ?? ""
        
        if let email = emailTextField.text, let password = newPasswordTextField.text{
            createUser.createUser(email: email, first_name: name, last_name: lastName, password: password) { (data) in
                if data != 1 {
                    let dialogMessage = UIAlertController(title: "Упс", message: "Что-то пошло не так. Пользователь не был создан!", preferredStyle: .alert)
                    let cancel = UIAlertAction(title: "Ok", style: .cancel) { (action) -> Void in
            //            print("Cancel button tapped")
                    }
                    
                    dialogMessage.addAction(cancel)
                    
                    // Present dialog message to user
                    self.present(dialogMessage, animated: true, completion: nil)
                } else {
                    self.dismiss(animated: true, completion: nil)
                }
            }
        }
    }
    
  
}


extension UserAddingVC{
    func design (){
        
        
        saveButton.layer.cornerRadius = 10.0
        saveButton.layer.masksToBounds = true
        saveButton.titleLabel?.font = constants.fontSemiBold17
        cancelButton.titleLabel?.font = constants.fontRegular17
        
        photoImageButton.layer.cornerRadius = 24.0
        photoImageButton.layer.masksToBounds = true
//
        //Fonts + sizes

        lastNameTextField.font = constants.fontRegular17
        nameTextField.font = constants.fontRegular17
        patronimycTextField.font = constants.fontRegular17
        emailTextField.font = constants.fontRegular17
        newPasswordTextField.font = constants.fontRegular17
        
        userLabel.font = constants.fontSemiBold17
       
        
        
    }
}

extension UserAddingVC: UITextFieldDelegate{
    func tfDelegates(){
        lastNameTextField.delegate = self
        nameTextField.delegate = self
        patronimycTextField.delegate = self
        emailTextField.delegate = self
        newPasswordTextField.delegate = self
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}



extension UserAddingVC {
    
    
    func keyBoardShowAndHide(){
        NotificationCenter.default.addObserver(self, selector: #selector(UserAddingVC.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        // call the 'keyboardWillHide' function when the view controlelr receive notification that keyboard is going to be hidden
        NotificationCenter.default.addObserver(self, selector: #selector(UserAddingVC.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
    
    @objc func keyboardWillShow(notification: NSNotification) {
        
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            // if keyboard size is not available for some reason, dont do anything
            return
        }
        
       

        if emailTextField.isEditing {
            self.view.frame.origin.y = 0 - keyboardSize.height / 3
        } else if newPasswordTextField.isEditing {
            self.view.frame.origin.y = 0 - keyboardSize.height / 1.8
        }
        
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        // move back the root view origin to zero
        self.view.frame.origin.y = 0
    }
    
}
