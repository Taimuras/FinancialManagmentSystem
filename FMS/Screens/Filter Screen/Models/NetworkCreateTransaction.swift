//
//  NetworkCreateTransaction.swift
//  FMS
//
//  Created by tami on 3/19/21.
//

import Foundation
import Alamofire


class NetworkCreateTransaction{
    let userDefaults = UserDefaults.standard
    var userAuth: Int = 0
    let constants = Constants()
    
//    date_Join:String,
    func createIncomeTransaction(date_join:String, type: Int, section: Int, category: Int, project: Int, sum: Int, wallet: Int, contractor: Int, comment: String, completion: @escaping (Int) -> ()){

        var param = [
            "date_join": date_join as Any,
            "section": section as Any,
            "type" : type as Int,
            "category" : category as Int,
            "sum" : sum as Int,
            "wallet" : wallet as Int,
            "comment" : comment as String
        ] as [String : Any]
        
        
        if project != 0 {
            param["project"] = project
        }
        
        if contractor != 0{
            param["contractor"] = contractor
        }
        
        let accessToken = userDefaults.string(forKey: "AccessToken")!
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(accessToken)"
        ]
        
        
        
        
        let requestAPI = AF.request(constants.transactionEndPoint, method: .post, parameters: param, encoding: JSONEncoding.default, headers: headers, interceptor: nil)
        
        
        requestAPI.responseJSON { (response) in
            let statusCode = response.response?.statusCode
//            print(response.response?.statusCode)
//            print(response.description)

            switch statusCode{
            case 200:
                self.userAuth = 1
                completion(self.userAuth)
                self.userAuth = 0
            case 201:
                self.userAuth = 1
                completion(self.userAuth)
                self.userAuth = 0
            default:
                completion(self.userAuth)
                
            }
        }
    }
    
    
    func createOutComeTransaction(date_join:String, type: Int, section: Int, category: Int, project: Int, sum: Int, wallet: Int, contractor: Int, comment: String, completion: @escaping (Int) -> ()){

        var param = [
            "date_join": date_join as Any,
            "section": section as Any,
            "type" : type as Int,
            "category" : category as Any,
            "sum" : sum as Int,
            "wallet" : wallet as Any,
            "comment" : comment as String
        ] as [String : Any]
        
        
        if project != 0 {
            param["project"] = project
        }
        
        if contractor != 0{
            param["contractor"] = contractor
        }
        
        
        let accessToken = userDefaults.string(forKey: "AccessToken")!
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(accessToken)"
        ]
        
        
        
        
        let requestAPI = AF.request(constants.transactionEndPoint, method: .post, parameters: param, encoding: JSONEncoding.default, headers: headers, interceptor: nil)
        
        
        requestAPI.responseJSON { (response) in
            let statusCode = response.response?.statusCode
            
//            print(response.description)

            switch statusCode{
            case 200:
                self.userAuth = 1
                completion(self.userAuth)
                self.userAuth = 0
            case 201:
                self.userAuth = 1
                completion(self.userAuth)
                self.userAuth = 0
            default:
                completion(self.userAuth)
                
            }
        }
    }
    
    func createTransferTransaction(date_join:String, type: Int,  sum: Int, wallet: Int, wallet_to: Int, comment: String, completion: @escaping (Int) -> ()){

        let param = [
            "date_join": date_join as Any,
            "type" : type as Int,
            "sum" : sum as Int,
            "wallet" : wallet as Int,
            "wallet_to" : wallet_to as Int,
            "comment" : comment as String
        ] as [String : Any]
        
        
        let accessToken = userDefaults.string(forKey: "AccessToken")!
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(accessToken)"
        ]
        
        
        
        
        let requestAPI = AF.request(constants.transactionEndPoint, method: .post, parameters: param, encoding: JSONEncoding.default, headers: headers, interceptor: nil)
        
        
        requestAPI.responseJSON { (response) in
            let statusCode = response.response?.statusCode
            
//            print(response.description)

            switch statusCode{
            case 200:
                self.userAuth = 1
                completion(self.userAuth)
                self.userAuth = 0
            case 201:
                self.userAuth = 1
                completion(self.userAuth)
                self.userAuth = 0
            default:
                completion(self.userAuth)
                
            }
        }
    }
}
