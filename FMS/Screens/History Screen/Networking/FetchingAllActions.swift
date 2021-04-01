//
//  FetchingTransactions.swift
//  FMS
//
//  Created by tami on 3/8/21.
//

import Foundation
import Alamofire
import SwiftyJSON


class FetchingAllActions {
    
    
    var date: String?
    
    
    let constants = Constants()
    let userDefaults = UserDefaults.standard
    var transitions: [TransactionModel] = []
    
    var incomeOutcomeBalance: IncOutBalModel?
    let interceptor = JWTAccessTokenAdapter()
        
    
    func fetchingActions(completion: @escaping ([HistoryModel]) -> ()){
        
        let url = constants.historyEndPoint
        
        let requestAPI = AF.request(url, method: .get, encoding: JSONEncoding.default, interceptor: interceptor)
        
        
        requestAPI
            .validate()
            .responseJSON { (response) in
            
            
            switch response.result{
                case .success(let data):
                    let json = JSON(data)
                    print("History Json: \(json)")
                    
                    
//                    self.transitions.removeAll()
//                    for i in 0 ..< json["count"].intValue{
//
//                        let transition: TransactionModel = TransactionModel(section: json["results"][i]["section"].stringValue, wallet: json["results"][i]["wallet"].stringValue, date_join: json["results"][i]["date_join"].stringValue, type: json["results"][i]["type"].stringValue, sum: json["results"][i]["sum"].intValue, id: json["results"][i]["id"].intValue, wallet_to: json["results"][i]["wallet_to"].stringValue)
//                        self.transitions.append(transition)
//                    }
//                    completion(self.transitions)
                    
                default:
                    return print("Fail")
            }
            
        }
    }
    
    
    func fetchingMoreActions(completion: @escaping ([HistoryModel]) -> ()){
        
        let url = constants.historyEndPoint + "next"
        
        let requestAPI = AF.request(url, method: .get, encoding: JSONEncoding.default, interceptor: interceptor)
        
        
        requestAPI
            .validate()
            .responseJSON { (response) in
            
            
            switch response.result{
                case .success(let data):
                    let json = JSON(data)
                    print("History Json: \(json)")
                    
                    

//                    for i in 0 ..< json["count"].intValue{
//
//                        let transition: TransactionModel = TransactionModel(section: json["results"][i]["section"].stringValue, wallet: json["results"][i]["wallet"].stringValue, date_join: json["results"][i]["date_join"].stringValue, type: json["results"][i]["type"].stringValue, sum: json["results"][i]["sum"].intValue, id: json["results"][i]["id"].intValue, wallet_to: json["results"][i]["wallet_to"].stringValue)
//                        self.transitions.append(transition)
//                    }
//                    completion(self.transitions)
                    
                default:
                    return print("Fail")
            }
            
        }
    }
}
