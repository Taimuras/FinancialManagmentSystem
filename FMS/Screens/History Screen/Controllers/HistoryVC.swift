//
//  HistoryVC.swift
//  FMS
//
//  Created by tami on 3/31/21.
//

import UIKit
import MBProgressHUD


class HistoryVC: UIViewController {
    
    let constants = Constants()
    var history: [HistoryModel] = []
    let fetchActions = FetchingAllActions()
    
    
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var deleteHistoryButton: UIButton!
    
    @IBOutlet weak var historyLabel: UILabel!
    
    
    @IBOutlet weak var historyCollectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        fetchData()
        // Do any additional setup after loading the view.
    }
    

   
    @IBAction func cancelButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func deleteButtonTapped(_ sender: UIButton) {
    }
    
    

}

extension HistoryVC{
    // MARK: Fetching Data first try
    func fetchData () {
        fetchActions.fetchingActions { (data) in
            print(data)
        }
        
        
//        fetchingTransactions.fetchingTransactions(url: constants.transitionsEndPoint) { (data) in
//            DispatchQueue.main.async {
//                self.mainVCData.removeAll()
//                self.mainVCData = data
//                self.mainScreenCollectionView.reloadData()
//                MBProgressHUD.hide(for: self.view, animated: true)
//            }
//            
//        }
        
    }
    
    func updateNextSet(){
        fetchActions.fetchingMoreActions { (data) in
            print(data)
        }
    }
    
}



extension HistoryVC: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionViewDelegates(){
        historyCollectionView.delegate = self
        historyCollectionView.dataSource = self
    }
    
    func registerCWCell (){
        //CollectionViewCell Nib Registration
        historyCollectionView.register(UINib(nibName: constants.historyCollectionViewCellIdentifier, bundle: .main), forCellWithReuseIdentifier: constants.historyCollectionViewCellIdentifier)
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return history.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = historyCollectionView.dequeueReusableCell(withReuseIdentifier: constants.historyCollectionViewCellIdentifier, for: indexPath) as! HistoryCVCell
        
        let index = history[indexPath.row]
        
        
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == history.count - 5 {  //numberofitem count
            updateNextSet()
        }
    }
    
    
}



extension HistoryVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 105)
    }
}
