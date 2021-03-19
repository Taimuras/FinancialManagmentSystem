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
    
    
    func createIncomeTransaction(url: String, type: Int, section: Int, category: Int, project: Int, sum: Int, wallet: Int, contractor: Int, comment: String, completion: @escaping (Int) -> ()){

        let param = [
            "type" : type as Int,
            "category" : category as Int,
            "project" : project as Int,
            "sum" : sum as Int,
            "wallet" : wallet as Int,
            "contractor" : contractor as Int,
            "comment" : comment as String
        ] as [String : Any]
        
        
        let accessToken = userDefaults.string(forKey: "AccessToken")!
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(accessToken)"
        ]
        
        
        
        
        let requestAPI = AF.request(constants.createTransactionEndPotin, method: .post, parameters: param, encoding: JSONEncoding.default, headers: headers, interceptor: nil)
        
        
        requestAPI.responseJSON { (response) in
            let statusCode = response.response?.statusCode
            print(response.response?.statusCode)
            print(response.description)

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
    
    
    func createOutComeTransaction(url: String, type: Int, section: Int, category: Int, project: Int, sum: Int, wallet: Int, contractor: Int, comment: String, completion: @escaping (Int) -> ()){

        let param = [
            "type" : type as Int,
            "category" : category as Int,
            "project" : project as Int,
            "sum" : sum as Int,
            "wallet" : wallet as Int,
            "contractor" : contractor as Int,
            "comment" : comment as String
        ] as [String : Any]
        
        
        let accessToken = userDefaults.string(forKey: "AccessToken")!
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(accessToken)"
        ]
        
        
        
        
        let requestAPI = AF.request(constants.createTransactionEndPotin, method: .post, parameters: param, encoding: JSONEncoding.default, headers: headers, interceptor: nil)
        
        
        requestAPI.responseJSON { (response) in
            let statusCode = response.response?.statusCode
            print(response.response?.statusCode)
            print(response.description)

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
    
    func createTransferTransaction(url: String, type: Int,  sum: Int, wallet: Int, wallet_to: Int, comment: String, completion: @escaping (Int) -> ()){

        let param = [
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
        
        
        
        
        let requestAPI = AF.request(constants.createTransactionEndPotin, method: .post, parameters: param, encoding: JSONEncoding.default, headers: headers, interceptor: nil)
        
        
        requestAPI.responseJSON { (response) in
            let statusCode = response.response?.statusCode
            print(response.response?.statusCode)
            print(response.description)

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
