//
//  WalletsVC.swift
//  FMS
//
//  Created by tami on 3/27/21.
//

import UIKit

class WalletsVC: UIViewController {
    
    let constants = Constants()
    let userDefaults = UserDefaults.standard
    
    var wallets: [WalletModel] = []
    
    let getAllWallets = GetAllWallets()
    
    @IBOutlet weak var addLabel: UILabel!
    @IBOutlet weak var walletTableView: UITableView!
    
    
    
    @IBOutlet weak var plusSignButtonHeight: NSLayoutConstraint!
    
    @IBOutlet weak var addLabelHeight: NSLayoutConstraint!
    
    @IBOutlet weak var addViewHeight: NSLayoutConstraint!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if userDefaults.integer(forKey: "Admin") != 1 {
            userOptions()
        }
        
        
        
        walletTableView.register(UINib(nibName: "WalletTVCell", bundle: nil), forCellReuseIdentifier: constants.walletPartTableViewCellIdentifier)
        // Do any additional setup after loading the view.
        
        
        getAll()
        
        
        walletTableView.delegate = self
        walletTableView.dataSource = self
        
        let footerView = UIView()
        walletTableView.tableFooterView = footerView
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(pullToRefresh), for: .valueChanged)
        
        // this is the replacement of implementing: "collectionView.addSubview(refreshControl)"
        walletTableView.refreshControl = refreshControl
        
        design()
        self.hideKeyboardWhenTappedAround()
    }
    
    
    @objc func pullToRefresh(refreshControl: UIRefreshControl) {
        getAll()

        // somewhere in your code you might need to call:
        refreshControl.endRefreshing()
    }
    
    func userOptions(){
        addLabelHeight.constant = 0
        plusSignButtonHeight.constant = 0
        addViewHeight.constant = 0
        
    }

    
    
    

}


extension WalletsVC{
    
    func getAll() {
        getAllWallets.getAllWallets(url: constants.walletEndPoint) { (data) in
            DispatchQueue.main.async {
//                print("Wallets Data: \(data)")
                self.wallets.removeAll()
                self.wallets = data
                self.walletTableView.reloadData()
            }
        }
    }
    
}




extension WalletsVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return wallets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: constants.walletPartTableViewCellIdentifier, for: indexPath) as! WalletTVCell
        cell.frame.size.width = tableView.frame.size.width
        
        

        cell.walletNameLabel.text = wallets[indexPath.row].name
        
        
        //separator width = tableview.width
        cell.preservesSuperviewLayoutMargins = false
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
        
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if userDefaults.integer(forKey: "Admin") == 1 {
            let wallet = wallets[indexPath.row]
            let editingWallet = storyboard?.instantiateViewController(withIdentifier: constants.walletsPartEditingVC) as! EditingWalletsVC
            editingWallet.id = wallet.id
            present(editingWallet, animated: true, completion: nil)
        }
        
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}


extension WalletsVC{
    func design (){
        
        addLabel.font = constants.fontSemiBold16
       
    }
}
