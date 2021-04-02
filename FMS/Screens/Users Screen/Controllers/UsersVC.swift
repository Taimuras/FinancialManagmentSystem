
import UIKit
import MBProgressHUD



class UsersVC: UIViewController {
    
    
    var users = [AllUsersModel]()
    
    let constants = Constants()
    let userDefaults = UserDefaults.standard
    let networkWorking = NetworkGetAllUsers()
    
    
    @IBOutlet weak var usersLabel: UILabel!
    
    @IBOutlet weak var addLabel: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var createUserButtonView: UIView!
    @IBOutlet weak var plusSignButton: UIButton!
    
    
    @IBOutlet weak var userImageHeight: NSLayoutConstraint!
    @IBOutlet weak var addLabelHeight: NSLayoutConstraint!
    @IBOutlet weak var plusSignButtonHeight: NSLayoutConstraint!
    @IBOutlet weak var addViewHeight: NSLayoutConstraint!
    
    
    
    
    @IBOutlet weak var userTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        
        
//        print("Is Admin: ------------------>  \(userDefaults.integer(forKey: "Admin"))")
        
        
        
        
        userTableView.register(UINib(nibName: "UserTBCell", bundle: nil), forCellReuseIdentifier: constants.userScreenTableViewCellIdentifier)
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(pullToRefresh), for: .valueChanged)
        userTableView.refreshControl = refreshControl
        
        userTableView.delegate = self
        userTableView.dataSource = self
        
        
        MBProgressHUD.showAdded(to: self.view, animated: true)
       
        getData()
        
        
        let footerView = UIView()
        userTableView.tableFooterView = footerView
        
        
        design()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if userDefaults.integer(forKey: "Admin") != 1 {
            userOptions()
        }
        
        MBProgressHUD.showAdded(to: self.view, animated: true)
        DispatchQueue.main.async {
            self.getData()
        }
    }
    
    func userOptions(){
        addLabelHeight.constant = 0
        userImageHeight.constant = 0
        plusSignButtonHeight.constant = 0
        addViewHeight.constant = 0
        
    }
    
    
    @IBAction func historyButtonTapped(_ sender: UIButton) {
        let historyVC = storyboard?.instantiateViewController(withIdentifier: constants.historyVC) as! HistoryVC
        present(historyVC, animated: true, completion: nil)
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
                MBProgressHUD.hide(for: self.view, animated: true)
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
        
        cell.nameLabel.text = users[indexPath.row].first_name
        cell.emailLabel.text = users[indexPath.row].email
        
        
        //separator width = tableview.width
        cell.preservesSuperviewLayoutMargins = false
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
        
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        if userDefaults.integer(forKey: "Admin") == 1 {
            let user = users[indexPath.row]
            let edititngUser = storyboard?.instantiateViewController(withIdentifier: constants.userEditingVC) as! UserEditingVC
            edititngUser.userID = user.id
            edititngUser.userEmail = user.email
            present(edititngUser, animated: true, completion: nil)
        }
        
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
