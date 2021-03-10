//
//  AddingVC.swift
//  FMS
//
//  Created by tami on 3/8/21.
//

import UIKit

class AddingVC: UIViewController {
    
    let constants = Constants()

    //TextFields Outlets
    @IBOutlet weak var datePickTextField: UITextField!
    @IBOutlet weak var summTextField: UITextField!
    @IBOutlet weak var directionTextField: UITextField!
    @IBOutlet weak var categoryTextField: UITextField!
    @IBOutlet weak var counterAgentTextField: UITextField!
    @IBOutlet weak var projectTextField: UITextField!
    @IBOutlet weak var walletTextField: UITextField!
    
    
    //Dividers
    @IBOutlet weak var divider1: UIView!
    @IBOutlet weak var divider2: UIView!
    @IBOutlet weak var divider3: UIView!
    @IBOutlet weak var hiddenPartView: UIView!
    
    
    
    @IBOutlet weak var saveButton: UIButton!
    let datePicker = UIDatePicker()
    
    @IBOutlet weak var segmentedOutler: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        summTextField.delegate = self
        
        createDatePicker()
        design()
        
        
    }
    
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
    }
    
    @IBAction func segmentedValueChanged(_ sender: UISegmentedControl) {
        
        segmentedControllerChanged(sender: sender)
    }
    
    @IBAction func cancelButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    
}


// MARK: Segmented Controller
extension AddingVC {
    func segmentedControllerChanged(sender: UISegmentedControl){
        switch sender.selectedSegmentIndex {
        case 0:
            incomeDesign()
        case 1:
            outcomeDesign()
        case 2:
            transferDesign()
        default:
            view.backgroundColor = UIColor.blue
        }
    }
}




// MARK: Segmented Selected
extension AddingVC{
    func incomeDesign(){
        directionTextField.placeholder = "Направление"
        categoryTextField.placeholder = "Категория"
        
        
        counterAgentTextField.isHidden = false
        projectTextField.isHidden = false
        walletTextField.isHidden = false
        divider1.isHidden = false
        divider2.isHidden = false
        divider3.isHidden = false
    }
    
    func outcomeDesign(){
        directionTextField.placeholder = "Направление"
        categoryTextField.placeholder = "Категория"
        
        
        counterAgentTextField.isHidden = false
        projectTextField.isHidden = false
        walletTextField.isHidden = false
        divider1.isHidden = false
        divider2.isHidden = false
        divider3.isHidden = false
    }
    
    
    func transferDesign(){
        directionTextField.placeholder = "С кошелька"
        categoryTextField.placeholder = "На кошелёк"
        
        
        counterAgentTextField.isHidden = true
        projectTextField.isHidden = true
        walletTextField.isHidden = true
        divider1.isHidden = true
        divider2.isHidden = true
        divider3.isHidden = true
        hiddenPartView.backgroundColor = UIColor(red: 246/255, green: 246/255, blue: 246/255, alpha: 1)
    }
}

// MARK: DatePicker
extension AddingVC{
    func createDatePicker () {
        
        //toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let loc = Locale(identifier: "ru_RU")
        datePicker.locale = loc
        
        //bar Button
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([doneButton], animated: true)
        datePicker.preferredDatePickerStyle = .wheels
        //assign toolbar
        datePickTextField.inputAccessoryView = toolbar
        
        datePickTextField.inputView = datePicker
        datePicker.datePickerMode = .date
    }
    @objc func donePressed(){
        let loc = Locale(identifier: "ru_RU")
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        formatter.locale = loc
        
        datePickTextField.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
}


extension AddingVC: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}


extension AddingVC{
    func design (){
        
        saveButton.layer.cornerRadius = 10.0
        saveButton.layer.masksToBounds = true
        saveButton.titleLabel?.font = constants.fontSemiBold17
        
        //Fonts + sizes
        
        datePickTextField.font = constants.fontRegular17
        summTextField.font = constants.fontRegular17
        directionTextField.font = constants.fontRegular17
        categoryTextField.font = constants.fontRegular17
        counterAgentTextField.font = constants.fontRegular17
        projectTextField.font = constants.fontRegular17
        walletTextField.font = constants.fontRegular17
        

        
        
        
    }
}
