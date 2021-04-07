//
//  AnalyticsFiltrationVC.swift
//  FMS
//
//  Created by tami on 4/7/21.
//

import UIKit

class AnalyticsFiltrationVC: UIViewController {
    
    let constants = Constants()
    
    @IBOutlet weak var filtrationLabel: UILabel!
    
    
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    
    @IBOutlet weak var segmentedController: UISegmentedControl!
    
    
    @IBOutlet weak var analysisTextField: UITextField!
    @IBOutlet weak var dateFromTextField: UITextField!
    @IBOutlet weak var dateToTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        
        
        design()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func cancelButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
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
        filtrationLabel.font = constants.fontSemiBold17
        
        
       
        
    }
}
