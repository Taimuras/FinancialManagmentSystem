//
//  SectionsVC.swift
//  FMS
//
//  Created by tami on 3/30/21.
//

import UIKit
import MBProgressHUD



class SectionsVC: UIViewController {
    let constants = Constants()
    
    var sections: [DirectionModel] = []
    let getAllSections = GetAllSections()
    
    @IBOutlet weak var addLabel: UILabel!
    
    
    @IBOutlet weak var sectionsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        sectionsTableView.delegate = self
        sectionsTableView.dataSource = self
        
        sectionsTableView.register(UINib(nibName: "SectionTVCell", bundle: nil), forCellReuseIdentifier: constants.sectionsPartTableViewCellIdentifier)
        
        
        
        let footerView = UIView()
        sectionsTableView.tableFooterView = footerView
        
        MBProgressHUD.showAdded(to: self.view, animated: true)
        fetchData()
        
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(pullToRefresh), for: .valueChanged)
        
        // this is the replacement of implementing: "collectionView.addSubview(refreshControl)"
        sectionsTableView.refreshControl = refreshControl
        
        
        design()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        MBProgressHUD.showAdded(to: self.view, animated: true)
        DispatchQueue.main.async {
            self.fetchData()
        }
    }

    
    @IBAction func addSectionButtonTapped(_ sender: UIButton) {
    }

}



extension SectionsVC{
    func fetchData(){
        
        getAllSections.getAllSections(url: constants.directionsEndPoint, completion: { (data) in
            DispatchQueue.main.async {
                self.sections.removeAll()
                self.sections = data
                self.sectionsTableView.reloadData()
                MBProgressHUD.hide(for: self.view, animated: true)
            }
        })
    }
    
    
    @objc func pullToRefresh(refreshControl: UIRefreshControl) {
        fetchData()

        // somewhere in your code you might need to call:
        refreshControl.endRefreshing()
    }
    
    
}


extension SectionsVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: constants.sectionsPartTableViewCellIdentifier, for: indexPath) as! SectionTVCell
        cell.frame.size.width = tableView.frame.size.width
        
        
//        cell.lastAndFirstNameLabel.text = counterAgents[indexPath.row].surname + " " + counterAgents[indexPath.row].name
        cell.sectionNameLabel.text = sections[indexPath.row].name
        
        //separator width = tableview.width
        cell.preservesSuperviewLayoutMargins = false
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let section = sections[indexPath.row]
        let editingSection = storyboard?.instantiateViewController(withIdentifier: constants.sectionPartEditingVC) as! EditingSectionVC
        editingSection.id = section.id
        present(editingSection, animated: true, completion: nil)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}


extension SectionsVC{
    func design (){
        
        addLabel.font = constants.fontSemiBold16
       
        
        
    }
}
