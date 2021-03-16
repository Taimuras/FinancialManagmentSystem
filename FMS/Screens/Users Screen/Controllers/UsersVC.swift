//
//  UsersVC.swift
//  FMS
//
//  Created by tami on 3/8/21.
//

import UIKit

class UsersVC: UIViewController {
    
    
    var users = [UserCellModel]()
    
    let constants = Constants()
    
    
    @IBOutlet weak var usersLabel: UILabel!
    @IBOutlet weak var addLabel: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    
    
    @IBOutlet weak var userTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userTableView.register(UINib(nibName: "UserTBCell", bundle: nil), forCellReuseIdentifier: constants.userScreenTableViewCellIdentifier)
        
        
        
        
        userTableView.delegate = self
        userTableView.dataSource = self
        zaglushkaDataCell()
        
    }
    
    @IBAction func addButtonTapped(_ sender: UIButton) {
        print("Add button Tapped")
    }
    
    func zaglushkaDataCell() {
        for _ in 1 ... 25 {
            let user = UserCellModel(imageUrl: "", name: "Timur", email: "Avelonadreamer@gmail.com")
            users.append(user)
        }
        userTableView.reloadData()
    }
    

}



extension UsersVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: constants.userScreenTableViewCellIdentifier, for: indexPath) as! UserTBCell
        cell.frame.size.width = tableView.frame.size.width
        cell.nameLabel.text = users[indexPath.row].name
        cell.emailLabel.text = users[indexPath.row].email
        
        
        //separator width = tableview.width
        cell.preservesSuperviewLayoutMargins = false
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
        
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = users[indexPath.row]
        print("Name: \(user.name) \nEmail: \(user.email) \n")
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 68
    }
    
    
    
    
}
