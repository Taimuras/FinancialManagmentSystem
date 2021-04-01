//
//  AddingCategoryVC.swift
//  FMS
//
//  Created by tami on 3/31/21.
//

import UIKit
import MBProgressHUD



class AddingCategoryVC: UIViewController {
    let constants = Constants()

    let createCategory = CreateCategory()
    var sectionID: Int?
    
    
    @IBOutlet weak var categoryLabel: UILabel!
    
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    
    @IBOutlet weak var categoryNameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        print("section ID: \(sectionID!)")
        
        
        design()
        self.hideKeyboardWhenTappedAround()
    }
    

    @IBAction func cancelButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        create()
    }
    

}

extension AddingCategoryVC {
    func create(){
        MBProgressHUD.showAdded(to: self.view, animated: true)
        if let name = categoryNameTextField.text{
            createCategory.createCategory(sectionID: sectionID!, name: name) { (response) in
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
            let dialogMessage = UIAlertController(title: "Поле не заполнено", message: "Название категории должно быть заполнено!", preferredStyle: .alert)
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







extension AddingCategoryVC{
    func design (){
        
        
        //Fonts + sizes
        categoryLabel.font = constants.fontSemiBold17
        
        
        
        
        saveButton.layer.cornerRadius = 10.0
        saveButton.layer.masksToBounds = true
        
        
        cancelButton.titleLabel?.font = constants.fontRegular17
        saveButton.titleLabel?.font = constants.fontSemiBold17
        categoryNameTextField.font = constants.fontRegular17
        
    }
}
