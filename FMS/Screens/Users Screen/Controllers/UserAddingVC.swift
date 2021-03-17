//
//  UserAddingVC.swift
//  FMS
//
//  Created by tami on 3/17/21.
//

import UIKit

class UserAddingVC: UIViewController {
    let constants = Constants()
    
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
        self.hideKeyboardWhenTappedAround() 
    }
    
    @IBAction func cancelButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
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
       
        
        
        
        

//        @IBOutlet weak var lastNameTextField: UITextField!
//        @IBOutlet weak var nameTextField: UITextField!
//        @IBOutlet weak var patronimycTextField: UITextField!
//        @IBOutlet weak var emailTextField: UITextField!
//        @IBOutlet weak var newPasswordTextField: UITextField!
//
    }
}
