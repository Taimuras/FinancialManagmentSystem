//
//  FetchingTransactions.swift
//  FMS
//
//  Created by tami on 3/8/21.
//

import Foundation
import Alamofire
import SwiftyJSON


class FetchingTransactions {
    let constants = Constants()
    let userDefaults = UserDefaults.standard
    var transitions: [TransitionsModel] = []
    var incomeOutcomeBalance: [String] = []
        
    
    func fetchingTransactions(url: String, completion: @escaping ([TransitionsModel]) -> ()){

        
        let accessToken = userDefaults.string(forKey: "AccessToken")!
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(accessToken)"
        ]
        
        
        let requestAPI = AF.request(url, method: .get, encoding: JSONEncoding.default, headers: headers, interceptor: nil)
        
        requestAPI.responseJSON { (response) in
            let json = JSON(response.value!)
//            print(response.result)
//            print(json["count"])
            
            
            for i in 0 ... json["count"].intValue{
                let transition: TransitionsModel = TransitionsModel(id: Int(json["results"][i]["id"].intValue), sum: Int(json["results"][i]["sum"].intValue), date_join: String(json["results"][i]["date_join"].stringValue), user: String(json["results"][i]["id"].stringValue), actionIconName: "Income")
                self.transitions.append(transition)
            }
            completion(self.transitions)
            
            
        }
    }
    
    
    func fetchingIncomeOutcomeBalance(url: String, completion: @escaping ([String]) -> ()) {
        let accessToken = userDefaults.string(forKey: "AccessToken")!
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(accessToken)"
        ]
        
        
        let requestAPI = AF.request(url, method: .get, encoding: JSONEncoding.default, headers: headers, interceptor: nil)
        
        requestAPI.responseJSON { (response) in
            
//            print(response.result)
            switch response.result{
                case .success(let data):
//                    print(data)
                    let json = JSON(data)
                    let profit = json["profit_sum"].stringValue
                    let wallets_sum = json["wallets_sum"].stringValue
                    let consumption_sum = json["consumption_sum"].stringValue
                    self.incomeOutcomeBalance.append(profit)
                    self.incomeOutcomeBalance.append(consumption_sum)
                    self.incomeOutcomeBalance.append(wallets_sum)
                    completion(self.incomeOutcomeBalance)
                default:
                    return print("Fail")
            }
            
        }
    }
    
    
    
    
    func fetchingFilteredTransactions(url: String, params: FilterModel, completion: @escaping ([TransitionsModel]) -> ()){

        
        let params = [
            "dateFrom" : params.dateFrom as AnyObject,
            "dateTo" : params.dateTo as AnyObject,
            "wallet" : params.wallet as AnyObject,
            "counterAgent" : params.counterAgent as AnyObject,
            "direction" : params.direction as AnyObject
        ]
        
        let accessToken = userDefaults.string(forKey: "AccessToken")!
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(accessToken)"
        ]
        
        
        let requestAPI = AF.request(url, method: .get,parameters: params, encoding: JSONEncoding.default, headers: headers, interceptor: nil)
        
        requestAPI.responseJSON { (response) in
            let json = JSON(response.value!)
//            print(response.result)
//            print(json["count"])
            
            
            for i in 0 ... json["count"].intValue{
                let transition: TransitionsModel = TransitionsModel(id: Int(json["results"][i]["id"].intValue), sum: Int(json["results"][i]["sum"].intValue), date_join: String(json["results"][i]["date_join"].stringValue), user: String(json["results"][i]["id"].stringValue), actionIconName: "Income")
                self.transitions.append(transition)
            }
            completion(self.transitions)
            
            
        }
    }
}