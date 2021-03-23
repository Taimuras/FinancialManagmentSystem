//
//  GetSessionUser.swift
//  FMS
//
//  Created by tami on 3/23/21.
//

import Foundation
import Alamofire



class GetSessionUser {
    
    let userDefaults = UserDefaults.standard
    var userAuth: Int = 0
    let constants = Constants()
    
    func getSessionUser(completion: @escaping (Int) -> ()){
        
        let accessToken = userDefaults.string(forKey: "AccessToken")!
        
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(accessToken)"
        ]
        
        
        let requestAPI = AF.request(constants.getSessionUserEndPoint, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: headers, interceptor: nil)
        
        
        requestAPI.responseJSON { (response) in
            let statusCode = response.response?.statusCode
            print(response.description)
//            print(response.response!)
//            print(response.result)

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
