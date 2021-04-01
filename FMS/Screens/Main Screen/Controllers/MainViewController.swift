//
//  MainViewController.swift
//  FMS
//
//  Created by tami on 3/3/21.
//

import UIKit
import MBProgressHUD


class MainViewController: UIViewController {
    
    var isFiltering: Bool = false
    
    let constants = Constants()
    let fetchingTransactions = FetchingTransactions()
    let getUser = GetSessionUser()
    
    var mainVCData: [TransactionModel] = []
    
    
    
    let userDefaults = UserDefaults.standard
    var refreshControl:UIRefreshControl = UIRefreshControl()
    
    
    //Design Fonts
    @IBOutlet weak var lastChangesLabel: UILabel!
    @IBOutlet weak var balansLabel: UILabel!
    @IBOutlet weak var outcomeLabel: UILabel!
    @IBOutlet weak var incomeLabel: UILabel!
    @IBOutlet weak var tranzactionLabel: UILabel!
    
    
    //Top Panel labels with income, outcome and transfer
    @IBOutlet weak var incomeStateLabel: UILabel!
    @IBOutlet weak var outcomeStateLabel: UILabel!
    @IBOutlet weak var transferStateLabel: UILabel!
    @IBOutlet weak var topPanelView: UIView!
    
    @IBOutlet weak var outcomePanelView: UIView!
    @IBOutlet weak var incomePanelView: UIView!
    @IBOutlet weak var transferPanelView: UIView!
    // CollectionView Outlet
    @IBOutlet weak var mainScreenCollectionView: UICollectionView!
    

    
    
    
    // MARK: ViewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        design()
        collectionViewDelegates()
        registerCWCell()
        refreshMainCVC()
        
        MBProgressHUD.showAdded(to: self.view, animated: true)
        
        fetchData()
        
        
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        MBProgressHUD.showAdded(to: self.view, animated: true)
        DispatchQueue.main.async {
            self.fetchData()
        }
    }
    
    @IBAction func filterButtonTapped(_ sender: UIButton) {
        
        let filterVC = storyboard?.instantiateViewController(withIdentifier: constants.filterVC) as! FilterVC
        filterVC.delegate = self
        present(filterVC, animated: true, completion: nil)
    }
    
    @IBAction func logOut(_ sender: UIButton) {
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
            self.userDefaults.removeObject(forKey: "Admin")
             
        })
        
        //Add OK and Cancel button to dialog message
        dialogMessage.addAction(ok)
        dialogMessage.addAction(cancel)
        
        
        // Present dialog message to user
        self.present(dialogMessage, animated: true, completion: nil)
    }
    
    
    @IBAction func historyButtonTapped(_ sender: UIButton) {
        let historyVC = storyboard?.instantiateViewController(withIdentifier: constants.historyVC) as! HistoryVC
        present(historyVC, animated: true, completion: nil)
    }
    
    
    
}


extension MainViewController{
    // MARK: Fetching Data first try
    func fetchData () {
        
        fetchingTransactions.fetchingTransactions(url: constants.transitionsEndPoint) { (data) in
            DispatchQueue.main.async {
                self.mainVCData.removeAll()
                self.mainVCData = data
                self.mainScreenCollectionView.reloadData()
                MBProgressHUD.hide(for: self.view, animated: true)
            }
            
        }
        
        fetchingTransactions.fetchingIncomeOutcomeBalance(url: constants.mainScreenFetchIncOutBalance) { (data) in
            
            DispatchQueue.main.async {
                self.incomeStateLabel.text = data.income
                self.outcomeStateLabel.text = data.balance
                self.transferStateLabel.text = data.outcome
            }
        }
    }
    
    
}


extension MainViewController{
    func refreshMainCVC(){
        mainVCData.removeAll()
        refreshControl.addTarget(self, action: #selector(didPullToRefresh(_:)), for: .valueChanged)
        mainScreenCollectionView.alwaysBounceVertical = true
        mainScreenCollectionView.refreshControl = refreshControl // i
    }
    
    @objc private func didPullToRefresh(_ sender: Any) {
        
        fetchData()
        refreshControl.endRefreshing()
    }
    

}


// MARK: Fetching Filtered Data
extension MainViewController: FilterVCDelegate{
    
    
    
