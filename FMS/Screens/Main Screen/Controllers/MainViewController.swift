//
//  MainViewController.swift
//  FMS
//
//  Created by tami on 3/3/21.
//

import UIKit

class MainViewController: UIViewController {
    
    let constants = Constants()
    
    var mainVCData: [MainCVCModel] = []
    
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
        
        mainScreenCollectionView.delegate = self
        mainScreenCollectionView.dataSource = self
        
        //CollectionViewCell Nib Registration
        mainScreenCollectionView.register(UINib(nibName: constants.mainScreenCollectionViewCellIdentifier, bundle: .main), forCellWithReuseIdentifier: constants.mainScreenCollectionViewCellIdentifier)

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
        
    }
    


}


extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource{
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
        
        transferPanelView.frame.size.width = topPanelView.frame.size.width / 3
        incomePanelView.frame.size.width = topPanelView.frame.size.width / 3
        outcomePanelView.frame.size.width = topPanelView.frame.size.width / 3
    }
}
