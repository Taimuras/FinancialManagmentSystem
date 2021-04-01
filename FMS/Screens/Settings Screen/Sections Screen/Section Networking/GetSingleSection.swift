import Foundation

import Alamofire
import SwiftyJSON


class GetSingleSectionByID{
    
    let userDefaults = UserDefaults.standard
    
    let constants = Constants()
    var category_set: [CategoryModel] = []
    
    func getSingleSectiontByID(id: Int, completion: @escaping (Section) -> ()){

        let accessToken = userDefaults.string(forKey: "AccessToken")!
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(accessToken)"
        ]
        
        let url = constants.directionsEndPoint + String(id)
        
        let requestAPI = AF.request(url, method: .get, encoding: JSONEncoding.default, headers: headers, interceptor: nil)
        
        requestAPI.responseJSON { (response) in
            switch response.result{
            case .success(let data):
                let json = JSON(data)
//                print("Sections: \(json)")
                self.category_set.removeAll()
                for i in 0 ..< json["category_set"].count {
                    let category = CategoryModel(id: json["category_set"][i]["id"].intValue, name: json["category_set"][i]["name"].stringValue)
                    self.category_set.append(category)
                }
                let section: Section = Section(id: json["id"].intValue, name: json["name"].stringValue, category_set: self.category_set)
                    
                completion(section)
            default:
                return print("Fail")
            }
            
        }
    }
}
