import Foundation

import Alamofire
import SwiftyJSON


class GetCounterPartByID{
    let userDefaults = UserDefaults.standard
    
    
    
    func getAllCounterParts(url: String, completion: @escaping (CounterPartModel) -> ()){

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
                
                let counterPart: CounterPartModel = CounterPartModel(id: json["id"].intValue, name: json["name"].stringValue, surname: json["surname"].stringValue, patronymic: json["patronymic"].stringValue)
                completion(counterPart)
            default:
                return print("Fail")
            }
            
        }
    }
}
