import UIKit
import MBProgressHUD

class AddingVC: UIViewController {
    // Test Arrays
    var directions: [DirectionModel] = []
    var categorys: [CategoryModel] = []
    var counterAgents: [CounterAgentsModel] = []
    var projects: [ProjectModel] = []
    var wallets: [WalletModel] = []
    
    @IBOutlet weak var newTransactionLabel: UILabel!
    
    let fetchingData = FetchingDataFilterScreen()
    let constants = Constants()
    let createTransaction = NetworkCreateTransaction()

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
        
        
        
//        MBProgressHUD.showAdded(to: self.view, animated: true)
        
        summTextField.delegate = self
        commentTextField.delegate = self
        transferCommentaryTextFiled.delegate = self
        
        fetchData()
        keyBoardShowAndHide()
        createDatePicker()
        pickerViewDelegatesAndDataSource()
        design()
        MBProgressHUD.showAdded(to: self.view, animated: true)
        self.hideKeyboardWhenTappedAround() 
        
    }
    
    
    var sum = 0
    var sectionID = 0
    var categoryID = 0
    var projectID = 0
    var walletID = 0
    var wallet_toID = 0
    var contractorID = 0
    var comment = ""
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        if let summa = summTextField.text {
            sum = Int(summa)!
        }
        if segmentedOutler.selectedSegmentIndex != 2 {
            if let com = commentTextField.text {
                comment = com
            } else {
                comment = ""
            }
        } else if segmentedOutler.selectedSegmentIndex == 2{
            if let com = transferCommentaryTextFiled.text {
                comment = com
            } else {
                comment = ""
            }
        }
        if segmentedOutler.selectedSegmentIndex == 0 {
            createTransaction.createIncomeTransaction(url: constants.createTransactionEndPotin, type: 1, section: sectionID, category: categoryID, project: projectID, sum: sum, wallet: walletID, contractor: contractorID, comment: comment) { (data) in
                
                if data != 1 {
                    let dialogMessage = UIAlertController(title: "Упс", message: "Что-то пошло не так. Транзакция не была создана!", preferredStyle: .alert)
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
        } else if segmentedOutler.selectedSegmentIndex == 1 {
            createTransaction.createOutComeTransaction(url: constants.createTransactionEndPotin, type: 2, section: sectionID, category: categoryID, project: projectID, sum: sum, wallet: walletID, contractor: contractorID, comment: comment) { (data) in
                
                if data != 1 {
                    let dialogMessage = UIAlertController(title: "Упс", message: "Что-то пошло не так. Транзакция не была создана!", preferredStyle: .alert)
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
            createTransaction.createTransferTransaction(url: constants.createTransactionEndPotin, type: 3, sum: sum, wallet: walletID, wallet_to: wallet_toID,  comment: comment) { (data) in
                
                if data != 1 {
                    let dialogMessage = UIAlertController(title: "Упс", message: "Что-то пошло не так. Транзакция не была создана!", preferredStyle: .alert)
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

extension AddingVC{
    
    func fetchData(){
        fetchingData.fetchingWallets(url: constants.walletEndPoint) { (data) in
            DispatchQueue.main.async {
                self.wallets.removeAll()
                self.wallets = data
                self.checkData()
            }
            
        }
        fetchingData.fetchingCounterAgents(url: constants.counterAgentEndPoint) { (data) in
            DispatchQueue.main.async {
                self.counterAgents.removeAll()
                self.counterAgents = data
                self.checkData()
            }
            
        }
        fetchingData.fetchingDirections(url: constants.directionsEndPoint) { (data) in
            DispatchQueue.main.async {
                self.directions.removeAll()
                self.directions = data
                self.checkData()
            }
            
        }
        
        fetchingData.fetchingCategories(url: constants.categoriesEndPoint) { (data) in
            DispatchQueue.main.async {
                self.categorys.removeAll()
                self.categorys = data
                self.checkData()
            }
        }
        
        
        fetchingData.fetchingProjects(url: constants.projectsEndPoint) { (data) in
            DispatchQueue.main.async {
                self.projects.removeAll()
                self.projects = data
                self.checkData()
            }
        }
        
    }
    
    func checkData(){
        if wallets.count != 0 && counterAgents.count != 0 && directions.count != 0 && categorys.count != 0 && projects.count != 0 {
            MBProgressHUD.hide(for: self.view, animated: true)
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
                return directions.count - 1
            } else {
                return wallets.count - 1
            }
        case 2:
            if segmentedOutler.selectedSegmentIndex != 2{
                return categorys.count - 1
            } else {
                return wallets.count - 1
            }
        case 3:
            return counterAgents.count - 1
        case 4:
            return projects.count - 1
        case 5:
            return wallets.count - 1
        default:
            return 1
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView.tag {
        case 1:
            if segmentedOutler.selectedSegmentIndex != 2{
                return directions[row].name
            } else {
                return wallets[row].name
            }
        case 2:
            if segmentedOutler.selectedSegmentIndex != 2{
                return categorys[row].name
            } else {
                return wallets[row].name
            }
        case 3:
            return counterAgents[row].name
        case 4:
            return projects[row].name
        case 5:
            return wallets[row].name
        default:
            return "Data not Found"
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView.tag {
        case 1:
            if segmentedOutler.selectedSegmentIndex != 2 {
                directionTextField.text = directions[row].name
                sectionID = directions[row].id
                directionTextField.resignFirstResponder()
            } else {
                directionTextField.text = wallets[row].name
                walletID = wallets[row].id
                directionTextField.resignFirstResponder()
            }
        case 2:
            if segmentedOutler.selectedSegmentIndex != 2 {
                categoryTextField.text = categorys[row].name
                categoryID = categorys[row].id
                categoryTextField.resignFirstResponder()
            } else {
                categoryTextField.text = wallets[row].name
                walletID = wallets[row].id
                categoryTextField.resignFirstResponder()
            }
            
        case 3:
            counterAgentTextField.text = counterAgents[row].name
            contractorID = counterAgents[row].id
            counterAgentTextField.resignFirstResponder()
        case 4:
            projectTextField.text = projects[row].name
            projectID = projects[row].id
            projectTextField.resignFirstResponder()
        case 5:
            walletTextField.text = wallets[row].name
            walletID = wallets[row].id
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
//            self.view.frame.origin.y = 0 - keyboardSize.height + view.frame.height / 3 + 50
        } else if summTextField.isEditing {
//            self.view.frame.origin.y = 0 - keyboardSize.height + view.frame.height / 3
        } else if directionTextField.isEditing {
//            self.view.frame.origin.y = 0 - keyboardSize.height + view.frame.height / 3
        }else if categoryTextField.isEditing {
//            self.view.frame.origin.y = 0 - keyboardSize.height + view.frame.height / 3
        }else if counterAgentTextField.isEditing  || transferCommentaryTextFiled.isEditing{
//            self.view.frame.origin.y = 0 - keyboardSize.height + view.frame.height / 3 - 50
        }else if projectTextField.isEditing {
            self.view.frame.origin.y = 0 - keyboardSize.height + view.frame.height / 3 - 51
        }else if walletTextField.isEditing {
            self.view.frame.origin.y = 0 - keyboardSize.height + view.frame.height / 3 - 102
        }else if commentTextField.isEditing {
            self.view.frame.origin.y = 0 - keyboardSize.height / 3
        }
        
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        // move back the root view origin to zero
        self.view.frame.origin.y = 0
    }
    
}





