//
//  AddingSectionVC.swift
//  FMS
//
//  Created by tami on 3/31/21.
//

import UIKit
import MBProgressHUD

class AddingSectionVC: UIViewController {
    
    let constants = Constants()
    
    let createSection = CreateSection()
    
    
    @IBOutlet weak var sectionLabel: UILabel!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var sectionTextField: UITextField!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        
        
        design()
        self.hideKeyboardWhenTappedAround()
        // Do any additional setup after loading the view.
    }
    

    @IBAction func cancelButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        create()
    }
    
    
    func create(){
        MBProgressHUD.showAdded(to: self.view, animated: true)
        if let name = sectionTextField.text{
            createSection.createSection(name: name) { (response) in
                if response != 1 {
                    let dialogMessage = UIAlertController(title: "Упс", message: "Что-то пошло не так. Пользователь не был создан!", preferredStyle: .alert)
                    let cancel = UIAlertAction(title: "Ok", style: .cancel) { (action) -> Void in
                        //            print("Cancel button tapped")
                    }
                    
                    dialogMessage.addAction(cancel)
                    
                    // Present dialog message to user
                    MBProgressHUD.hide(for: self.view, animated: true)
                    self.present(dialogMessage, animated: true, completion: nil)
                } else {
                    print(response)
                    self.dismiss(animated: true, completion: nil)
                }
            }
        } else {
            let dialogMessage = UIAlertController(title: "Поле не заполнено", message: "Название направления должно быть заполнено!", preferredStyle: .alert)
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






extension AddingSectionVC{
    func design (){
        
        
        //Fonts + sizes
        sectionLabel.font = constants.fontSemiBold17
        
        
        
        
        saveButton.layer.cornerRadius = 10.0
        saveButton.layer.masksToBounds = true
        
        
        cancelButton.titleLabel?.font = constants.fontRegular17
        saveButton.titleLabel?.font = constants.fontSemiBold17
        sectionTextField.font = constants.fontRegular17
        
    }
}
