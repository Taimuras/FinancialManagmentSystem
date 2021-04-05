//
//  GetAndUpdateUser.swift
//  FMS
//
//  Created by tami on 3/23/21.
//

import Foundation
import Alamofire
import SwiftyJSON


class GetAndUpdateUser {
    let userDefaults = UserDefaults.standard
    var userAuth: Int = 0
    let constants = Constants()
    
    func getUserByID(email: String, completion: @escaping (SingleUser) -> ()){
        
        let accessToken = userDefaults.string(forKey: "AccessToken")!
        
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(accessToken)"
        ]
        
        
        let url = constants.crudUserByEmail + email
        let requestAPI = AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers, interceptor: nil)
        
        
        requestAPI.responseJSON { (response) in
//            let statusCode = response.response?.statusCode
//            print(statusCode!)
//            print(response.response!)
//            print(response.result)

            switch response.result{
            case .success(let data):
                let json = JSON(data)
                let user: SingleUser = SingleUser(email: json["email"].stringValue, first_name: json["first_name"].stringValue, last_name: json["last_name"].stringValue)
                completion(user)
            default:
                print("default")
                
            }
        }
    }
    
    func deleteUserByEmail(email: String, completion: @escaping (Int) -> ()){
        var success = 0
        let accessToken = userDefaults.string(forKey: "AccessToken")!
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(accessToken)"
        ]
        
        let url = constants.crudUserByEmail + email
        let requestAPI = AF.request(url, method: .delete, parameters: nil, encoding: JSONEncoding.default, headers: headers, interceptor: nil)
        //responseJSON = responseString
        requestAPI.responseJSON { (response) in
            switch response.result{
            case .success( _):
                success = 1
                completion(success)
                success = 0
            default:
                completion(success)
            }
            
        }
        
    }
    
    
    
    func updateUser(email: String, first_name: String, last_name: String, password: String, completion: @escaping (Int) -> ()){
        
        var param = [
            "email" : email as String,
        ] as [String : Any]
        
        if first_name != "" {
            param["first_name"] = first_name
        }
        if last_name != "" {
            param["last_name"] = last_name
        }
        if password != "" {
            param["password"] = password
        }
        
        
        let accessToken = userDefaults.string(forKey: "AccessToken")!
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(accessToken)"
        ]
        
        
        let url = constants.crudUserByEmail + email
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
