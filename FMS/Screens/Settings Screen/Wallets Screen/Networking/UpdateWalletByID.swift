//
//  UpdateCounterPartByID.swift
//  FMS
//
//  Created by tami on 3/26/21.
//

import Foundation
import Alamofire


class UpdateWalletByID{
    
    
    let userDefaults = UserDefaults.standard
    var userAuth: Int = 0
    let constants = Constants()
    
    
    
    func updateWallet(id: Int, name: String, balance: Int, completion: @escaping (Int) -> ()){
        
        let param = [
            "name" : name as String,
            "balance" : balance as Int
        ] as [String : Any]
        
        
        let accessToken = userDefaults.string(forKey: "AccessToken")!
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(accessToken)"
        ]
        
        
        
        let url = constants.walletEndPoint + String(id)
        
        let requestAPI = AF.request(url, method: .patch, parameters: param, encoding: JSONEncoding.default, headers: headers, interceptor: nil)
        
        
        requestAPI.responseJSON { (response) in
            
            let statusCode = response.response?.statusCode
//            print(response.description)
//            print(response.response!)
//            print(response.response?.statusCode)
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
