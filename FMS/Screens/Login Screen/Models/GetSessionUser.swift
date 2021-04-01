//
//  GetSessionUser.swift
//  FMS
//
//  Created by tami on 3/23/21.
//

import Foundation
import Alamofire
import SwiftyJSON



class GetSessionUser {
    
    let userDefaults = UserDefaults.standard
    var userAuth: Int = 7
    let constants = Constants()
    let interceptor = JWTAccessTokenAdapter()
    
    
    func getSessionUser(completion: @escaping (Int) -> ()){
        
       
        let requestAPI = AF.request(constants.getSessionUserEndPoint, method: .get, parameters: nil, encoding: JSONEncoding.default,  interceptor: interceptor)
        
        
        requestAPI.responseJSON { (response) in
            let statusCode = response.response?.statusCode
//            print(response.description)
//            print(response.result)
//            print(response.response?.statusCode)
//            print(response.response!)
//            print(response.result)

            let json = JSON(response.value!)
            switch statusCode{
            case 200:
                let is_admin = json["is_admin"].intValue
                self.userDefaults.removeObject(forKey: "Admin")
                self.userDefaults.setValue(is_admin, forKey: "Admin")
                if self.userDefaults.integer(forKey: "Admin") == is_admin {
//                    print("userDefaults Admin: \(self.userDefaults.integer(forKey: "Admin"))")
//                    print("is_admin: \(is_admin)")
                    self.userAuth = 1
                }
                completion(self.userAuth)
            default:
                print("Default")
                
            }
        }
    }
}
