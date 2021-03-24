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
    var transitions: [TransactionModel] = []
    
    var incomeOutcomeBalance: IncOutBalModel?
        
    
    func fetchingTransactions(url: String, completion: @escaping ([TransactionModel]) -> ()){

        
        let accessToken = userDefaults.string(forKey: "AccessToken")!
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(accessToken)"
        ]
        
        
        let requestAPI = AF.request(url, method: .get, encoding: JSONEncoding.default, headers: headers, interceptor: nil)
                   //responseJSON = responseString
        requestAPI.responseJSON { (response) in
            
            switch response.result{
                case .success(let data):
                    let json = JSON(data)
                    print(data)
                    self.transitions.removeAll()
                    for i in 0 ..< json["count"].intValue{

                        let transition: TransactionModel = TransactionModel(section: json["results"][i]["section"].stringValue, wallet: json["results"][i]["wallet"].stringValue, date_join: json["results"][i]["date_join"].stringValue, type: json["results"][i]["type"].stringValue, sum: json["results"][i]["sum"].intValue, id: json["results"][i]["id"].intValue)
                        self.transitions.append(transition)
                    }
                    completion(self.transitions)
                default:
                    return print("Fail")
            }
            
        }
    }
    
    
    func fetchingIncomeOutcomeBalance(url: String, completion: @escaping (IncOutBalModel) -> ()) {
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
                    self.incomeOutcomeBalance = IncOutBalModel(income: profit, outcome: wallets_sum, balance: consumption_sum)
                    
                    completion(self.incomeOutcomeBalance!)
                default:
                    return print("Fail")
            }
            
        }
    }
    
    
    
    
    func fetchingFilteredTransactions(url: String, completion: @escaping ([TransactionModel]) -> ()){

        let accessToken = userDefaults.string(forKey: "AccessToken")!
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(accessToken)"
        ]
        
        
        let requestAPI = AF.request(url, method: .get, encoding: JSONEncoding.default, headers: headers, interceptor: nil)
        
        requestAPI.responseJSON { (response) in
            switch response.result{
            case .success(let data):
                let json = JSON(data)
                
                
                self.transitions.removeAll()
                for i in 0 ..< json["count"].intValue{
                    let transition: TransactionModel = TransactionModel(section: json["results"][i]["section"].stringValue, wallet: json["results"][i]["wallet"].stringValue, date_join: json["results"][i]["date_join"].stringValue, type: json["results"][i]["type"].stringValue, sum: json["results"][i]["sum"].intValue, id: json["results"][i]["id"].intValue)
                    self.transitions.append(transition)
                    
                }
                
                completion(self.transitions)
            default:
                return print("Fail")
            }
            
        }
    }
}
