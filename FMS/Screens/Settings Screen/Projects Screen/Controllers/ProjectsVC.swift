//
//  ProjectsVC.swift
//  FMS
//
//  Created by tami on 3/26/21.
//

import UIKit

class ProjectsVC: UIViewController {

    let constants = Constants()
    
    var projects: [ProjectModel] = []
    
    let getAllProjects = GetAllProjects()
    
    @IBOutlet weak var addLabel: UILabel!
    
    
    @IBOutlet weak var projectTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        projectTableView.register(UINib(nibName: "ProjectTVCell", bundle: nil), forCellReuseIdentifier: constants.projectPartTableViewCellIdentifier)

        
        getAll()
        
        
        projectTableView.delegate = self
        projectTableView.dataSource = self
        
        let footerView = UIView()
        projectTableView.tableFooterView = footerView
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(pullToRefresh), for: .valueChanged)
        
        // this is the replacement of implementing: "collectionView.addSubview(refreshControl)"
        projectTableView.refreshControl = refreshControl
        
        design()
        self.hideKeyboardWhenTappedAround()
    }
    
    @IBAction func addProjectButtonTapped(_ sender: UIButton) {
    }
    
    
    @objc func pullToRefresh(refreshControl: UIRefreshControl) {
        getAll()

        // somewhere in your code you might need to call:
        refreshControl.endRefreshing()
    }
    
    
    func getAll() {
        getAllProjects.getAllProjects(url: constants.projectEndPoint) { (data) in
            DispatchQueue.main.async {
                self.projects.removeAll()
                self.projects = data
                self.projectTableView.reloadData()
            }
        }
    }
}



extension ProjectsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return projects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: constants.projectPartTableViewCellIdentifier, for: indexPath) as! ProjectTVCell
        cell.frame.size.width = tableView.frame.size.width
        
        
        cell.projectName.text = projects[indexPath.row].name
        
        
        //separator width = tableview.width
        cell.preservesSuperviewLayoutMargins = false
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
        
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let counterPart = projects[indexPath.row]
        let edititngProject = storyboard?.instantiateViewController(withIdentifier: constants.projectPartEditingVC) as! EditingProjectsVC
        edititngProject.id = counterPart.id

        present(edititngProject, animated: true, completion: nil)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    
}


extension ProjectsVC{
    func design (){
        
        addLabel.font = constants.fontSemiBold16
       
    }
}
