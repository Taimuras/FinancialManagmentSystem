//
//  GetAllCounterParts.swift
//  FMS
//
//  Created by tami on 3/25/21.
//

import Foundation

import Alamofire
import SwiftyJSON


class GetAllSections{
    let userDefaults = UserDefaults.standard
    var sections: [DirectionModel] = []
    
    
    func getAllSections(url: String, completion: @escaping ([DirectionModel]) -> ()){

        let accessToken = userDefaults.string(forKey: "AccessToken")!
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(accessToken)"
        ]
        
        
        let requestAPI = AF.request(url, method: .get, encoding: JSONEncoding.default, headers: headers, interceptor: nil)
        
        requestAPI.responseJSON { (response) in
            switch response.result{
            case .success(let data):
                let json = JSON(data)
                
                self.sections.removeAll()
                for i in 0 ..< json["count"].intValue{
                    let section: DirectionModel = DirectionModel(id: json["results"][i]["id"].intValue, name: json["results"][i]["name"].stringValue)
                        
                    self.sections.append(section)
                }

                completion(self.sections)
            default:
                return print("Fail")
            }
            
        }
    }
}
