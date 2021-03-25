//
//  AddingCounterPartVC.swift
//  FMS
//
//  Created by tami on 3/25/21.
//

import UIKit

class AddingCounterPartVC: UIViewController {
    let constants = Constants()

    var counterPartID: Int?
    
    @IBOutlet weak var counterPartLabel: UILabel!
    
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    
    
    
    @IBOutlet weak var surnameTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var patronymicTextField: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()


        
        design()
        // Do any additional setup after loading the view.
    }
    

}


extension AddingCounterPartVC{
    func design (){
        
        
        saveButton.layer.cornerRadius = 10.0
        saveButton.layer.masksToBounds = true
        saveButton.titleLabel?.font = constants.fontSemiBold17
        cancelButton.titleLabel?.font = constants.fontRegular17
        
        

        //Fonts + sizes

        surnameTextField.font = constants.fontRegular17
        nameTextField.font = constants.fontRegular17
        patronymicTextField.font = constants.fontRegular17
        counterPartLabel.font = constants.fontSemiBold17
       
        
        
    }
}
