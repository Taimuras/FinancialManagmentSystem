//
//  MainViewController.swift
//  FMS
//
//  Created by tami on 3/3/21.
//

import UIKit

class MainViewController: UIViewController {
    
    let constants = Constants()
    let fetchingTransactions = FetchingTransactions()
    
    var mainVCData: [TransitionsModel] = []
    
    
    let userDefaults = UserDefaults.standard
    
    
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
    

    let controller = FilterVC()
    
    
    // MARK: ViewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        controller.delegate = self
        
        design()
        collectionViewDelegates()
        registerCWCell()
        
        

//        let one: MainCVCModel = MainCVCModel(actionIconName: "Income", companyName: "Breez Pro", bankName: "1", date: "12.12.2012", actionValue: "12345,12")
//        let two: MainCVCModel = MainCVCModel(actionIconName: "Income", companyName: "Neobis", bankName: "2", date: "11.11.2000", actionValue: "12345,12")
//        mainVCData.append(one)
//        mainVCData.append(two)
//        mainVCData.append(one)
//        mainVCData.append(two)
//        mainVCData.append(one)
//        mainVCData.append(two)
//        mainVCData.append(one)
//        mainVCData.append(two)
//        mainVCData.append(one)
//        mainVCData.append(two)
        

        fetchData()
        
        
    }
    
    
    // MARK: VIewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        fetchData()
    }
    
    
    // MARK: Fetching Data first try
    func fetchData () {
        fetchingTransactions.fetchingTransactions(url: constants.fetchingAllTransactions) { (data) in
//            print(data)
            self.mainVCData = data
            self.mainScreenCollectionView.reloadData()
        }
        
        fetchingTransactions.fetchingIncomeOutcomeBalance(url: constants.mainScreenFetchIncOutBalance) { (data) in
            
            DispatchQueue.main.async {
                self.incomeStateLabel.text = data[0]
                self.outcomeStateLabel.text = data[1]
                self.transferStateLabel.text = data[2]
            }
            
            
//            @IBOutlet weak var incomeStateLabel: UILabel!
//            @IBOutlet weak var outcomeStateLabel: UILabel!
//            @IBOutlet weak var transferStateLabel: UILabel!
        }
    }
    
    

    @IBAction func logOut(_ sender: UIButton) {
        
        
        
        let dialogMessage = UIAlertController(title: "Confirm", message: "Are you sure you want to quit?", preferredStyle: .alert)
        
        
        
        // Create Cancel button with action handlder
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (action) -> Void in
            print("Cancel button tapped")
        }
        
        // Create OK button with action handler
        let ok = UIAlertAction(title: "OK", style: .destructive, handler: { (action) -> Void in
             print("Ok button tapped")
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
    
}


// MARK: Fetching Filtered Data
extension MainViewController: GetFilterRequestDelegate{
    
    func getFilterRequestParams(params: FilterModel) {
        fetchingTransactions.fetchingFilteredTransactions(url: "", params: params) { (data) in
            self.mainVCData = []
            self.mainVCData = data
            self.mainScreenCollectionView.reloadData()
        }
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
        
        cell.actionIcon.image = UIImage(named: index.actionIconName)
        cell.bankName.text = index.user
        cell.companyName.text = index.actionIconName
        cell.dateOfAction.text = index.date_join
        cell.actionValue.text = String(index.sum)
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if mainVCData[indexPath.row].id  % 2 == 0 {
            let editingVC = self.storyboard?.instantiateViewController(withIdentifier: constants.editingTransactionsVC) as! EditingTransactionsVC
            present(editingVC, animated: true, completion: nil)
        } else if mainVCData[indexPath.row].id % 2 != 0 {
            let edititngTransfer = self.storyboard?.instantiateViewController(withIdentifier: constants.editingTransferVC) as! EditingTransferVC
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
        
        
        incomeStateLabel.font = constants.fontSemiBold18
        outcomeStateLabel.font = constants.fontSemiBold18
        transferStateLabel.font = constants.fontSemiBold18
        
        
        
        
        transferPanelView.frame.size.width = topPanelView.frame.size.width / 3
        incomePanelView.frame.size.width = topPanelView.frame.size.width / 3
        outcomePanelView.frame.size.width = topPanelView.frame.size.width / 3
    }
}
