import UIKit

class AddingVC: UIViewController {
    // Test Arrays
    let directions = ["India","Belarus","Russia","Kyrgyzstan","China","Uzbekistan","SAR","Korea","USA","Canada"]
    let categorys = ["Breez","Neobis","NeoLabs"]
    let counterAgents = ["Dima","Tima","Yrys","Malika","Arstan","Erlan","Saddam","Talgar","Aigul"]
    let projects = ["Hamam","Building","AsiaMall","Vefa Center","Bishkek Park","Caravan","Palace","Bishkek City","Guard Hotel"]
    let wallets = ["DemirBank","OptimaBank","KazKomerc","Kyrgyzstan","NAC Bank"]
    
    @IBOutlet weak var newTransactionLabel: UILabel!
    
    let constants = Constants()

    //TextFields Outlets
    @IBOutlet weak var datePickTextField: UITextField!
    @IBOutlet weak var summTextField: UITextField!
    @IBOutlet weak var directionTextField: UITextField!
    @IBOutlet weak var categoryTextField: UITextField!
    @IBOutlet weak var counterAgentTextField: UITextField!
    @IBOutlet weak var projectTextField: UITextField!
    @IBOutlet weak var walletTextField: UITextField!
    @IBOutlet weak var commentTextField: UITextField!
    @IBOutlet weak var transferCommentaryTextFiled: UITextField!
    
    
    @IBOutlet weak var commentaryView: UIView!
    
    //Dividers
    @IBOutlet weak var divider1: UIView!
    @IBOutlet weak var divider2: UIView!
    @IBOutlet weak var divider3: UIView!
    @IBOutlet weak var hiddenPartView: UIView!
    @IBOutlet weak var divider4: UIView!
    
    
    
    @IBOutlet weak var cancelButton: UIButton!
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
        commentTextField.delegate = self
        transferCommentaryTextFiled.delegate = self
        
        keyBoardShowAndHide()
        createDatePicker()
        pickerViewDelegatesAndDataSource()
        design()
        
        
        
    }
    
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        
        
        
        
        dismiss(animated: true, completion: nil)
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
        
//        directionTextField.text = ""
//        categoryTextField.text = ""
        commentTextField.isHidden = false
        commentaryView.isHidden = true
        transferCommentaryTextFiled.isHidden = true
        
        counterAgentTextField.isHidden = false
        projectTextField.isHidden = false
        walletTextField.isHidden = false
        divider1.isHidden = false
        divider2.isHidden = false
        divider3.isHidden = false
        divider4.isHidden = false
        hiddenPartView.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        
    }
    
    func outcomeDesign(){
        directionTextField.placeholder = "Направление"
        categoryTextField.placeholder = "Категория"
        
//        directionTextField.text = ""
//        categoryTextField.text = ""
        commentTextField.isHidden = false
        commentaryView.isHidden = true
        transferCommentaryTextFiled.isHidden = true
        
        counterAgentTextField.isHidden = false
        projectTextField.isHidden = false
        walletTextField.isHidden = false
        divider1.isHidden = false
        divider2.isHidden = false
        divider3.isHidden = false
        divider4.isHidden = false
        hiddenPartView.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        
    }
    
    
    func transferDesign(){
        
        directionTextField.placeholder = "С кошелька"
        categoryTextField.placeholder = "На кошелёк"
        
        directionTextField.text = ""
        categoryTextField.text = ""
        
        commentTextField.isHidden = true
        commentaryView.isHidden = false
        transferCommentaryTextFiled.isHidden = false
       
        
        
        counterAgentTextField.isHidden = true
        projectTextField.isHidden = true
        walletTextField.isHidden = true
        divider1.isHidden = true
        divider2.isHidden = true
        divider3.isHidden = true
        divider4.isHidden = true
        hiddenPartView.backgroundColor = UIColor(red: 229/255, green: 229/255, blue: 229/255, alpha: 1)
        
       
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
        toolbar.backgroundColor = UIColor(red: 102/255, green: 193/255, blue: 73/255, alpha: 1)
        
        let loc = Locale(identifier: "ru_RU")
        datePicker.locale = loc
        
        //bar Button
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        doneButton.tintColor = UIColor(red: 102/255, green: 193/255, blue: 73/255, alpha: 1)
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



// MARK: Design Part
extension AddingVC{
    func design (){
        
        
        commentTextField.isHidden = false
        commentaryView.isHidden = true
        transferCommentaryTextFiled.isHidden = true
        
        
        saveButton.layer.cornerRadius = 10.0
        saveButton.layer.masksToBounds = true
        saveButton.titleLabel?.font = constants.fontSemiBold17
        cancelButton.titleLabel?.font = constants.fontRegular17
        
        //Fonts + sizes
        
        datePickTextField.font = constants.fontRegular17
        summTextField.font = constants.fontRegular17
        directionTextField.font = constants.fontRegular17
        categoryTextField.font = constants.fontRegular17
        counterAgentTextField.font = constants.fontRegular17
        projectTextField.font = constants.fontRegular17
        walletTextField.font = constants.fontRegular17
        newTransactionLabel.font = constants.fontSemiBold17
        
    }
}


extension AddingVC {
    
    
    func keyBoardShowAndHide(){
        NotificationCenter.default.addObserver(self, selector: #selector(AddingVC.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        // call the 'keyboardWillHide' function when the view controlelr receive notification that keyboard is going to be hidden
        NotificationCenter.default.addObserver(self, selector: #selector(AddingVC.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
    
    @objc func keyboardWillShow(notification: NSNotification) {
        
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            // if keyboard size is not available for some reason, dont do anything
            return
        }
        
        // move the root view up by the distance of keyboard height
        if datePickTextField.isEditing {
            self.view.frame.origin.y = 0 - keyboardSize.height + view.frame.height / 3 + 50
        } else if summTextField.isEditing {
            self.view.frame.origin.y = 0 - keyboardSize.height + view.frame.height / 3
        } else if directionTextField.isEditing {
            self.view.frame.origin.y = 0 - keyboardSize.height + view.frame.height / 3
        }else if categoryTextField.isEditing {
            self.view.frame.origin.y = 0 - keyboardSize.height + view.frame.height / 3
        }else if counterAgentTextField.isEditing  || transferCommentaryTextFiled.isEditing{
            self.view.frame.origin.y = 0 - keyboardSize.height + view.frame.height / 3
        }else if projectTextField.isEditing {
            self.view.frame.origin.y = 0 - keyboardSize.height + view.frame.height / 3
        }else if walletTextField.isEditing {
            self.view.frame.origin.y = 0 - keyboardSize.height + view.frame.height / 3 - 100
        }else if commentTextField.isEditing {
            self.view.frame.origin.y = 0 - keyboardSize.height + 51
        }
        
    }
    
//








//    @IBOutlet weak var transferCommentaryTextFiled: UITextField!
//
    
    @objc func keyboardWillHide(notification: NSNotification) {
        // move back the root view origin to zero
        self.view.frame.origin.y = 0
    }
    
}





