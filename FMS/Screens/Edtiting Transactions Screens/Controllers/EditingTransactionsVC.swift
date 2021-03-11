//EditingTransactionsVC

import UIKit

class EditingTransactionsVC: UIViewController {
    
    let direction = ["Bishkek","Astana","Moscow","Saint - Peterburg","Biejing","Melburn","Washington","New-York","Berlin","Paris"]
    let category = ["Anvar $ CO","Heretic Brothers","Jing Jing corp."]
    let counterAgent = ["Demis","Fransua","Nichlen","Michlen","Bob","Donald","Goofie","Batman","Joker"]
    let project = ["Dubai Mall","Moscow Mall","AsiaMall","Vefa Center","Bishkek Park","Caravan","TCUM","GUM","Dordoi Plaza"]
    let wallet = ["NAC RU","NAC US","NAC AU","NAC FR","NAC KR"]

    
    @IBOutlet weak var transactionLabel: UILabel!
    let constants = Constants()
    
    @IBOutlet weak var segmentedOutlet: UISegmentedControl!
    
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var sumTextField: UITextField!
    @IBOutlet weak var directionTextField: UITextField!
    @IBOutlet weak var categoryTextField: UITextField!
    @IBOutlet weak var counterAgentTextField: UITextField!
    @IBOutlet weak var projectTextField: UITextField!
    @IBOutlet weak var walletTextField: UITextField!
    
    
    let datePicker = UIDatePicker()
    
    
    let directionsPickerView = UIPickerView()
    let categorysPickerView = UIPickerView()
    let counterAgentsPickerView = UIPickerView()
    let projectsPickerView = UIPickerView()
    let walletsPickerView = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sumTextField.delegate = self
        
        createDatePicker()
        design()
        pickerViewDelegAndDataSorc()
    }
   
    @IBAction func cancelTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func segmentedTapped(_ sender: UISegmentedControl) {
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
    }
    
    @IBAction func deleteIconButtonTapped(_ sender: UIButton) {
        print("Tap Tap")
    }
    
   
}



extension EditingTransactionsVC: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView.tag {
        case 1:
            return direction.count
        case 2:
            return category.count
        case 3:
            return counterAgent.count
        case 4:
            return project.count
        case 5:
            return wallet.count
        default:
            return 1
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView.tag {
        case 1:
            return direction[row]
        case 2:
            return category[row]
        case 3:
            return counterAgent[row]
        case 4:
            return project[row]
        case 5:
            return wallet[row]
        default:
            return "Data Not FOund Editing"
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView.tag {
        case 1:
            directionTextField.text = direction[row]
            directionTextField.resignFirstResponder()
        case 2:
            categoryTextField.text = category[row]
            categoryTextField.resignFirstResponder()
        case 3:
            counterAgentTextField.text = counterAgent[row]
            counterAgentTextField.resignFirstResponder()
        case 4:
            projectTextField.text = project[row]
            projectTextField.resignFirstResponder()
        case 5:
            walletTextField.text = wallet[row]
            walletTextField.resignFirstResponder()
        default:
            return
        }
    }
    
    
    func pickerViewDelegAndDataSorc(){
        directionsPickerView.delegate = self
        directionsPickerView.dataSource = self
        directionTextField.inputView = directionsPickerView
        
        categorysPickerView.delegate = self
        categorysPickerView.dataSource = self
        categoryTextField.inputView = categorysPickerView
        
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

extension EditingTransactionsVC{
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


extension EditingTransactionsVC{
    func semgentedControllerChande( sender: UISegmentedControl){
        switch sender.selectedSegmentIndex {
        case 0:
            break
        case 1:
            break
        default:
            print("asd")
        }
    }
}






extension EditingTransactionsVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}

extension EditingTransactionsVC{
    
    
    func design() {
        saveButton.layer.cornerRadius = 10.0
        saveButton.layer.masksToBounds = true
        saveButton.titleLabel?.font = constants.fontSemiBold17
        cancelButton.titleLabel?.font = constants.fontRegular17
        
        dateTextField.font = constants.fontRegular17
        sumTextField.font = constants.fontRegular17
        directionTextField.font = constants.fontRegular17
        categoryTextField.font = constants.fontRegular17
        counterAgentTextField.font = constants.fontRegular17
        projectTextField.font = constants.fontRegular17
        walletTextField.font = constants.fontRegular17
        transactionLabel.font = constants.fontSemiBold17
        
    }
}
