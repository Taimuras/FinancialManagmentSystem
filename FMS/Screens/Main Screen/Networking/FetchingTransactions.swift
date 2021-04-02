//
//  FetchingTransactions.swift
//  FMS
//
//  Created by tami on 3/8/21.
//

import Foundation
import Alamofire
import SwiftyJSON




//let headers: HTTPHeaders = [
//    "Authorization": "Bearer \(accessToken)"
//]

class FetchingTransactions {
    
    
    var date: String?
    
    
    let constants = Constants()
    let userDefaults = UserDefaults.standard
    var transitions: [TransactionModel] = []
    
    var incomeOutcomeBalance: IncOutBalModel?
    let interceptor = JWTAccessTokenAdapter()
        
    
    func fetchingTransactions(url: String, completion: @escaping ([TransactionModel]) -> ()){

        
        let requestAPI = AF.request(url, method: .get, encoding: JSONEncoding.default, interceptor: interceptor)
        
        
        requestAPI
            .validate()
            .responseJSON { (response) in
            
            
            switch response.result{
                case .success(let data):
                    let json = JSON(data)

                    
                    
                    self.transitions.removeAll()
                    for i in 0 ..< json["count"].intValue{
                        
                        let transition: TransactionModel = TransactionModel(section: json["results"][i]["section"].stringValue, wallet: json["results"][i]["wallet"].stringValue, date_join: json["results"][i]["date_join"].stringValue, type: json["results"][i]["type"].stringValue, sum: json["results"][i]["sum"].intValue, id: json["results"][i]["id"].intValue, wallet_to: json["results"][i]["wallet_to"].stringValue)
                        self.transitions.append(transition)
                    }
                    completion(self.transitions)
                    
                default:
                    return print("Fail")
            }
            
        }
    }
    
    
    func fetchingIncomeOutcomeBalance(url: String, completion: @escaping (IncOutBalModel) -> ()) {
        
        
        let requestAPI = AF.request(url, method: .get, encoding: JSONEncoding.default, interceptor: interceptor)
        
        requestAPI
            .validate()
            .responseJSON { (response) in
            
//            print(response.result)
            switch response.result{
                case .success(let data):
//                    print("INc Out: \(data)")
                    let json = JSON(data)
                    
                    let profit = json["profit_sum"]["sum__sum"].stringValue
                    let wallets_sum = json["wallets_sum"]["balance__sum"].stringValue
                    let consumption_sum = json["consumption_sum"]["sum__sum"].stringValue
                    self.incomeOutcomeBalance = IncOutBalModel(income: profit, outcome: wallets_sum, balance: consumption_sum)
                    
                    completion(self.incomeOutcomeBalance!)
                default:
                    return print("Fail")
            }
            
        }
    }
    
    
    
    
    func fetchingFilteredTransactions(url: String, dateFrom: String, dateTo: String, completion: @escaping ([TransactionModel]) -> ()){

        
        
        let requestAPI = AF.request(url, method: .get, encoding: JSONEncoding.default, interceptor: interceptor)
        
        requestAPI
            .validate()
            .responseJSON { (response) in
            
            switch response.result{
            case .success(let data):
                let json = JSON(data)
                
                
                
                self.transitions.removeAll()
                for i in 0 ..< json["count"].intValue{
                    let transition: TransactionModel = TransactionModel(section: json["results"][i]["section"].stringValue, wallet: json["results"][i]["wallet"].stringValue, date_join: json["results"][i]["date_join"].stringValue, type: json["results"][i]["type"].stringValue, sum: json["results"][i]["sum"].intValue, id: json["results"][i]["id"].intValue, wallet_to: json["results"][i]["wallet_to"].stringValue)
                    self.transitions.append(transition)
                    
                }
                
                completion(self.transitions)
            default:
                return print("Fail")
            }
            
        }
    }
    
    
}
