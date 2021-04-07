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
    var limit = 20
    var offset = 20
    
    
    let constants = Constants()
    let userDefaults = UserDefaults.standard
    var history: [HistoryModel] = []
    
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
                
                    self.history.removeAll()
                    for i in 0 ..< json["results"].count {
                        let who = json["results"][i]["user"]["last_name"].stringValue + " " + json["results"][i]["user"]["first_name"].stringValue
                        let whatDid: String = self.action(action_flag: json["results"][i]["action_flag"].intValue) + self.section(section: json["results"][i]["content_type"]["model"].stringValue)
                        
//                        let whenDid = self.constants.stringToDateHistory(dateString: json["results"][i]["action_time"].stringValue)
                        
                        
                        let historyCell = HistoryModel(who: who, whatDid: whatDid) //
                        
                        
                        self.history.append(historyCell)
                        
                    }
                    completion(self.history)
            
                    
                default:
                    return print("Fail")
            }
            
        }
    }
    
    
    func fetchingMoreActions(completion: @escaping ([HistoryModel]) -> ()){
        
        
        
        let url = constants.historyEndPoint + "?limit=\(limit)&offset=\(offset)"
        
        let requestAPI = AF.request(url, method: .get, encoding: JSONEncoding.default, interceptor: interceptor)
        
        
        requestAPI
            .validate()
            .responseJSON { (response) in
            
            
            switch response.result{
                case .success(let data):
                    let json = JSON(data)
                    
                    
                    for i in 0 ..< json["results"].count {
                        let who = json["results"][i]["user"]["last_name"].stringValue + " " + json["results"][i]["user"]["first_name"].stringValue
                        let whatDid: String = self.action(action_flag: json["results"][i]["action_flag"].intValue) + self.section(section: json["results"][i]["content_type"]["model"].stringValue)
                        
                        let whenDid = self.constants.stringToDateHistory(dateString: json["results"][i]["action_time"].stringValue)
                        
                        
                        let historyCell = HistoryModel(who: who, whatDid: whatDid) //, date: whenDid
                        
                        
                        self.history.append(historyCell)
                        
                    }
                    completion(self.history)
                    self.limit += 20
                    self.offset += 20
                default:
                    return print("Fail")
            }
            
        }
    }
    
    func action (action_flag: Int) -> String {
        
        switch action_flag {
        case 1:
            return "создал(а) "
        case 2:
            return "сделал(а) изменение в разделе "
        case 3:
            return "сделал(а) изменение в разделе "
        default:
            return "Yaiks"
        }
    }
    
    
    func section(section: String) -> String {
        switch section {
        case "section":
            return "направление"
        case "category":
            return "категория"
        case "transaction":
            return "транзакция"
        case "wallet":
            return "кошелек"
        case "projcet":
            return "проект"
        case "contractor":
            return "контрагент"
        default:
            return "Yaiks"
        }
    }
}
