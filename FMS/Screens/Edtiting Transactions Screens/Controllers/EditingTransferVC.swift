//
//  EditingTransferVC.swift
//  FMS
//
//  Created by tami on 3/11/21.
//

import UIKit

class EditingTransferVC: UIViewController {

    let constants = Constants()
    @IBOutlet weak var transactionLabel: UILabel!
    
    let wallet = ["NAC RU","NAC US","NAC AU","NAC FR","NAC KR"]
    
    
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var sumTextField: UITextField!
    @IBOutlet weak var fromTextField: UITextField!
    @IBOutlet weak var toTextField: UITextField!
    
    
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    let fromPickerView = UIPickerView()
    let toPickerVIew = UIPickerView()
    
    let datePicker = UIDatePicker()
    override func viewDidLoad() {
        super.viewDidLoad()
        sumTextField.delegate = self
        design()
        createDatePicker()
        pickerViewDelegAndDataSorc()
    }
    

    @IBAction func cancelButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func deleteButtonTapped(_ sender: UIButton) {
    }
    @IBAction func saveButtonTapped(_ sender: UIButton) {
    }
}


extension EditingTransferVC: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView.tag {
        case 1:
            return wallet.count
        case 2:
            return wallet.count
        default:
            return 1
        }
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView.tag {
        case 1:
            return wallet[row]
        case 2:
            return wallet[row]
        default:
            return "Data Not Found Edit Transfer"
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView.tag {
        case 1:
            fromTextField.text = wallet[row]
            fromTextField.resignFirstResponder()
        case 2:
            toTextField.text = wallet[row]
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
        let loc = Locale(identifier: "ru_RU")
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        formatter.locale = loc
        
        dateTextField.text = formatter.string(from: datePicker.date)
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
