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
    
    var urlForNext: String?
    
    
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
//                    print("History Json: \(json)")
                    
                    self.urlForNext = json["next"].stringValue
//                    print("url    \(json["next"].stringValue)")
                    
                    self.history.removeAll()
                    for i in 0 ..< json["results"].count {
                        let who = json["results"][i]["user"]["last_name"].stringValue + " " + json["results"][i]["user"]["first_name"].stringValue
                        let whatDid: String = self.action(action_flag: json["results"][i]["action_flag"].intValue) + self.section(action_flag: json["results"][i]["action_flag"].intValue, section: json["results"][i]["content_type"]["model"].stringValue)
                        
                        let whenDid = self.constants.stringToDateHistory(dateString: json["results"][i]["action_time"].stringValue)
                        
                        
                        let historyCell = HistoryModel(who: who, whatDid: whatDid, date: whenDid) //
                        
                        
                        self.history.append(historyCell)
                        
                    }
                    completion(self.history)
            
                    
                default:
                    return print("Fail")
            }
            
        }
    }
    
    
    func fetchingMoreActions(completion: @escaping ([HistoryModel]) -> ()){
        
        
        
        
        
        let requestAPI = AF.request(urlForNext ?? "", method: .get, encoding: JSONEncoding.default, interceptor: interceptor)
        
        
        requestAPI
            .validate()
            .responseJSON { (response) in
            
            
            switch response.result{
                case .success(let data):
                    let json = JSON(data)
//                    print("History Json: \(json)")
//                    print(json["next"].stringValue)
                    self.history.removeAll()
                    if self.urlForNext != json["next"].stringValue {
                        self.urlForNext = json["next"].stringValue
                        for i in 0 ..< json["results"].count {
                            let who = json["results"][i]["user"]["last_name"].stringValue + " " + json["results"][i]["user"]["first_name"].stringValue
                            let whatDid: String = self.action(action_flag: json["results"][i]["action_flag"].intValue) + self.section(action_flag: json["results"][i]["action_flag"].intValue, section: json["results"][i]["content_type"]["model"].stringValue)
                            
                            let whenDid = self.constants.stringToDateHistory(dateString: json["results"][i]["action_time"].stringValue)
                            
                            
                            let historyCell = HistoryModel(who: who, whatDid: whatDid, date: whenDid )
                            
                            
                            self.history.append(historyCell)
                            
                        }
                        completion(self.history)
                    }
                    
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
            return "удалил(а) "
        default:
            return "Yaiks"
        }
    }
    
    
    func section(action_flag: Int, section: String) -> String {
        switch section {
        case "section":
            if action_flag == 2 {
                return "направление"
            } else {
                return "направление"
            }
            
        case "category":
            if action_flag == 2 {
                return "категория"
            } else {
                return "категорию"
            }
            
        case "transaction":
            if action_flag == 2 {
                return "транзакция"
            } else {
                return "транзакцию"
            }
            
        case "wallet":
            if action_flag == 2 {
                return "кошелек"
            } else {
                return "кошелек"
            }
            
        case "project":
            if action_flag == 2 {
                return "проект"
            } else {
                return "проект"
            }
            
        case "contractor":
            if action_flag == 2 {
                return "контрагент"
            } else {
                return "контрагента"
            }
            
        default:
            return "Yaiks"
        }
    }
}
