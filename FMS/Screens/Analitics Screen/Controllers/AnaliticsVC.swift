//
//  AnaliticsVC.swift
//  FMS
//
//  Created by tami on 3/8/21.
//

import UIKit
import AnyChartiOS
import Charts



class AnaliticsVC: UIViewController, ChartViewDelegate{
    let constants = Constants()
    let getAnalytics = AnalyticsNetworking()
    let userDefaults = UserDefaults.standard
    
    
    var dataEntry: [DataEntry]?
    
    
    @IBOutlet weak var analyticsLabel: UILabel!
    @IBOutlet weak var filtrationLabel: UILabel!
    
    
    @IBOutlet weak var horizontalChartView: HorizontalBarChartView!
    @IBOutlet weak var anyChartView: PieChartView!
    var entries = [PieChartDataEntry]()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        horizontalChartView.alpha = 0
        anyChartView.alpha = 1
        
        anyChartView.delegate = self
        
        design()
        
        
        get()
        
        
        // Do any additional setup after loading the view.
    }
    

    @IBAction func analFiltrButtonTapped(_ sender: UIButton) {
        let analyticsFilterVC = storyboard?.instantiateViewController(withIdentifier: "AnalyticsFiltrationVC") as! AnalyticsFiltrationVC
        analyticsFilterVC.delegate = self
        present(analyticsFilterVC, animated: true, completion: nil)
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
    
    
    
    func get() {
        getAnalytics.getDefaultProjects { (data) in
            
            DispatchQueue.main.async {
                
                self.createPieChart(data: data)

            }
            
        }
        
    }
    
    func createPieChart(data: [PieChartDataEntry]) {
        self.anyChartView.entryLabelColor = .black
        self.anyChartView.animate(yAxisDuration: 1.5, easingOption: ChartEasingOption.easeInOutQuad)
        
        let set = PieChartDataSet(entries: data, label: "Проекты")
        
        set.useValueColorForLine = true
        set.valueLineColor = .blue
        
        set.colors = ChartColorTemplates.material()
        let data = PieChartData(dataSet: set)
        self.anyChartView.data = data
    }
    
    
    func createBarChart(data: [BarChartDataEntry]) {
        let set = BarChartDataSet(entries: data, label: "Contractors")
        set.colors = ChartColorTemplates.colorful()
        let data = BarChartData(dataSet: set)
        horizontalChartView.data = data
    }
}



extension AnaliticsVC: AnalyticsFiltrationVCDelegate {
    
    func neededData(type: Int, section: String, dateFrom: String, dateTo: String) {
        if section == "Проекты" {
            horizontalChartView.alpha = 0
            anyChartView.alpha = 1
            getAnalytics.getFilteredProjects(type: type, dateFrom: dateFrom, dateTo: dateTo) { (data) in
                
                DispatchQueue.main.async {
                    self.createPieChart(data: data)
                }
            }
        } else {
            horizontalChartView.alpha = 1
            anyChartView.alpha = 0
            
            
            getAnalytics.getContractors { (data) in
                DispatchQueue.main.async {
                    print(data)
                    self.createBarChart(data: data)
                }
            }
        }
        self.dismiss(animated: true,completion: nil) 
    }
}








extension AnaliticsVC{
    func design (){
        
        
        //Fonts + sizes
        analyticsLabel.font = constants.fontBold34
        filtrationLabel.font = constants.fontSemiBold16
        
        
        
       
    }
}
