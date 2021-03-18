//
//  NetworkCreateUser.swift
//  FMS
//
//  Created by tami on 3/18/21.
//

import Foundation
import Alamofire


class NetworkCreateUser{
    let userDefaults = UserDefaults.standard
    var userAuth: Int = 0
    let constants = Constants()
    func createUser(email: String, first_name: String, last_name: String, password: String, completion: @escaping (Int) -> ()){
        let param = [
            "email" : email as String,
            "first_name" : first_name as String,
            "last_name" : last_name as String,
            "password" : password as String
        
        ]
        
        
        let accessToken = userDefaults.string(forKey: "AccessToken")!
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(accessToken)"
        ]
        
        
        
        
        let requestAPI = AF.request(constants.logInEndPoint, method: .post, parameters: param, encoding: JSONEncoding.default, headers: headers, interceptor: nil)
        
        
        requestAPI.responseJSON { (response) in
            let statusCode = response.response?.statusCode
            switch statusCode{
            case 200:
                self.userAuth = 1
                completion(self.userAuth)
                self.userAuth = 0
            default:
                completion(self.userAuth)
                
            }
        }
    }
}
