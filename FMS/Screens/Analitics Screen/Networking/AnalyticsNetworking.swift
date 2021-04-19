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
    var contractor: AContractorModel?
    
//    var projects: [DataEntry] = []
    var projects: [PieChartDataEntry] = []
    var filteredProjects: [PieChartDataEntry] = []
    var contractors: [AContractorModel] = []
    
    
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
//                print("Pie Chart: \(json)")
                
                self.projects.removeAll()
                
                for i in 0 ..< json.count{
//                    print("Value: \(json[i]["sum"].doubleValue) and Label: \(json[i]["name"].stringValue)")
                    if json[i]["sum"].doubleValue != 0 {
                        let project: PieChartDataEntry = PieChartDataEntry(value: json[i]["sum"].doubleValue, label: json[i]["name"].stringValue)
    //                    let project: PieChartDataEntry = PieChartDataEntry(value: Double(i + 2), label: "Let \(i)")
                        self.projects.append(project)
                    }
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
//                print("Filtered Pie Chart: \(json)")
                self.filteredProjects.removeAll()
                for i in 0 ..< json.count{
//                    print("Value: \(json[i]["sum"].doubleValue) and Label: \(json[i]["name"].stringValue)")
                    if json[i]["sum"].doubleValue != 0 {
                        let project: PieChartDataEntry = PieChartDataEntry(value: json[i]["sum"].doubleValue, label: json[i]["name"].stringValue)
                        //                    let project: PieChartDataEntry = PieChartDataEntry(value: Double(i + 10), label: "Let \(i)")
                        self.filteredProjects.append(project)
                    }
                }
                
                completion(self.filteredProjects)
                
            default:
                return print("Fail")
            }
            
        }
    }
    
    
    
    func getContractors(type: Int, dateFrom: String, dateTo: String, completion: @escaping ([AContractorModel]) -> ()){
        var url = ""
        if type == 1 {
            url = constants.analyticsContractorEndPoint + "?type=Доход&start_date=\(dateFrom)&end_date=\(dateTo)".encodeUrl
        } else if type == 2 {
            url = constants.analyticsContractorEndPoint + "?type=Расход&start_date=\(dateFrom)&end_date=\(dateTo)".encodeUrl
        }
        
        let requestAPI = AF.request(url, method: .get, encoding: JSONEncoding.default, interceptor: interceptor)
    
        requestAPI.responseJSON { (response) in
            
//            print(response.result)
            
            switch response.result{
            case .success(let data):
                let json = JSON(data)

//                print("Contractors : \(json)")
                
                self.contractors.removeAll()
                
                for i in 0 ..< json.count{   //json.count
                    
                    if json[i]["contractor__name"].stringValue != "" {
                        self.contractor = AContractorModel(contractorName: json[i]["contractor__name"].stringValue, sum: json[i]["sum"].doubleValue)
                    } else {
                        self.contractor = AContractorModel(contractorName: "Без Контрагента", sum: json[i]["sum"].doubleValue)
                    }
                    
                    
                    self.contractors.append(self.contractor!)
                }



                completion(self.contractors)
                
                
            default:
                return print("Get Contractors Fail!!!")
            }
            
        }
    }
    
    
    
    
}


extension String{
    var encodeUrl : String
    {
        return self.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!
    }
    var decodeUrl : String
    {
        return self.removingPercentEncoding!
    }
}
