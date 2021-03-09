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
    
    var mainVCData: [MainCVCModel] = []
    
    
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
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        design()
        collectionViewDelegates()
        registerCWCell()
        
        

        let one: MainCVCModel = MainCVCModel(actionIconName: "Income", companyName: "Breez Pro", bankName: "Optima Bank", date: "12.12.2012", actionValue: "12345,12")
        mainVCData.append(one)
        mainVCData.append(one)
        mainVCData.append(one)
        mainVCData.append(one)
        mainVCData.append(one)
        mainVCData.append(one)
        mainVCData.append(one)
        mainVCData.append(one)
        mainVCData.append(one)
        mainVCData.append(one)
        
        
        fetchingTransactions.fetchingTransactions(url: constants.fetchingAllTransactions) { (data) in
            print(data)
        }
        
        
    }
    

    @IBAction func logOut(_ sender: UIButton) {
        
        
        
        let dialogMessage = UIAlertController(title: "Confirm", message: "Are you sure you want to quit?", preferredStyle: .alert)
        
        
        
        // Create Cancel button with action handlder
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (action) -> Void in
            print("Cancel button tapped")
        }
        
        // Create OK button with action handler
        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
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
        cell.bankName.text = index.bankName
        cell.companyName.text = index.companyName
        cell.dateOfAction.text = index.date
        cell.actionValue.text = index.actionValue
        
        return cell
    }
}



extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 76)
    }
}




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
