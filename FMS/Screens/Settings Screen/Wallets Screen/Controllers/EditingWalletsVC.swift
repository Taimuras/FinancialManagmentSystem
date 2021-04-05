//
//  EditingWalletsVC.swift
//  FMS
//
//  Created by tami on 3/27/21.
//

import UIKit
import MBProgressHUD

class EditingWalletsVC: UIViewController {
    
    
    let constants = Constants()
    var id: Int?
    
    let getSingleWallet = GetSingleWalletByID()
    let deleteWalletByID = DeleteWalletByID()
    let updateWalletByID = UpdateWalletByID()
    
    
    
    @IBOutlet weak var walletLabel: UILabel!
    
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var deleteSignButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var balanceTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        get()
        
        MBProgressHUD.showAdded(to: self.view, animated: true)
        design()
        self.hideKeyboardWhenTappedAround()
        // Do any additional setup after loading the view.
    }
    

    
    @IBAction func cancelButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func deleteButtonTapped(_ sender: UIButton) {
        MBProgressHUD.showAdded(to: self.view, animated: true)
        delete()
    }
    
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        MBProgressHUD.showAdded(to: self.view, animated: true)
        update()
    }
    

}


extension EditingWalletsVC{
    
    
    func get() {
        let url = constants.walletEndPoint + String(id!)
        getSingleWallet.getSinglewalletByID(url: url) { (data) in
            DispatchQueue.main.async {
                
                self.nameTextField.text = data.name
                self.balanceTextField.text = String(data.balance)
                
                MBProgressHUD.hide(for: self.view, animated: true)
            }
        }
    }
    
    
    func delete(){
        deleteWalletByID.deleteWalletByID(id: id!) { (response) in
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
    
    func update() {
        if let name = nameTextField.text, let balance = Int(balanceTextField.text!){
            updateWalletByID.updateWallet(id: id!, name: name, balance: balance){ (response) in
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
            let dialogMessage = UIAlertController(title: "Поля не заполнены", message: "Название и Сумма должны быть заполнены!", preferredStyle: .alert)
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





extension EditingWalletsVC{
    func design(){
        
        
        saveButton.layer.cornerRadius = 10.0
        saveButton.layer.masksToBounds = true
        saveButton.titleLabel?.font = constants.fontSemiBold17
        cancelButton.titleLabel?.font = constants.fontRegular17
        deleteSignButton.titleLabel?.font = constants.fontRegular17
        
        

        //Fonts + sizes

        walletLabel.font = constants.fontSemiBold17
        nameTextField.font = constants.fontRegular17
        balanceTextField.font = constants.fontRegular17
        
        
       
        
        
    }
}

