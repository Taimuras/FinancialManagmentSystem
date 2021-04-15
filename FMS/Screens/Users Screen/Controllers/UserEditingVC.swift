//
//  UserEditingVC.swift
//  FMS
//
//  Created by tami on 3/17/21.
//

import UIKit
import MBProgressHUD



class UserEditingVC: UIViewController {
    let constants = Constants()
    
    var userID: Int?
    var userEmail: String?
    
    var emailToServer: String?
    var firstNameToServer: String?
    var lastNameToServer: String?
    var newPasswordToServer: String?
    var patronymic: String?
    
    
    
    @IBOutlet weak var userLabel: UILabel!
    
    
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var patronimycTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var newPasswordTextField: UITextField!
    
    
    @IBOutlet weak var photoImageButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var deleteSignButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    let getAndUpdateUser = GetAndUpdateUser()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        MBProgressHUD.showAdded(to: self.view, animated: true)
        getUser()
        
        
        
        design()
        self.hideKeyboardWhenTappedAround()
    }
    
    
    @IBAction func cancelButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func deleteButtonTapped(_ sender: UIButton) {
        
        getAndUpdateUser.deleteUserByEmail(email: emailTextField.text!) { (response) in
            if response == 1{
                self.dismiss(animated: true, completion: nil)
            } else {
                let dialogMessage = UIAlertController(title: "Упс", message: "Что-то пошло не так!", preferredStyle: .alert)
                let cancel = UIAlertAction(title: "Хорошо", style: .cancel) { (action) -> Void in
        //            print("Cancel button tapped")
                }
                dialogMessage.addAction(cancel)
                self.present(dialogMessage, animated: true, completion: nil)
            }
        }
    }
    
    
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        emailToServer = emailTextField.text!
        firstNameToServer = firstNameTextField.text ?? ""
        lastNameToServer = lastNameTextField.text ?? ""
        newPasswordToServer = newPasswordTextField.text ?? ""
        patronymic = patronimycTextField.text ?? ""
        
        getAndUpdateUser.updateUser(email: emailToServer!, first_name: firstNameToServer!, last_name: lastNameToServer!, password: newPasswordToServer!, patronymic: patronymic!) { (response) in
            if response == 1{
                self.dismiss(animated: true, completion: nil)
            } else {
                let dialogMessage = UIAlertController(title: "Упс", message: "Что-то пошло не так!", preferredStyle: .alert)
                let cancel = UIAlertAction(title: "Хорошо", style: .cancel) { (action) -> Void in
        //            print("Cancel button tapped")
                }
                dialogMessage.addAction(cancel)
                self.present(dialogMessage, animated: true, completion: nil)
            }
        }
    }
    
    func getUser() {
        getAndUpdateUser.getUserByID(email: userEmail!) { (data) in
            DispatchQueue.main.async {
                self.lastNameTextField.text = data.last_name
                self.firstNameTextField.text = data.first_name
                self.emailTextField.text = data.email
                self.patronimycTextField.text = data.patronymic
                MBProgressHUD.hide(for: self.view, animated: true)
            }
            
        }
    }
    
    
    
    
    
    
}



extension UserEditingVC{
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
        firstNameTextField.font = constants.fontRegular17
        patronimycTextField.font = constants.fontRegular17
        emailTextField.font = constants.fontRegular17
        newPasswordTextField.font = constants.fontRegular17
        
        userLabel.font = constants.fontSemiBold17
    }
}
