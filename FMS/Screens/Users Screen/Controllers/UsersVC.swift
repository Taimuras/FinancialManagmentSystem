
import UIKit

class UsersVC: UIViewController {
    
    
    var users = [AllUsersModel]()
    
    let constants = Constants()
    let userDefaults = UserDefaults.standard
    let networkWorking = NetworkGetAllUsers()
    
    
    @IBOutlet weak var usersLabel: UILabel!
    @IBOutlet weak var addLabel: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    
    @IBOutlet weak var createUserButtonView: UIView!
    
    @IBOutlet weak var userTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userTableView.register(UINib(nibName: "UserTBCell", bundle: nil), forCellReuseIdentifier: constants.userScreenTableViewCellIdentifier)
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(pullToRefresh), for: .valueChanged)
        userTableView.refreshControl = refreshControl
        
        userTableView.delegate = self
        userTableView.dataSource = self
        design()
        getData()
        
        
        let footerView = UIView()
        userTableView.tableFooterView = footerView
        
    }
    
    @IBAction func logOutTapped(_ sender: UIButton) {
        let dialogMessage = UIAlertController(title: "Выход", message: "Вы уверены, что хотите выйти?", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Отмена", style: .cancel) { (action) -> Void in
//            print("Cancel button tapped")
        }
        let ok = UIAlertAction(title: "Да", style: .destructive, handler: { (action) -> Void in
//             print("Ok button tapped")
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let mainTabBarController = storyboard.instantiateViewController(identifier: "LoginNavigationController")
            (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(mainTabBarController)

            self.userDefaults.removeObject(forKey: "AccessToken")
            self.userDefaults.removeObject(forKey: "RefreshToken")
             
        })
        
        //Add OK and Cancel button to dialog message
        dialogMessage.addAction(ok)
        dialogMessage.addAction(cancel)
        
        
        // Present dialog message to user
        self.present(dialogMessage, animated: true, completion: nil)
    }
    
    
    @IBAction func addButtonTapped(_ sender: UIButton) {
        print("Add button Tapped")
    }
    
    
    
    @objc func pullToRefresh(refreshControl: UIRefreshControl) {
        
        getData()
        // somewhere in your code you might need to call:
        refreshControl.endRefreshing()
    }
    
    
    func getData(){
        networkWorking.getAllUsers(url: constants.allUsersEndPoint) { (data) in
            DispatchQueue.main.async {
                self.users.removeAll()
                self.users = data
                self.userTableView.reloadData()
            }
        }
    }
    

}



extension UsersVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: constants.userScreenTableViewCellIdentifier, for: indexPath) as! UserTBCell
        cell.frame.size.width = tableView.frame.size.width
        cell.nameLabel.text = users[indexPath.row].first_name
        cell.emailLabel.text = users[indexPath.row].email
        
        
        //separator width = tableview.width
        cell.preservesSuperviewLayoutMargins = false
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
        
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = users[indexPath.row]
        let edititngUser = storyboard?.instantiateViewController(withIdentifier: constants.userEditingVC) as! UserEditingVC
        edititngUser.userID = user.id
        edititngUser.userEmail = user.email
        present(edititngUser, animated: true, completion: nil)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 68
    }
    
    
    
    
}



extension UsersVC{
    func design(){
   

        usersLabel.font = constants.fontBold34
        addLabel.font = constants.fontSemiBold16
        
       
        
        
    }
}
