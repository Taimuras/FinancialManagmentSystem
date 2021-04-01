//
//  AddingProjectVC.swift
//  FMS
//
//  Created by tami on 3/26/21.
//

import UIKit
import MBProgressHUD

class AddingProjectVC: UIViewController {
    
    let constants = Constants()
    
    let createProject = CreateProject()
    
    @IBOutlet weak var projectLabel: UILabel!
    
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    
    @IBOutlet weak var nameTextField: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        
        
        design()
        self.hideKeyboardWhenTappedAround()

    }
    

    @IBAction func cancelButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        create()
        MBProgressHUD.showAdded(to: self.view, animated: true)
    }
    
    
    func create() {
        
        if let name = nameTextField.text{
            createProject.createProject(name: name, completion: { (data) in
                if data != 1 {
                    let dialogMessage = UIAlertController(title: "Упс", message: "Что-то пошло не так. Пользователь не был создан!", preferredStyle: .alert)
                    let cancel = UIAlertAction(title: "Ok", style: .cancel) { (action) -> Void in
                        //            print("Cancel button tapped")
                    }
                    
                    dialogMessage.addAction(cancel)
                    
                    // Present dialog message to user
                    MBProgressHUD.hide(for: self.view, animated: true)
                    self.present(dialogMessage, animated: true, completion: nil)
                } else {
                    print(data)
                    self.dismiss(animated: true, completion: nil)
                }
            })
        } else {
            let dialogMessage = UIAlertController(title: "Поля не заполнены", message: "Название проекта должно быть заполнено!", preferredStyle: .alert)
            let cancel = UIAlertAction(title: "Хорошо", style: .cancel) { (action) -> Void in
                //            print("Cancel button tapped")
            }
            
            dialogMessage.addAction(cancel)
            
            // Present dialog message to user
            MBProgressHUD.hide(for: self.view, animated: true)
            self.present(dialogMessage, animated: true, completion: nil)
        }
    }
    
}




extension AddingProjectVC{
    func design (){
        
        
        saveButton.layer.cornerRadius = 10.0
        saveButton.layer.masksToBounds = true
        saveButton.titleLabel?.font = constants.fontSemiBold17
        cancelButton.titleLabel?.font = constants.fontRegular17
        
        

        //Fonts + sizes

        
        nameTextField.font = constants.fontRegular17
        
        
        
        projectLabel.font = constants.fontSemiBold17
       
        
        
    }
}
