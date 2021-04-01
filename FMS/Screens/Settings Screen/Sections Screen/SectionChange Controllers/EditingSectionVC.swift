//
//  EditingSectionVC.swift
//  FMS
//
//  Created by tami on 3/31/21.
//

import UIKit
import MBProgressHUD

class EditingSectionVC: UIViewController {
    
    
    let constants = Constants()
    
    var id: Int?
    var categorys: [CategoryModel] = []
    
    
    let deleteSectionByID = DeleteSectionByID()
    let getSingleSectionByID = GetSingleSectionByID()
    let updateSectionByID = UpdateSectionByID()
    
    @IBOutlet weak var sectionLabel: UILabel!
    @IBOutlet weak var addCategoryLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    
    @IBOutlet weak var sectionNameTextField: UITextField!
    
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var deleteSignButton: UIButton!
    
    
    @IBOutlet weak var categoryTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        categoryTableView.register(UINib(nibName: "CategoryTVCell", bundle: nil), forCellReuseIdentifier: constants.categoryPartTableViewCellIdentifier)
        
        
        categoryTableView.delegate = self
        categoryTableView.dataSource = self
        
        let footerView = UIView()
        categoryTableView.tableFooterView = footerView
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(pullToRefresh), for: .valueChanged)
        
        // this is the replacement of implementing: "collectionView.addSubview(refreshControl)"
        categoryTableView.refreshControl = refreshControl
        
        
        MBProgressHUD.showAdded(to: self.view, animated: true)
        getSection()
        
        
        
        design()
        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        MBProgressHUD.showAdded(to: self.view, animated: true)
        DispatchQueue.main.async {
            self.getSection()
        }
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


extension EditingSectionVC{
    
    func getSection() {
        
        getSingleSectionByID.getSingleSectiontByID(id: id!) { (data) in
            DispatchQueue.main.async {
                self.sectionNameTextField.text = data.name
                self.categorys.removeAll()
                self.categorys = data.category_set
                self.categoryTableView.reloadData()
                MBProgressHUD.hide(for: self.view, animated: true)
            }
        }
    }
    
    func update() {
        MBProgressHUD.showAdded(to: self.view, animated: true)
        if let name = sectionNameTextField.text{
            updateSectionByID.updateSection(id: id!, name: name) { (response) in
                if response != 1 {
                    let dialogMessage = UIAlertController(title: "Упс", message: "Что-то пошло не так. Пользователь не был создан!", preferredStyle: .alert)
                    let cancel = UIAlertAction(title: "Ok", style: .cancel) { (action) -> Void in
                        //            print("Cancel button tapped")
                    }
                    
                    dialogMessage.addAction(cancel)
                    
                    // Present dialog message to user
                    MBProgressHUD.hide(for: self.view, animated: true)
                    self.present(dialogMessage, animated: true, completion: nil)
                } else {
                    self.dismiss(animated: true, completion: nil)
                }
            }
        } else {
            let dialogMessage = UIAlertController(title: "Поле не заполнено", message: "Название направления должно быть заполнено!", preferredStyle: .alert)
            let cancel = UIAlertAction(title: "Хорошо", style: .cancel) { (action) -> Void in
                //            print("Cancel button tapped")
            }
            
            dialogMessage.addAction(cancel)
            
            // Present dialog message to user
            MBProgressHUD.hide(for: self.view, animated: true)
            self.present(dialogMessage, animated: true, completion: nil)
        }
        
    }
    
    func delete(){
        MBProgressHUD.showAdded(to: self.view, animated: true)
        deleteSectionByID.deleteSectionByID(id: id!) { (response) in
            if response == 1{
                self.dismiss(animated: true, completion: nil)
            } else {
                let dialogMessage = UIAlertController(title: "Упс", message: "Что-то пошло не так!", preferredStyle: .alert)
                let cancel = UIAlertAction(title: "Хорошо", style: .cancel) { (action) -> Void in
        //            print("Cancel button tapped")
                }
                dialogMessage.addAction(cancel)
                MBProgressHUD.hide(for: self.view, animated: true)
                self.present(dialogMessage, animated: true, completion: nil)
            }
        }
    }
    
    @objc func pullToRefresh(refreshControl: UIRefreshControl) {
        

        // somewhere in your code you might need to call:
        refreshControl.endRefreshing()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "CategoryAddingSegue" {
            let addingCategoryVC = segue.destination as! AddingCategoryVC
            addingCategoryVC.sectionID = id
        }
    }
}


extension EditingSectionVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        categorys.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: constants.categoryPartTableViewCellIdentifier, for: indexPath) as! CategoryTVCell
        cell.frame.size.width = tableView.frame.size.width
        
        
        cell.categoryLabel.text = categorys[indexPath.row].name
        
        
        //separator width = tableview.width
        cell.preservesSuperviewLayoutMargins = false
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
        
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let category = categorys[indexPath.row]
        let edititngCategory = storyboard?.instantiateViewController(withIdentifier: constants.categoryPartEditingVC) as! EditingCategoryVC
        edititngCategory.id = category.id
//        edititngUser.userEmail = user.email
        present(edititngCategory, animated: true, completion: nil)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}




extension EditingSectionVC{
    func design (){
        
        
        saveButton.layer.cornerRadius = 10.0
        saveButton.layer.masksToBounds = true
        saveButton.titleLabel?.font = constants.fontSemiBold17
        cancelButton.titleLabel?.font = constants.fontRegular17
        deleteSignButton.titleLabel?.font = constants.fontRegular17
        
        

        //Fonts + sizes

        sectionLabel.font = constants.fontRegular17
        sectionNameTextField.font = constants.fontRegular17
        addCategoryLabel.font = constants.fontRegular17
        categoryLabel.font = constants.fontSemiBold17
       
        
        
    }
}
