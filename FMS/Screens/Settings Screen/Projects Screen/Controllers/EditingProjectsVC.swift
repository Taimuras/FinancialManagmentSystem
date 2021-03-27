//
//  EditingProjectsVC.swift
//  FMS
//
//  Created by tami on 3/27/21.
//

import UIKit
import MBProgressHUD

class EditingProjectsVC: UIViewController {
    
    
    let constants = Constants()
    var id: Int?
    
    
    
    
    @IBOutlet weak var projectLabel: UILabel!
    
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var deleteSignButton: UIButton!
    
    
    @IBOutlet weak var nameTextField: UITextField!
    
    
    let getSingleProjectByID = GetSingleProjectByID()
    let deleteProject = DeleteProject()
    let updateProject = UpdateProjectByID()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        MBProgressHUD.showAdded(to: self.view, animated: true)
        
        getSingleProject()
        
        
        
        
        
        design()
        // Do any additional setup after loading the view.
    }
 
    
    
    @IBAction func cancelButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func deleteButtonTapped(_ sender: UIButton) {
        delete()
    }
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        update()
    }
    
}




extension EditingProjectsVC{
    func getSingleProject() {
        let url = constants.getAllProjects + String(id!)
        getSingleProjectByID.GetSingleProjectByID(url: url) { (data) in
            DispatchQueue.main.async {
                
                self.nameTextField.text = data.name
                
                MBProgressHUD.hide(for: self.view, animated: true)
            }
        }
    }
    
    
    func delete(){
        deleteProject.deleteProjectByID(id: id!) { (response) in
            if response == 1{
                self.dismiss(animated: true, completion: nil)
            } else {
                let dialogMessage = UIAlertController(title: "Упс", message: "Что-то пошло не так!", preferredStyle: .alert)
                let cancel = UIAlertAction(title: "Хорошо", style: .cancel) { (action) -> Void in
        //            print("Cancel button tapped")
                }
                dialogMessage.addAction(cancel)
                self.present(dialogMessage, animated: true, completion: nil)
            }
        }
    }
    
    func update() {
        if let name = nameTextField.text{
            updateProject.updateProject(id: id!, name: name){ (response) in
                if response != 1 {
                    let dialogMessage = UIAlertController(title: "Упс", message: "Что-то пошло не так. Пользователь не был создан!", preferredStyle: .alert)
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
            let dialogMessage = UIAlertController(title: "Поля не заполнены", message: "Имя и Фамилия должны быть заполнены!", preferredStyle: .alert)
            let cancel = UIAlertAction(title: "Хорошо", style: .cancel) { (action) -> Void in
                //            print("Cancel button tapped")
            }
            
            dialogMessage.addAction(cancel)
            
            // Present dialog message to user
            self.present(dialogMessage, animated: true, completion: nil)
        }
        
    }
}




extension EditingProjectsVC{
    func design(){
        
        
        saveButton.layer.cornerRadius = 10.0
        saveButton.layer.masksToBounds = true
        saveButton.titleLabel?.font = constants.fontSemiBold17
        cancelButton.titleLabel?.font = constants.fontRegular17
        deleteSignButton.titleLabel?.font = constants.fontRegular17
        
        

        //Fonts + sizes

        projectLabel.font = constants.fontSemiBold17
        nameTextField.font = constants.fontRegular17
        
        
       
        
        
    }
}
