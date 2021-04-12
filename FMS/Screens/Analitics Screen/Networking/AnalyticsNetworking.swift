//
//  NetworkGetAllUsers.swift
//  FMS
//
//  Created by tami on 3/19/21.
//

import Foundation
import Alamofire
import SwiftyJSON
import AnyChartiOS
import Charts



class AnalyticsNetworking{
    let userDefaults = UserDefaults.standard
    let interceptor = JWTAccessTokenAdapter()
    let constants = Constants()
    var dateFrom: String?
    var dateTo: String?
    
//    var projects: [DataEntry] = []
    var projects: [PieChartDataEntry] = []
    var filteredProjects: [PieChartDataEntry] = []
    
    
    func getDefaultProjects(completion: @escaping ([PieChartDataEntry]) -> ()){
        
        let currentDate = Date()
        let dateMonthAgo = Calendar.current.date(byAdding: .month, value: -1, to: currentDate)
        
        dateFrom = constants.filteredDateToServer(date: dateMonthAgo!)
        dateTo = constants.filteredDateToServer(date: currentDate)

        let url = constants.analyticsProjectsEndPoint + "?type=1&start_date=\(dateFrom!)&end_date=\(dateTo!)"
//        print(url)
        let requestAPI = AF.request(url, method: .get, encoding: JSONEncoding.default, interceptor: interceptor)
    
        requestAPI.responseJSON { (response) in
            switch response.result{
            case .success(let data):
                let json = JSON(data)
//                print("json count \(json["count"])")
//                print("Analytics : \(json)")
                
                self.projects.removeAll()
                
                for (key, _) in json{
//                    print("key: \(key)   value: \(value)")
                    let project: PieChartDataEntry = PieChartDataEntry(value: json["\(key)"].doubleValue, label: key)
                        
                        
                    self.projects.append(project)
                    
                }
                
                
                completion(self.projects)
                
            default:
                return print("Fail")
            }
            
        }
    }
    
    
    func getFilteredProjects(type: Int, dateFrom: String, dateTo: String, completion: @escaping ([PieChartDataEntry]) -> ()){
        
        let url = constants.analyticsProjectsEndPoint + "?type=\(type)&start_date=\(dateFrom)&end_date=\(dateTo)"
        print("Filtered Url: \(url)")
        let requestAPI = AF.request(url, method: .get, encoding: JSONEncoding.default, interceptor: interceptor)
    
        requestAPI.responseJSON { (response) in
            switch response.result{
            case .success(let data):
                let json = JSON(data)

                self.filteredProjects.removeAll()
                for (key, _) in json{
                    let project: PieChartDataEntry = PieChartDataEntry(value: json["\(key)"].doubleValue, label: key)
                        
                        
                    self.filteredProjects.append(project)
                    
                }
                
                
                completion(self.filteredProjects)
                
            default:
                return print("Fail")
            }
            
        }
    }
}
