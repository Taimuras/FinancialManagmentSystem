import UIKit
import MBProgressHUD

protocol FilterVCDelegate {
    func getFilteredUrl(url: String, dateFrom: String, dateTo: String)
}

class FilterVC: UIViewController {
    
    var delegate: FilterVCDelegate?
    
    
    var directions: [DirectionModel] = []
    var counterAgents: [CounterAgentsModel] = []
    var wallets: [WalletModel] = []
    let type: [String] = ["Все", "Доход", "Расход", "Перевод"]
    
    let constants = Constants()
    
    let fetchingData = FetchingDataFilterScreen()
    @IBOutlet weak var filtrationLabel: UILabel!
    
    @IBOutlet weak var cancelButton: UIButton!
    
    // TextFields
    @IBOutlet weak var typeTextField: UITextField!
    @IBOutlet weak var dateFromTextField: UITextField!
    @IBOutlet weak var dateToTextField: UITextField!
    @IBOutlet weak var walletTextField: UITextField!
    @IBOutlet weak var counterAgentTextField: UITextField!
    @IBOutlet weak var directionTextField: UITextField!
    
    var walletID: Int = 0
    var counterAgentID: Int = 0
    var directionID: Int = 0
    var typeID: Int = 0
    var dateFrom: String?
    var dateTo: String?
    
    
    @IBOutlet weak var acceptButton: UIButton!
    
    
    let datePicker = UIDatePicker()
    
    
    let walletPickerView = UIPickerView()
    let counterAgentPickerView = UIPickerView()
    let directionPickerView = UIPickerView()
    let typePickerView = UIPickerView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        MBProgressHUD.showAdded(to: self.view, animated: true)
        design()
//        keyBoardShowAndHide()
        createDatePicker()
        pickerViewDelegatesAndDataSource()
        
        fetchData()
        
        
        self.hideKeyboardWhenTappedAround() 
        
    }
    

    @IBAction func cancelButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    

    @IBAction func acceptButtonTapped(_ sender: UIButton) {
        
        delegate?.getFilteredUrl(url: returnUrl(wallet: walletTextField.text!, counterAgent: counterAgentTextField.text!, section: directionTextField.text!, type: typeID), dateFrom: dateFrom!, dateTo: dateTo!)
        
    }
    
    func returnUrl(wallet: String, counterAgent: String, section: String, type: Int) -> String{ //, direction: String
        
        var url = "?date_join_after=\(dateFrom!)&date_join_before=\(dateTo!)"
        
        if typeID != 0 {
            url = url + "&type=\(typeID)"
        }
        
        if !counterAgent.isEmpty && wallet.isEmpty && section.isEmpty{
            url = url + "&counterpart=\(counterAgentID)"
            return url
        }else if counterAgent.isEmpty && !wallet.isEmpty && section.isEmpty{
            url = url + "&wallet=\(walletID)"
            return url
        } else if counterAgent.isEmpty && wallet.isEmpty && !section.isEmpty{
            url = url + "&section=\(directionID)"
            return url
        } else if !counterAgent.isEmpty && !wallet.isEmpty && section.isEmpty{
            url = url + "&wallet=\(walletID)&counterpart=\(counterAgentID)"
            return url
        }else if !counterAgent.isEmpty && wallet.isEmpty && !section.isEmpty{
            url = url + "&section=\(directionID)&counterpart=\(counterAgentID)"
            return url
        }else if counterAgent.isEmpty && !wallet.isEmpty && !section.isEmpty{
            url = url + "&wallet=\(walletID)&section=\(directionID)"
            return url
        }else if !counterAgent.isEmpty && !wallet.isEmpty && !section.isEmpty{
            url = url + "&wallet=\(walletID)&section=\(directionID)&counterpart=\(counterAgentID)"
            return url
        }
        
        
        return url
    }
    
}

extension FilterVC{
    func fetchData(){
        fetchingData.fetchingWallets(url: constants.walletEndPoint) { (data) in
            DispatchQueue.main.async {
                self.wallets = data
            }
            
        }
        fetchingData.fetchingCounterAgents(url: constants.counterAgentEndPoint) { (data) in
            DispatchQueue.main.async {
                self.counterAgents = data
            }
            
        }
        fetchingData.fetchingDirections(url: constants.directionsEndPoint) { (data) in
            DispatchQueue.main.async {
                self.directions = data
                MBProgressHUD.hide(for: self.view, animated: true)
            }
            
        }
    }
    
}



