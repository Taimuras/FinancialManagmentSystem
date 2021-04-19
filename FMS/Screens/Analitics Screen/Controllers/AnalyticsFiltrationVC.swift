//
//  AnalyticsFiltrationVC.swift
//  FMS
//
//  Created by tami on 4/7/21.
//

import UIKit
import MBProgressHUD

protocol AnalyticsFiltrationVCDelegate {
    func neededData(type: Int, section: String, dateFrom: String, dateTo: String)
}




class AnalyticsFiltrationVC: UIViewController {
    
    var delegate: AnalyticsFiltrationVCDelegate?
    
    let constants = Constants()
    var dateFrom: String?
    var dateTo: String?
    let type: [String] = ["Проекты", "Контрагенты", "Категории"]
    var sectionName: String?
    var typeID: Int?
    
    @IBOutlet weak var filtrationLabel: UILabel!
    
    
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    
    @IBOutlet weak var segmentedController: UISegmentedControl!
    
    
    @IBOutlet weak var analysisTextField: UITextField!
    @IBOutlet weak var dateFromTextField: UITextField!
    @IBOutlet weak var dateToTextField: UITextField!
    
    let datePicker = UIDatePicker()
    let typePickerView = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        
        createDatePicker()
        pickerViewDelegatesAndDataSource()
        design()
        self.hideKeyboardWhenTappedAround() 
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func cancelButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        
        
        if segmentedController.selectedSegmentIndex == 0 {
            typeID = 1
        } else if segmentedController.selectedSegmentIndex == 1{
            typeID = 2
        }
        
        
        if analysisTextField.text != "" {
            delegate?.neededData(type: typeID!, section: analysisTextField.text!, dateFrom: dateFrom!, dateTo: dateTo!)
        } else {
            let dialogMessage = UIAlertController(title: "Поля не заполнены", message: "Имя и Фамилия должны быть заполнены!", preferredStyle: .alert)
            let cancel = UIAlertAction(title: "Хорошо", style: .cancel) { (action) -> Void in
                //            print("Cancel button tapped")
            }
            
            dialogMessage.addAction(cancel)
            
            // Present dialog message to user
//            MBProgressHUD.hide(for: self.view, animated: true)
            self.present(dialogMessage, animated: true, completion: nil)
        }
    }
    
    
    

}


extension AnalyticsFiltrationVC: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView.tag {
        case 4:
            return type.count - 1
        default:
            return 1
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView.tag {
        case 4:
            return type[row]
        default:
            return "Data Not Found"
        }
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView.tag {
        case 4:
            analysisTextField.text = type[row]
            if row == 0 {
                sectionName = "projects"
            }else if row == 1 {
                sectionName = "counterpart"
            }else if row == 2 {
                sectionName = "categories"
            }
            
            analysisTextField.resignFirstResponder()
        default:
            return
        }
    }
    
    
    
    
    func pickerViewDelegatesAndDataSource() {
        
        typePickerView.delegate = self
        typePickerView.dataSource = self
        analysisTextField.inputView = typePickerView
        
        
        typePickerView.tag = 4
        
    }
}


extension AnalyticsFiltrationVC{
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


extension AnalyticsFiltrationVC{
    func design (){
        
        
        saveButton.layer.cornerRadius = 10.0
        saveButton.layer.masksToBounds = true
        saveButton.titleLabel?.font = constants.fontSemiBold17
        cancelButton.titleLabel?.font = constants.fontRegular17
        
        //Fonts + sizes
        dateToTextField.font = constants.fontRegular17
        dateFromTextField.font = constants.fontRegular17
        analysisTextField.font = constants.fontRegular17
        filtrationLabel.font = constants.fontSemiBold17
        
        
       
        
    }
}
