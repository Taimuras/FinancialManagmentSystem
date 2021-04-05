//
//  EditingCounterPartVC.swift
//  FMS
//
//  Created by tami on 3/25/21.
//

import UIKit
import MBProgressHUD

class EditingCounterPartVC: UIViewController {
    
    @IBOutlet weak var counterPartLabel: UILabel!
    
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var deleteSignButton: UIButton!
    
    
    @IBOutlet weak var surnameTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var patronymicTextField: UITextField!
    
    
    var id: Int?
    let constants = Constants()
    let deleteCounterPart = DeleteCounterPart()
    let getCounterPartByID = GetCounterPartByID()
    let updateCounterPartByID = UpdateCounterPartByID()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        MBProgressHUD.showAdded(to: self.view, animated: true)
        getCounterPart()
        
        design()
        // Do any additional setup after loading the view.
        
        
        self.hideKeyboardWhenTappedAround() 
    }
    
    
    
    
    
    
    @IBAction func cancelButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        update()
    }
    
    @IBAction func deleteButtonTapped(_ sender: UIButton) {
        delete()
    }
    
    
    
    func getCounterPart() {
        let url = constants.counterAgentEndPoint + String(id!)
        getCounterPartByID.getAllCounterParts(url: url) { (data) in
            DispatchQueue.main.async {
                self.surnameTextField.text = data.surname
                self.nameTextField.text = data.name
                self.patronymicTextField.text = data.patronymic
                MBProgressHUD.hide(for: self.view, animated: true)
            }
        }
    }
    
    
    func delete(){
        deleteCounterPart.deleteUserByEmail(id: id!) { (response) in
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
    
    func update() {
        if let name = nameTextField.text, let surname = surnameTextField.text {
            updateCounterPartByID.updateCounterPart(id: id!, name: name, surname: surname, patronymic: patronymicTextField.text ?? "") { (response) in
                if response != 1 {
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
        } else {
            let dialogMessage = UIAlertController(title: "Поля не заполнены", message: "Имя и Фамилия должны быть заполнены!", preferredStyle: .alert)
            let cancel = UIAlertAction(title: "Хорошо", style: .cancel) { (action) -> Void in
                //            print("Cancel button tapped")
            }
            
            dialogMessage.addAction(cancel)
            
            // Present dialog message to user
            self.present(dialogMessage, animated: true, completion: nil)
        }
        
    }
}



extension EditingCounterPartVC{
    func design (){
        
        
        saveButton.layer.cornerRadius = 10.0
        saveButton.layer.masksToBounds = true
        saveButton.titleLabel?.font = constants.fontSemiBold17
        cancelButton.titleLabel?.font = constants.fontRegular17
        deleteSignButton.titleLabel?.font = constants.fontRegular17
        
        

        //Fonts + sizes

        surnameTextField.font = constants.fontRegular17
        nameTextField.font = constants.fontRegular17
        patronymicTextField.font = constants.fontRegular17
        counterPartLabel.font = constants.fontSemiBold17
       
        
        
    }
}
