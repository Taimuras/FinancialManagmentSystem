//
//  AddingCounterPartVC.swift
//  FMS
//
//  Created by tami on 3/25/21.
//

import UIKit

class AddingCounterPartVC: UIViewController {
    let constants = Constants()

    var counterPartID: Int?
    
    let createCounterPartNetwork = CreateCounterPart()
    
    @IBOutlet weak var counterPartLabel: UILabel!
    
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    
    
    
    @IBOutlet weak var surnameTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var patronymicTextField: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()


        
        design()
        // Do any additional setup after loading the view.
        
        
        
    }
    
    
    @IBAction func cancelButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        createCounterPart()
    }
    
    
    
    func createCounterPart(){
//        let name = nameTextField.text!
//        let surname = surnameTextField.text!
        let patronymic = patronymicTextField.text ?? ""
        
        if let name = nameTextField.text, let surname = surnameTextField.text{
            createCounterPartNetwork.createCounterPart(name: name, surname: surname, patronymic: patronymic, completion: { (data) in
                if data != 1 {
                    let dialogMessage = UIAlertController(title: "Упс", message: "Что-то пошло не так. Пользователь не был создан!", preferredStyle: .alert)
                    let cancel = UIAlertAction(title: "Ok", style: .cancel) { (action) -> Void in
                        //            print("Cancel button tapped")
                    }
                    
                    dialogMessage.addAction(cancel)
                    
                    // Present dialog message to user
                    self.present(dialogMessage, animated: true, completion: nil)
                } else {
                    print(data)
                    self.dismiss(animated: true, completion: nil)
                }
            })
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


extension AddingCounterPartVC{
    func design (){
        
        
        saveButton.layer.cornerRadius = 10.0
        saveButton.layer.masksToBounds = true
        saveButton.titleLabel?.font = constants.fontSemiBold17
        cancelButton.titleLabel?.font = constants.fontRegular17
        
        

        //Fonts + sizes

        surnameTextField.font = constants.fontRegular17
        nameTextField.font = constants.fontRegular17
        patronymicTextField.font = constants.fontRegular17
        counterPartLabel.font = constants.fontSemiBold17
       
        
        
    }
}
