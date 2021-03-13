import UIKit


protocol GetFilterRequestDelegate {
    func getFilterRequestParams( params:  FilterModel)
}

class FilterVC: UIViewController {
    
    var delegate: GetFilterRequestDelegate?
    
    
    let directions = ["India","Belarus","Russia","Kyrgyzstan","China","Uzbekistan","SAR","Korea","USA","Canada"]
    var counterAgents: [CounterAgentsModel] = []
    var wallets: [WalletModel] = []
    
    let constants = Constants()
    
    let fetchingData = FetchingDataFilterScreen()
    @IBOutlet weak var filtrationLabel: UILabel!
    
    @IBOutlet weak var cancelButton: UIButton!
    
    // TextFields
    @IBOutlet weak var dateFromTextField: UITextField!
    @IBOutlet weak var dateToTextField: UITextField!
    @IBOutlet weak var walletTextField: UITextField!
    @IBOutlet weak var counterAgentTextField: UITextField!
    @IBOutlet weak var directionTextField: UITextField!
    
    
    @IBOutlet weak var acceptButton: UIButton!
    
    
    let datePicker = UIDatePicker()
    
    
    let walletPickerView = UIPickerView()
    let counterAgentPickerView = UIPickerView()
    let directionPickerView = UIPickerView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        design()
        keyBoardShowAndHide()
        createDatePicker()
        pickerViewDelegatesAndDataSource()
        
        fetchData()
        
    }
    

    @IBAction func cancelButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    

    @IBAction func acceptButtonTapped(_ sender: UIButton) {
    }
}

extension FilterVC{
    func fetchData(){
        fetchingData.fetchingWallets(url: constants.walletEndPoint) { (data) in
            self.wallets = data
        }
        fetchingData.fetchingCounterAgents(url: constants.counterAgentEndPoint) { (data) in
            self.counterAgents = data
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
            return directions[row]
        default:
            return "Data Not Found"
        }
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView.tag {
        case 1:
            walletTextField.text = wallets[row].name
            walletTextField.resignFirstResponder()
        case 2:
            counterAgentTextField.text = counterAgents[row].name
            counterAgentTextField.resignFirstResponder()
        case 3:
            directionTextField.text = directions[row]
            directionTextField.resignFirstResponder()
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
        
        walletPickerView.tag = 1
        counterAgentPickerView.tag = 2
        directionPickerView.tag = 3
        
    }
}


extension FilterVC{
    func design (){
        
        
        acceptButton.layer.cornerRadius = 10.0
        acceptButton.layer.masksToBounds = true
        acceptButton.titleLabel?.font = constants.fontSemiBold17
        cancelButton.titleLabel?.font = constants.fontRegular17
        
        //Fonts + sizes
        
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
        let loc = Locale(identifier: "ru_RU")
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        formatter.locale = loc
        
        if dateToTextField.isEditing{
            dateToTextField.text = formatter.string(from: datePicker.date)
            self.view.endEditing(true)
        } else if dateFromTextField.isEditing{
            dateFromTextField.text = formatter.string(from: datePicker.date)
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