//
//  SettingsVC.swift
//  FMS
//
//  Created by tami on 3/8/21.
//

import UIKit

class SettingsVC: UIViewController {
    let constants = Constants()
    
    @IBOutlet weak var counterPartContainer: UIView!
    @IBOutlet weak var projectsContainer: UIView!
    @IBOutlet weak var sectionsContainer: UIView!
    @IBOutlet weak var walletsContainer: UIView!
    
    
    @IBOutlet weak var settignsLabel: UILabel!
    @IBOutlet weak var segmentedOutlet: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        design()
        
        // Do any additional setup after loading the view.
    }
    

    @IBAction func segmentedSelected(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            counterPartContainer.alpha = 1
            projectsContainer.alpha = 0
            sectionsContainer.alpha = 0
            walletsContainer.alpha = 0
        } else if sender.selectedSegmentIndex == 1{
            counterPartContainer.alpha = 0
            projectsContainer.alpha = 1
            sectionsContainer.alpha = 0
            walletsContainer.alpha = 0
        }else if sender.selectedSegmentIndex == 2{
            counterPartContainer.alpha = 0
            projectsContainer.alpha = 0
            sectionsContainer.alpha = 1
            walletsContainer.alpha = 0
        }else if sender.selectedSegmentIndex == 3{
            counterPartContainer.alpha = 0
            projectsContainer.alpha = 0
            sectionsContainer.alpha = 0
            walletsContainer.alpha = 1
        }
        
    }
    
}


extension SettingsVC{
    func design(){
   

        settignsLabel.font = constants.fontBold34
//        addLabel.font = constants.fontSemiBold16
        
       
        
        
    }
}

