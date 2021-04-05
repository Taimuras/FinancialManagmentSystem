//
//  CounterPartVC.swift
//  FMS
//
//  Created by tami on 3/25/21.
//

import UIKit
import MBProgressHUD

class CounterPartVC: UIViewController {
    let constants = Constants()
    
    var counterAgents: [CounterPartModel] = []
    
    let getAllCounterParts = GetAllCounterParts()

    @IBOutlet weak var addButtonSignLabel: UILabel!
    
    @IBOutlet weak var counterPartTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        counterPartTableView.register(UINib(nibName: "CounterPartTBCell", bundle: nil), forCellReuseIdentifier: constants.counterPartTableViewCellIdentifier)
        
        counterPartTableView.delegate = self
        counterPartTableView.dataSource = self
        
        let footerView = UIView()
        counterPartTableView.tableFooterView = footerView
        
        MBProgressHUD.showAdded(to: self.view, animated: true)
        fetchData()
        
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(pullToRefresh), for: .valueChanged)
        
        // this is the replacement of implementing: "collectionView.addSubview(refreshControl)"
        counterPartTableView.refreshControl = refreshControl
        
        
        self.hideKeyboardWhenTappedAround() 
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        MBProgressHUD.showAdded(to: self.view, animated: true)
        DispatchQueue.main.async {
            self.fetchData()
        }
    }
    
    
    
    @IBAction func addButtonTapped(_ sender: UIButton) {
//        print("CounterPart Adding Button Tapped!!!")
    }
    
    
    
    @objc func pullToRefresh(refreshControl: UIRefreshControl) {
        fetchData()

        // somewhere in your code you might need to call:
        refreshControl.endRefreshing()
    }
    
    func fetchData(){
        
        getAllCounterParts.getAllCounterParts(url: constants.counterAgentEndPoint, completion: { (data) in
            DispatchQueue.main.async {
                self.counterAgents.removeAll()
                self.counterAgents = data
                self.counterPartTableView.reloadData()
                MBProgressHUD.hide(for: self.view, animated: true)
            }
        })
    }

}


extension CounterPartVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return counterAgents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: constants.counterPartTableViewCellIdentifier, for: indexPath) as! CounterPartTBCell
        cell.frame.size.width = tableView.frame.size.width
        
        
        cell.lastAndFirstNameLabel.text = counterAgents[indexPath.row].surname + " " + counterAgents[indexPath.row].name
        
        
        //separator width = tableview.width
        cell.preservesSuperviewLayoutMargins = false
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
        
        
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let counterPart = counterAgents[indexPath.row]
        let edititngCounterPart = storyboard?.instantiateViewController(withIdentifier: constants.counterPartEditingVC) as! EditingCounterPartVC
        edititngCounterPart.id = counterPart.id
//        edititngUser.userEmail = user.email
        present(edititngCounterPart, animated: true, completion: nil)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    
}
