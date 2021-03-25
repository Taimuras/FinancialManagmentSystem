//
//  GetAllCounterParts.swift
//  FMS
//
//  Created by tami on 3/25/21.
//

import Foundation

import Alamofire
import SwiftyJSON


class GetAllCounterParts{
    let userDefaults = UserDefaults.standard
    var counterParts: [CounterPartModel] = []
    
    
    func getAllCounterParts(url: String, completion: @escaping ([CounterPartModel]) -> ()){

        let accessToken = userDefaults.string(forKey: "AccessToken")!
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(accessToken)"
        ]
        
        
        let requestAPI = AF.request(url, method: .get, encoding: JSONEncoding.default, headers: headers, interceptor: nil)
        
        requestAPI.responseJSON { (response) in
            switch response.result{
            case .success(let data):
                let json = JSON(data)
//                print("Counter Parts: \(json)")
                self.counterParts.removeAll()
                for i in 0 ..< json["count"].intValue{
                    let counterPart: CounterPartModel = CounterPartModel(id: json["results"][i]["id"].intValue, name: json["results"][i]["name"].stringValue, surname: json["results"][i]["surname"].stringValue, patronymic: json["results"][i]["patronymic"].stringValue)
                        
                        
                    self.counterParts.append(counterPart)
                }

                completion(self.counterParts)
            default:
                return print("Fail")
            }
            
        }
    }
}
