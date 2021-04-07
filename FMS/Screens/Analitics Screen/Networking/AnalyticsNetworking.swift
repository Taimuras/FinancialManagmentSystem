//
//  NetworkGetAllUsers.swift
//  FMS
//
//  Created by tami on 3/19/21.
//

import Foundation
import Alamofire
import SwiftyJSON


class AnalyticsNetworking{
    let userDefaults = UserDefaults.standard
    let interceptor = JWTAccessTokenAdapter()
    let constants = Constants()
    
    var users: [AllUsersModel] = []
    
    
    func getAnalytics(completion: @escaping ([AllUsersModel]) -> ()){

        let url = constants.analyticsEndPoint
        let requestAPI = AF.request(url, method: .get, encoding: JSONEncoding.default, interceptor: interceptor)
        
        requestAPI.responseJSON { (response) in
            switch response.result{
            case .success(let data):
                let json = JSON(data)
//                print("json count \(json["count"])")
                print("Analytics : \(json)")
                
//                self.users.removeAll()
//                for i in 0 ..< json["count"].intValue{
//                    let user: AllUsersModel = AllUsersModel(id: json["results"][i]["id"].intValue, first_name: json["results"][i]["first_name"].stringValue, last_name: json["results"][i]["last_name"].stringValue, email: json["results"][i]["email"].stringValue, is_admin: json["results"][i]["is_admin"].boolValue)
//                    self.users.insert(user, at: 0)
//                }
//
//                completion(self.users)
            default:
                return print("Fail")
            }
            
        }
    }
}
