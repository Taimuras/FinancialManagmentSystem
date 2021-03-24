//
//  FetchingTransactionsModels.swift
//  FMS
//
//  Created by tami on 3/22/21.
//

import Foundation
import Alamofire
import SwiftyJSON


class FetchingAndDeletingTransactions{
    
    let userDefaults = UserDefaults.standard
    func fetchingTransactions(url: String, completion: @escaping (TransactionByID) -> ()){
        let accessToken = userDefaults.string(forKey: "AccessToken")!
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(accessToken)"
        ]
        
        
        
        let requestAPI = AF.request(url, method: .get, encoding: JSONEncoding.default,  headers: headers, interceptor: nil)
        requestAPI.responseJSON { (response) in
            
            switch response.result{
                case .success(let data):
                    let json = JSON(data)
                    print("Transaction : \(data)")
//                    json["results"]["date_join"].stringValue      ------------- date  ection: json["section"].stringValue
                    let transaction: TransactionByID = TransactionByID(category: json["category"].intValue, comment: json["comment"].stringValue, contractor: json["contractor"].intValue, id: json["id"].intValue, project: json["project"].intValue, section: json["section"].intValue, sum: json["sum"].intValue, wallet: json["wallet"].intValue)

                    completion(transaction)
                default:
                    return print("Fail")
            }
            
        }
    }
    
    
    
    func fetchingTransfer(url: String, completion: @escaping (TransferByID) -> ()){
        let accessToken = userDefaults.string(forKey: "AccessToken")!
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(accessToken)"
        ]
        
        
        
        let requestAPI = AF.request(url, method: .get, encoding: JSONEncoding.default,  headers: headers, interceptor: nil)
        requestAPI.responseJSON { (response) in
            
            switch response.result{
                case .success(let data):
                    let json = JSON(data)
//                    print(data)
//                    json["results"]["date_join"].stringValue      ------------- date  ection: json["section"].stringValue
                    let transaction: TransferByID = TransferByID(comment: json["comment"].stringValue, id: json["id"].intValue, sum: json["sum"].intValue, wallet: json["wallet"].intValue, wallet_to: json["wallet_to"].intValue)
                    print(transaction)
                    completion(transaction)
                default:
                    return print("Fail")
            }
            
        }
    }
    
    
    func deletingTransaction(url: String, id: Int, completion: @escaping (Bool) -> ()){
        let accessToken = userDefaults.string(forKey: "AccessToken")!
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(accessToken)"
        ]
        let param = [
            "id" : id as Int
        ]
        
        let requestAPI = AF.request(url, method: .delete, parameters: param, encoding: JSONEncoding.default, headers: headers, interceptor: nil)
                   //responseJSON = responseString
        requestAPI.responseJSON { (response) in
            switch response.result{
            case .success( _):
                    completion(true)
                default:
                    return print("Fail")
            }
            
        }
    }
}

