//
//  UserEditingVC.swift
//  FMS
//
//  Created by tami on 3/17/21.
//

import UIKit
import MBProgressHUD



class UserEditingVC: UIViewController {
    
    
    var userID: Int?
    var userEmail: String?
    
    @IBOutlet weak var userLabel: UILabel!
    
    
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var patronimycTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var newPasswordTextField: UITextField!
    
    
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var deleteSignButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    let getAndUpdateUser = GetAndUpdateUser()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        MBProgressHUD.showAdded(to: self.view, animated: true)
        getUser()
        
        
        
        
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
    }
    
    func getUser() {
        getAndUpdateUser.getUserByID(email: userEmail!) { (data) in
            DispatchQueue.main.async {
                self.lastNameTextField.text = data.last_name
                self.firstNameTextField.text = data.first_name
                self.emailTextField.text = data.email
                MBProgressHUD.hide(for: self.view, animated: true)
            }
            
        }
    }
    
    
    
    
    
    
}
