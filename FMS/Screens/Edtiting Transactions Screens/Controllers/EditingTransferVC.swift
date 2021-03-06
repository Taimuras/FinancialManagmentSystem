//
//  EditingTransferVC.swift
//  FMS
//
//  Created by tami on 3/11/21.
//

import UIKit
import MBProgressHUD

class EditingTransferVC: UIViewController {
    
    var idToUpdate: Int?
    var dateTime: String?
    
    
    var date_join: String?
    var sectionID: Int?
    var categoryID: Int?
    var projectID: Int?
    var walletID: Int?
    var walletToID: Int?
    var contractorID: Int?
    var comment = ""
    
    
    let constants = Constants()
    let fetchingTransfer = FetchingAndDeletingTransactions()
    let fetchingData = FetchingDataFilterScreen()
    let updateTransaction = UpdatingTransaction()
    @IBOutlet weak var transactionLabel: UILabel!
    
    var wallet: [WalletModel] = []
    
    
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var sumTextField: UITextField!
    @IBOutlet weak var fromTextField: UITextField!
    @IBOutlet weak var toTextField: UITextField!
    @IBOutlet weak var commentTextField: UITextField!
    
    
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    let fromPickerView = UIPickerView()
    let toPickerVIew = UIPickerView()
    
    let datePicker = UIDatePicker()
    override func viewDidLoad() {
        super.viewDidLoad()
        sumTextField.delegate = self
        commentTextField.delegate = self
        MBProgressHUD.showAdded(to: self.view, animated: true)
        fetchData()
        design()
        createDatePicker()
        pickerViewDelegAndDataSorc()
        keyBoardShowAndHide()
        self.hideKeyboardWhenTappedAround() 
    }
    

    @IBAction func cancelButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func deleteButtonTapped(_ sender: UIButton) {
        let urlToFetchTransaction = constants.transactionEndPoint + String(idToUpdate!)
        fetchingTransfer.deletingTransaction(url: urlToFetchTransaction, id: idToUpdate!) { (response) in
            if response{
                self.dismiss(animated: true, completion: nil)
            } else {
                let dialogMessage = UIAlertController(title: "??????", message: "??????-???? ?????????? ???? ??????!", preferredStyle: .alert)
                let cancel = UIAlertAction(title: "????????????", style: .cancel) { (action) -> Void in
        //            print("Cancel button tapped")
                }
                dialogMessage.addAction(cancel)
                // Present dialog message to user
                self.present(dialogMessage, animated: true, completion: nil)
            }
        }
        
    }
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        updateTransferData()
    }
    
    
    
    func updateTransferData() {
        let urlToUpdateTransaction = constants.transactionEndPoint + String(idToUpdate!)
        
        updateTransaction.updateTransferTransaction(url: urlToUpdateTransaction, date_join: date_join!, type: 3, sum: Int(sumTextField.text!)!, wallet: walletID!, wallet_to: walletToID!, comment: comment) { (data) in
            if data != 1 {
                let dialogMessage = UIAlertController(title: "??????", message: "??????-???? ?????????? ???? ??????. ???????????????????? ???? ???????? ??????????????!", preferredStyle: .alert)
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
        
    }
}


extension EditingTransferVC{
    func fetchData(){
        fetchingData.fetchingWallets(url: constants.walletEndPoint) { (data) in
            DispatchQueue.main.async {
                self.wallet.removeAll()
                self.wallet = data
                self.checkData()
            }
            
        }
    }
    
    func checkData(){
        if wallet.count != 0 {
            fetchTransaction()
        }
    }
    
    func fetchTransaction(){
        let urlToFetchTransaction = constants.transactionEndPoint + String(idToUpdate!)
        fetchingTransfer.fetchingTransfer(url: urlToFetchTransaction) { (data) in
            DispatchQueue.main.async {
                
                self.sumTextField.text = String(data.sum)
                
                let strDate = self.constants.stringToDate(dateString: self.dateTime!)
                let dateStr = self.constants.dateToServer(date: strDate)
                print(dateStr)
                self.date_join = dateStr
//                self.date_join = self.constants.stringToDate(dateString: self.constants.dateToServer(date: self.dateTime))
                self.dateTextField.text = self.constants.dateToString(date: self.constants.stringToDate(dateString: self.dateTime!))
                
                if data.comment != "null" {
                    self.commentTextField.text = data.comment
                    self.comment = data.comment
                }
                for i in self.wallet{
                    if i.id == data.wallet {
                        self.fromTextField.text = i.name
                        self.walletID = data.wallet
                    }
                }
                for i in self.wallet{
                    if i.id == data.wallet_to{
                        self.toTextField.text = i.name
                        self.walletToID = data.wallet_to
                    }
                }
                MBProgressHUD.hide(for: self.view, animated: true)
            }
            
        }
    }
}

extension EditingTransferVC: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView.tag {
        case 1:
            return wallet.count - 1
        case 2:
            return wallet.count - 1
        default:
            return 1
        }
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView.tag {
        case 1:
            return wallet[row].name
        case 2:
            return wallet[row].name
        default:
            return "Data Not Found Edit Transfer"
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView.tag {
        case 1:
            fromTextField.text = wallet[row].name
            walletID = wallet[row].id
            fromTextField.resignFirstResponder()
        case 2:
            toTextField.text = wallet[row].name
            walletToID = wallet[row].id
            toTextField.resignFirstResponder()
        default:
            return
        }
    }
    
    
    
    
    func pickerViewDelegAndDataSorc(){
        fromPickerView.delegate = self
        fromPickerView.dataSource = self
        fromTextField.inputView = fromPickerView
        
        toPickerVIew.delegate = self
        toPickerVIew.dataSource = self
        toTextField.inputView = toPickerVIew
        
        
        
        fromPickerView.tag = 1
        toPickerVIew.tag = 2
        
    }
    
}



