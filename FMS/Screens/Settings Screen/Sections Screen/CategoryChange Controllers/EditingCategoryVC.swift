//
//  EditingCategoryVC.swift
//  FMS
//
//  Created by tami on 4/1/21.
//

import UIKit
import MBProgressHUD


class EditingCategoryVC: UIViewController {
    
    
    let constants = Constants()
    
    var id: Int?
    
    var sectionID: [Int] = []
    
    
    let getCategoryByID = GetSingleCategoryByID()
    let deleteCategoryByID = DeleteCategoryByID()
    let updateCategoryByID = UpdateCategoryByID()
    
    @IBOutlet weak var categoryLabel: UILabel!
    
    @IBOutlet weak var deleteSignButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    
    @IBOutlet weak var categoryNameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        MBProgressHUD.showAdded(to: self.view, animated: true)
        getCategory()
        
        
        
        design()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func cancelButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func deleteButtonTapped(_ sender: UIButton) {
        delete()
    }
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        update()
    }
    
}



extension EditingCategoryVC{
    func getCategory() {
        
        getCategoryByID.getSingleCategoryByID(id: id!) { (data) in
            DispatchQueue.main.async {
                self.categoryNameTextField.text = data.name
                self.sectionID.removeAll()
                for i in 0 ..< data.section.count{
                    self.sectionID.append(data.section[i])
                }
                
                MBProgressHUD.hide(for: self.view, animated: true)
            }
        }
    }
    
    
    
    func update() {
        MBProgressHUD.showAdded(to: self.view, animated: true)
        if let name = categoryNameTextField.text{
            updateCategoryByID.updateCategory(id: id!, name: name, section: sectionID) { (response) in
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
    
    
    
    
    func delete(){
        MBProgressHUD.showAdded(to: self.view, animated: true)
        deleteCategoryByID.deleteCategoryByID(id: id!) { (response) in
            if response == 1{
                self.dismiss(animated: true, completion: nil)
            } else {
                let dialogMessage = UIAlertController(title: "Упс", message: "Что-то пошло не так!", preferredStyle: .alert)
                let cancel = UIAlertAction(title: "Хорошо", style: .cancel) { (action) -> Void in
        //            print("Cancel button tapped")
                }
                dialogMessage.addAction(cancel)
                MBProgressHUD.hide(for: self.view, animated: true)
                self.present(dialogMessage, animated: true, completion: nil)
            }
        }
    }
}






extension EditingCategoryVC{
    func design (){
        
        
        saveButton.layer.cornerRadius = 10.0
        saveButton.layer.masksToBounds = true
        saveButton.titleLabel?.font = constants.fontSemiBold17
        cancelButton.titleLabel?.font = constants.fontRegular17
        deleteSignButton.titleLabel?.font = constants.fontRegular17
        
        

        //Fonts + sizes

        
        categoryNameTextField.font = constants.fontRegular17
        categoryLabel.font = constants.fontSemiBold17
       
        
        
    }
}
