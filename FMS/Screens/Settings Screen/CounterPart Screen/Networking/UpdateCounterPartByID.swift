//
//  UpdateCounterPartByID.swift
//  FMS
//
//  Created by tami on 3/26/21.
//

import Foundation
import Alamofire


class UpdateCounterPartByID{
    let userDefaults = UserDefaults.standard
    var userAuth: Int = 0
    let constants = Constants()
    func updateCounterPart(id: Int, name: String, surname: String, patronymic: String, completion: @escaping (Int) -> ()){
        
        var param = [
            "surname" : surname as String,
            "name" : name as String
        ] as [String : Any]
        
        if patronymic != "" {
            param["patronymic"] = patronymic
        }
        
        
        let accessToken = userDefaults.string(forKey: "AccessToken")!
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(accessToken)"
        ]
        
        
        
        let url = constants.counterAgentEndPoint + String(id)
        print("url to update: \(url)")
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