extension EditingTransferVC{
    func createDatePicker() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        toolbar.backgroundColor = UIColor(red: 102/255, green: 193/255, blue: 73/255, alpha: 1)
        
        let loc = Locale(identifier: "ru_RU")
        datePicker.locale = loc
        
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        doneButton.tintColor = UIColor(red: 102/255, green: 193/255, blue: 73/255, alpha: 1)
        toolbar.setItems([doneButton], animated: true)
        datePicker.preferredDatePickerStyle = .wheels
        
        dateTextField.inputAccessoryView = toolbar
        dateTextField.inputView = datePicker
        datePicker.datePickerMode = .date
    }
    
    @objc func donePressed() {
        dateTextField.text = constants.dateToString(date: datePicker.date)
        date_join = constants.dateToServer(date: datePicker.date)
//        print(date_join)
        self.view.endEditing(true)
    }
}




extension EditingTransferVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}

extension EditingTransferVC{
    
    
    func design() {
        saveButton.layer.cornerRadius = 10.0
        saveButton.layer.masksToBounds = true
        saveButton.titleLabel?.font = constants.fontSemiBold17
        cancelButton.titleLabel?.font = constants.fontRegular17
        
        
        dateTextField.font = constants.fontRegular17
        sumTextField.font = constants.fontRegular17
        fromTextField.font = constants.fontRegular17
        toTextField.font = constants.fontRegular17
        transactionLabel.font = constants.fontSemiBold17
        
    }
}


extension EditingTransferVC {
    
    
    func keyBoardShowAndHide(){
        NotificationCenter.default.addObserver(self, selector: #selector(EditingTransferVC.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        // call the 'keyboardWillHide' function when the view controlelr receive notification that keyboard is going to be hidden
        NotificationCenter.default.addObserver(self, selector: #selector(EditingTransferVC.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
    
    @objc func keyboardWillShow(notification: NSNotification) {
        
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            // if keyboard size is not available for some reason, dont do anything
            return
        }
        
        // move the root view up by the distance of keyboard height
        if sumTextField.isEditing {
            self.view.frame.origin.y = 0 - keyboardSize.height + 200
        } else {
            self.view.frame.origin.y = 0 - keyboardSize.height + 200    
        }
        
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        // move back the root view origin to zero
        self.view.frame.origin.y = 0
    }
    
}
