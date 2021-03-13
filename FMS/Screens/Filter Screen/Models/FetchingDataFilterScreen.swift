//
//  FetchingDataFilterScreen.swift
//  FMS
//
//  Created by tami on 3/13/21.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON


class FetchingDataFilterScreen{
    let userDefaults = UserDefaults.standard
    
    var wallets: [WalletModel] = []
    var counterAgents: [CounterAgentsModel] = []
    
    func fetchingWallets(url: String, completion: @escaping ([WalletModel]) -> ()) {
        let accessToken = userDefaults.string(forKey: "AccessToken")!
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(accessToken)"
        ]
        let requestAPI = AF.request(url, method: .get, encoding: JSONEncoding.default, headers: headers, interceptor: nil)
        
        requestAPI.responseJSON { (response) in
            
            switch response.result{
            case .success(let data):
                //                    print(data)
                let json = JSON(data)
                //                    let profit = json["profit_sum"].stringValue
                for i in 0 ... json["results"].count{
                    let balance = json["results"][i]["balance"].intValue
                    let id = json["results"][i]["id"].intValue
                    let name = json["results"][i]["name"].stringValue
                    let wallet = WalletModel(balance: balance, id: id, name: name)
                    self.wallets.append(wallet)
                    completion(self.wallets)
                }
            default:
                return print("Fail")
            }
            
        }
    }
    
    
    func fetchingCounterAgents(url: String, completion: @escaping ([CounterAgentsModel]) -> ()) {
        let accessToken = userDefaults.string(forKey: "AccessToken")!
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(accessToken)"
        ]
        let requestAPI = AF.request(url, method: .get, encoding: JSONEncoding.default, headers: headers, interceptor: nil)
        
        requestAPI.responseJSON { (response) in
            
            switch response.result{
            case .success(let data):
                
//                print(data)
                
                let json = JSON(data)
                
                for i in 0 ... json["results"].count{
                    let name = json["results"][i]["name"].stringValue
                    let id = json["results"][i]["id"].intValue
                    let surname = json["results"][i]["surname"].stringValue
                    let patr = json["results"][i]["patronymic"].stringValue
                    let photo = json["results"][i]["photo"].stringValue
                    let counterAgent = CounterAgentsModel(id: id, name: name, surname: surname, patronymic: patr, photo: photo)
                    self.counterAgents.append(counterAgent)
                    completion(self.counterAgents)
                }
            default:
                return print("Fail")
            }
            
        }
    }
}
