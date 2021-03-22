//EditingTransactionsVC

import UIKit
import MBProgressHUD


protocol EditingTransactionsVCDelegate {
    func didFinishUpdatingTransaction(success: Bool)
}

class EditingTransactionsVC: UIViewController {
    
    var idToUpdate: Int?
    var typeToUpdate: Int?
    
    var directions: [DirectionModel] = []
    var categorys: [CategoryModel] = []
    var counterAgents: [CounterAgentsModel] = []
    var projects: [ProjectModel] = []
    var wallets: [WalletModel] = []

    
    @IBOutlet weak var transactionLabel: UILabel!
    let constants = Constants()
    let fetchingData = FetchingDataFilterScreen()
    let fetchingTransaction = FetchingAndDeletingTransactions()
    
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
    @IBOutlet weak var commentTextField: UITextField!
    
    
    let datePicker = UIDatePicker()
    
    
    let directionsPickerView = UIPickerView()
    let categorysPickerView = UIPickerView()
    let counterAgentsPickerView = UIPickerView()
    let projectsPickerView = UIPickerView()
    let walletsPickerView = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        segmentedOutlet.selectedSegmentIndex = typeToUpdate!
        
        
        
        
        sumTextField.delegate = self
        commentTextField.delegate = self
        
        MBProgressHUD.showAdded(to: self.view, animated: true)
        
        
        fetchData()
        
        
        createDatePicker()
        design()
        pickerViewDelegAndDataSorc()
        keyBoardShowAndHide()
        self.hideKeyboardWhenTappedAround() 
    }
   
    @IBAction func cancelTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func segmentedTapped(_ sender: UISegmentedControl) {
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
    }
    
    @IBAction func deleteIconButtonTapped(_ sender: UIButton) {
        let urlToFetchTransaction = constants.transactionByID + String(idToUpdate!)
        fetchingTransaction.deletingTransaction(url: urlToFetchTransaction, id: idToUpdate!) { (response) in
            if response{
                self.dismiss(animated: true, completion: nil)
            } else {
                let dialogMessage = UIAlertController(title: "Упс", message: "Что-то пошло не так!", preferredStyle: .alert)
                let cancel = UIAlertAction(title: "Хорошо", style: .cancel) { (action) -> Void in
        //            print("Cancel button tapped")
                }
                
                
                dialogMessage.addAction(cancel)
                
                
                // Present dialog message to user
                self.present(dialogMessage, animated: true, completion: nil)
            }
        }
        print("Tap Tap")
    }
    
    
    // MARK: Fetch Transaction
    func fetchTransaction(){
        let urlToFetchTransaction = constants.transactionByID + String(idToUpdate!)
        fetchingTransaction.fetchingTransactions(url: urlToFetchTransaction) { (data) in
            DispatchQueue.main.async {
                self.sumTextField.text = String(data.sum)
                for i in self.directions{
                    if i.id == data.section {
                        self.directionTextField.text = i.name
                    }
                }
                for i in self.categorys{
                    if i.id == data.category {
                        self.categoryTextField.text = i.name
                    }
                }
                for i in self.counterAgents{
                    if i.id == data.contractor {
                        self.counterAgentTextField.text = i.name
                    }
                }
                for i in self.projects{
                    if i.id == data.project {
                        self.projectTextField.text = i.name
                    }
                }
                for i in self.wallets{
                    if i.id == data.wallet {
                        self.walletTextField.text = i.name
                    }
                }
                MBProgressHUD.hide(for: self.view, animated: true)
            }
            
        }
    }
   
}
extension EditingTransactionsVC{
    
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
            fetchTransaction()
//            MBProgressHUD.hide(for: self.view, animated: true)
        }
    }
    
    
    
    
}



extension EditingTransactionsVC: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView.tag {
        case 1:
            return directions.count - 1
        case 2:
            return categorys.count - 1
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
            return directions[row].name
        case 2:
            return categorys[row].name
        case 3:
            return counterAgents[row].name
        case 4:
            return projects[row].name
        case 5:
            return wallets[row].name
        default:
            return "Data Not FOund Editing"
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView.tag {
        case 1:
            directionTextField.text = directions[row].name
            directionTextField.resignFirstResponder()
        case 2:
            categoryTextField.text = categorys[row].name
            categoryTextField.resignFirstResponder()
        case 3:
            counterAgentTextField.text = counterAgents[row].name
            counterAgentTextField.resignFirstResponder()
        case 4:
            projectTextField.text = projects[row].name
            projectTextField.resignFirstResponder()
        case 5:
            walletTextField.text = wallets[row].name
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

extension EditingTransactionsVC {
    
    
    func keyBoardShowAndHide(){
        NotificationCenter.default.addObserver(self, selector: #selector(EditingTransactionsVC.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        // call the 'keyboardWillHide' function when the view controlelr receive notification that keyboard is going to be hidden
        NotificationCenter.default.addObserver(self, selector: #selector(EditingTransactionsVC.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
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
            self.view.frame.origin.y = 0 - keyboardSize.height
        }
        
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        // move back the root view origin to zero
        self.view.frame.origin.y = 0
    }
    
}
