//
//  AddingVC.swift
//  FMS
//
//  Created by tami on 3/8/21.
//

import UIKit

class AddingVC: UIViewController {
    // Test Arrays
    let directions = ["India","Belarus","Russia","Kyrgyzstan","China","Uzbekistan","SAR","Korea","USA","Canada"]
    let categorys = ["Breez","Neobis","NeoLabs"]
    let counterAgents = ["Dima","Tima","Yrys","Malika","Arstan","Erlan","Saddam","Talgar","Aigul"]
    let projects = ["Hamam","Building","AsiaMall","Vefa Center","Bishkek Park","Caravan","Palace","Bishkek City","Guard Hotel"]
    let wallets = ["DemirBank","OptimaBank","KazKomerc","Kyrgyzstan","NAC Bank"]
    
    
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
    
    //Picker VIews
    let directionsPickerView = UIPickerView()
    let categorysPickerView = UIPickerView()
    let counterAgentsPickerView = UIPickerView()
    let projectsPickerView = UIPickerView()
    let walletsPickerView = UIPickerView()
    
    
    
    
    @IBOutlet weak var segmentedOutler: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        summTextField.delegate = self
        
        createDatePicker()
        pickerViewDelegatesAndDataSource()
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
        
        directionTextField.text = ""
        categoryTextField.text = ""
        
        
        counterAgentTextField.isHidden = true
        projectTextField.isHidden = true
        walletTextField.isHidden = true
        divider1.isHidden = true
        divider2.isHidden = true
        divider3.isHidden = true
        hiddenPartView.backgroundColor = UIColor(red: 246/255, green: 246/255, blue: 246/255, alpha: 1)
        
       
    }
}

// MARK: PickerView

extension AddingVC: UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView.tag {
        case 1:
            if segmentedOutler.selectedSegmentIndex != 2{
                return directions.count
            } else {
                return wallets.count
            }
        case 2:
            if segmentedOutler.selectedSegmentIndex != 2{
                return categorys.count
            } else {
                return wallets.count
            }
        case 3:
            return counterAgents.count
        case 4:
            return projects.count
        case 5:
            return wallets.count
        default:
            return 1
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView.tag {
        case 1:
            if segmentedOutler.selectedSegmentIndex != 2{
                return directions[row]
            } else {
                return wallets[row]
            }
        case 2:
            if segmentedOutler.selectedSegmentIndex != 2{
                return categorys[row]
            } else {
                return wallets[row]
            }
        case 3:
            return counterAgents[row]
        case 4:
            return projects[row]
        case 5:
            return wallets[row]
        default:
            return "Data not Found"
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView.tag {
        case 1:
            if segmentedOutler.selectedSegmentIndex != 2 {
                directionTextField.text = directions[row]
                directionTextField.resignFirstResponder()
            } else {
                directionTextField.text = wallets[row]
                directionTextField.resignFirstResponder()
            }
        case 2:
            if segmentedOutler.selectedSegmentIndex != 2 {
                categoryTextField.text = categorys[row]
                categoryTextField.resignFirstResponder()
            } else {
                categoryTextField.text = wallets[row]
                categoryTextField.resignFirstResponder()
            }
            
        case 3:
            counterAgentTextField.text = counterAgents[row]
            counterAgentTextField.resignFirstResponder()
        case 4:
            projectTextField.text = projects[row]
            projectTextField.resignFirstResponder()
        case 5:
            walletTextField.text = wallets[row]
            walletTextField.resignFirstResponder()
        default:
            return
        }
    }
    
    func pickerViewDelegatesAndDataSource() {
        directionsPickerView.delegate = self
        directionsPickerView.dataSource = self
        if segmentedOutler.selectedSegmentIndex != 2 {
            directionTextField.inputView = directionsPickerView
        } else {
            directionTextField.inputView = walletsPickerView
        }
        
        
        categorysPickerView.delegate = self
        categorysPickerView.dataSource = self
        if segmentedOutler.selectedSegmentIndex != 2 {
            categoryTextField.inputView = categorysPickerView
        } else {
            categoryTextField.inputView = walletsPickerView
        }
        
        
        counterAgentsPickerView.delegate = self
        counterAgentsPickerView.dataSource = self
        counterAgentTextField.inputView = counterAgentsPickerView
        
        projectsPickerView.delegate = self
        projectsPickerView.dataSource = self
        projectTextField.inputView = projectsPickerView
        
        walletsPickerView.delegate = self
        walletsPickerView.dataSource = self
        walletTextField.inputView = walletsPickerView
        
        directionsPickerView.tag = 1
        categorysPickerView.tag = 2
        counterAgentsPickerView.tag = 3
        projectsPickerView.tag = 4
        walletsPickerView.tag = 5
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
