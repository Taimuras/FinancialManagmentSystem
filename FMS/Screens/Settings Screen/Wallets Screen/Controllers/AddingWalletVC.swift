//
//  AddingWalletVC.swift
//  FMS
//
//  Created by tami on 3/27/21.
//

import UIKit
import MBProgressHUD


class AddingWalletVC: UIViewController {
    let constants = Constants()
    
    let createWallet = CreateWallet()
    
    @IBOutlet weak var walletLabel: UILabel!
    
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var balanceTextField: UITextField!
    
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
    
    
}


extension AddingWalletVC {
    func create() {
        
        if let name = nameTextField.text, let balance = balanceTextField.text{
            createWallet.createWallet(name: name, balance: Int(balance)!, completion: { (data) in
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
            let dialogMessage = UIAlertController(title: "Поля не заполнены", message: "Название кошелька и сумма должны быть заполнены!", preferredStyle: .alert)
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




extension AddingWalletVC{
    func design(){
        
        
        saveButton.layer.cornerRadius = 10.0
        saveButton.layer.masksToBounds = true
        saveButton.titleLabel?.font = constants.fontSemiBold17
        cancelButton.titleLabel?.font = constants.fontRegular17
        
        

        //Fonts + sizes

        
        nameTextField.font = constants.fontRegular17
        balanceTextField.font = constants.fontRegular17
        
        
        walletLabel.font = constants.fontSemiBold17
       
        
        
    }
}