    func getFilteredUrl(url: String, dateFrom: String, dateTo: String) {
        
        
            
        
        let endPoint = self.constants.transitionsEndPoint + url
        
//        print("Filtered End Point: \(endPoint)")
        self.fetchingTransactions.fetchingFilteredTransactions(url: endPoint, dateFrom: dateFrom, dateTo: dateTo) { (responseData) in
            
            
            DispatchQueue.main.async {
                
                self.mainVCData.removeAll()
                
                
                
                self.mainVCData = responseData
                
                
                self.mainScreenCollectionView.reloadData()
                
            }
            
        }
        self.dismiss(animated: true,completion: nil) 
        
        
    }
    
}



// MARK: CollectionVIew Delegate and DataSource
extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionViewDelegates(){
        mainScreenCollectionView.delegate = self
        mainScreenCollectionView.dataSource = self
    }
    
    func registerCWCell (){
        //CollectionViewCell Nib Registration
        mainScreenCollectionView.register(UINib(nibName: constants.mainScreenCollectionViewCellIdentifier, bundle: .main), forCellWithReuseIdentifier: constants.mainScreenCollectionViewCellIdentifier)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return mainVCData.count
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = mainScreenCollectionView.dequeueReusableCell(withReuseIdentifier: constants.mainScreenCollectionViewCellIdentifier, for: indexPath) as! MainCVC
        
        let index = mainVCData[indexPath.row]
        if index.type == "Доход" {
            cell.actionIcon.image = UIImage(named: "Income")
            cell.bankName.text = index.wallet
            cell.companyName.text = index.section
            cell.dateOfAction.text = constants.dateToString(date: constants.stringToDate(dateString: index.date_join))
            cell.actionValue.text = String(index.sum)
        } else if index.type == "Расход" {
            cell.actionIcon.image = UIImage(named: "Outcome")
            cell.bankName.text = index.wallet
            cell.companyName.text = index.section
            cell.dateOfAction.text = constants.dateToString(date: constants.stringToDate(dateString: index.date_join))
            cell.actionValue.text = String(index.sum)
        }else if index.type == "Перевод" {
            cell.actionIcon.image = UIImage(named: "Transfer")
            cell.bankName.text = index.wallet_to
            cell.companyName.text = index.wallet
            cell.dateOfAction.text = constants.dateToString(date: constants.stringToDate(dateString: index.date_join))
            cell.actionValue.text = String(index.sum)
        }
        
        
        
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if mainVCData[indexPath.row].type == "Доход" || mainVCData[indexPath.row].type == "Расход"{
            let editingVC = storyboard?.instantiateViewController(withIdentifier: constants.editingTransactionsVC) as! EditingTransactionsVC
            editingVC.idToUpdate = mainVCData[indexPath.row].id
            if mainVCData[indexPath.row].type == "Доход"{
                
                editingVC.typeToUpdate = 0
                editingVC.dateTime = mainVCData[indexPath.row].date_join
            } else if mainVCData[indexPath.row].type == "Расход"{
                
                editingVC.typeToUpdate = 1
                editingVC.dateTime = mainVCData[indexPath.row].date_join
            }
            present(editingVC, animated: true, completion: nil)
        } else if mainVCData[indexPath.row].type ==  "Перевод"{
            let edititngTransfer = storyboard?.instantiateViewController(withIdentifier: constants.editingTransferVC) as! EditingTransferVC
            edititngTransfer.idToUpdate = mainVCData[indexPath.row].id
            edititngTransfer.dateTime = mainVCData[indexPath.row].date_join
            present(edititngTransfer, animated: true, completion: nil)
        }

    }
}




// MARK: Collection View Layouts
extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 76)
    }
}



// MARK: Design
extension MainViewController{
    func design (){
        topPanelView.layer.cornerRadius = 10.0
        topPanelView.layer.masksToBounds = true
        
        //Fonts + sizes
        tranzactionLabel.font = constants.fontBold34
        lastChangesLabel.font = constants.fontSemiBold18
        balansLabel.font = constants.fontRegular12
        outcomeLabel.font = constants.fontRegular12
        incomeLabel.font = constants.fontRegular12
        
        
        incomeStateLabel.font = constants.fontBold18
        outcomeStateLabel.font = constants.fontBold18
        transferStateLabel.font = constants.fontBold18
        
        
        
        
        transferPanelView.frame.size.width = topPanelView.frame.size.width / 3
        incomePanelView.frame.size.width = topPanelView.frame.size.width / 3
        outcomePanelView.frame.size.width = topPanelView.frame.size.width / 3
    }
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