extension FilterVC: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView.tag {
        case 1:
            return wallets.count
        case 2:
            return counterAgents.count
        case 3:
            return directions.count
        case 4:
            return type.count
        default:
            return 1
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView.tag {
        case 1:
            return wallets[row].name
        case 2:
            return counterAgents[row].name
        case 3:
            return directions[row].name
        case 4:
            return type[row]
        default:
            return "Data Not Found"
        }
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView.tag {
        case 1:
            walletTextField.text = wallets[row].name
            walletID = wallets[row].id
            walletTextField.resignFirstResponder()
        case 2:
            counterAgentTextField.text = counterAgents[row].name
            counterAgentID = counterAgents[row].id
            counterAgentTextField.resignFirstResponder()
        case 3:
            directionTextField.text = directions[row].name
            directionID = directions[row].id
            directionTextField.resignFirstResponder()
        case 4:
            typeTextField.text = type[row]
            if row == 1 {
                typeID = 1
            }else if row == 2 {
                typeID = 2
            }else if row == 3 {
                typeID = 3
            }
            typeTextField.resignFirstResponder()
        default:
            return
        }
    }
    
    
    
    
    func pickerViewDelegatesAndDataSource() {
        walletPickerView.delegate = self
        walletPickerView.dataSource = self
        walletTextField.inputView = walletPickerView
        
        counterAgentPickerView.delegate = self
        counterAgentPickerView.dataSource = self
        counterAgentTextField.inputView = counterAgentPickerView
        
        directionPickerView.delegate = self
        directionPickerView.dataSource = self
        directionTextField.inputView = directionPickerView
        
        typePickerView.delegate = self
        typePickerView.dataSource = self
        typeTextField.inputView = typePickerView
        
        walletPickerView.tag = 1
        counterAgentPickerView.tag = 2
        directionPickerView.tag = 3
        typePickerView.tag = 4
        
    }
}


extension FilterVC{
    func design (){
        
        
        acceptButton.layer.cornerRadius = 10.0
        acceptButton.layer.masksToBounds = true
        acceptButton.titleLabel?.font = constants.fontSemiBold17
        cancelButton.titleLabel?.font = constants.fontRegular17
        
        //Fonts + sizes
        
        typeTextField.font = constants.fontRegular17
        dateToTextField.font = constants.fontRegular17
        dateFromTextField.font = constants.fontRegular17
        directionTextField.font = constants.fontRegular17
        walletTextField.font = constants.fontRegular17
        counterAgentTextField.font = constants.fontRegular17
       
        
    }
}

extension FilterVC{
    func createDatePicker () {
        let currentDate = Date()
        let dateMonthAgo = Calendar.current.date(byAdding: .month, value: -1, to: currentDate)
        
        let loc = Locale(identifier: "ru_RU")
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        formatter.locale = loc
        
        let local = Locale(identifier: "en_US_POSIX")
        let form = DateFormatter()
        form.dateFormat = "yyyy-MM-dd'T'hh:mm"
        form.locale = local
        self.dateFrom = constants.filteredDateToServer(date: dateMonthAgo!)
        
        self.dateTo = constants.filteredDateToServer(date: currentDate)
            
       
        
        dateFromTextField.text = formatter.string(from: dateMonthAgo!)
        dateToTextField.text = formatter.string(from: currentDate)
        
        //toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        toolbar.backgroundColor = UIColor(red: 102/255, green: 193/255, blue: 73/255, alpha: 1)
        
        
        datePicker.locale = loc
        
        //bar Button
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        doneButton.tintColor = UIColor(red: 102/255, green: 193/255, blue: 73/255, alpha: 1)
        toolbar.setItems([doneButton], animated: true)
        datePicker.preferredDatePickerStyle = .wheels
        //assign toolbar
        dateToTextField.inputAccessoryView = toolbar
        
        dateToTextField.inputView = datePicker
        datePicker.datePickerMode = .date
        
        dateFromTextField.inputAccessoryView = toolbar
        
        dateFromTextField.inputView = datePicker
        datePicker.datePickerMode = .date
    }
    @objc func donePressed(){
        
        
        
        
        if dateToTextField.isEditing{
            dateToTextField.text = constants.dateToString(date: datePicker.date)
            
            self.dateTo = constants.filteredDateToServer(date: datePicker.date)
           
            self.view.endEditing(true)
        } else if dateFromTextField.isEditing{
            dateFromTextField.text = constants.dateToString(date: datePicker.date)
            
            self.dateFrom = constants.filteredDateToServer(date: datePicker.date)
            
            self.view.endEditing(true)
        }
        
    }
    
}


extension FilterVC {
    
    
    func keyBoardShowAndHide(){
        NotificationCenter.default.addObserver(self, selector: #selector(FilterVC.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        // call the 'keyboardWillHide' function when the view controlelr receive notification that keyboard is going to be hidden
        NotificationCenter.default.addObserver(self, selector: #selector(FilterVC.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
    
    @objc func keyboardWillShow(notification: NSNotification) {
        
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            // if keyboard size is not available for some reason, dont do anything
            return
        }
        
        // move the root view up by the distance of keyboard height
        if dateFromTextField.isEditing{
            self.view.frame.origin.y = 0 - keyboardSize.height + 255
        } else if dateToTextField.isEditing{
            self.view.frame.origin.y = 0 - keyboardSize.height + 204
        }else if walletTextField.isEditing{
            self.view.frame.origin.y = 0 - keyboardSize.height + 153
        }else if counterAgentTextField.isEditing{
            self.view.frame.origin.y = 0 - keyboardSize.height + 102
        }else if directionTextField.isEditing{
            self.view.frame.origin.y = 0 - keyboardSize.height + 51
        }
        
        
        
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        // move back the root view origin to zero
        self.view.frame.origin.y = 0
    }
    
}
