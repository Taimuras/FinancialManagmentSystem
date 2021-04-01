import Foundation

import Alamofire
import SwiftyJSON


class GetSingleCategoryByID{
    
    let userDefaults = UserDefaults.standard
    
    let constants = Constants()
    var sections: [Int] = []
    
    func getSingleCategoryByID(id: Int, completion: @escaping (CategoryByIDModel) -> ()){

        let accessToken = userDefaults.string(forKey: "AccessToken")!
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(accessToken)"
        ]
        
        let url = constants.categoriesEndPoint + String(id)
        
        let requestAPI = AF.request(url, method: .get, encoding: JSONEncoding.default, headers: headers, interceptor: nil)
        
        requestAPI.responseJSON { (response) in
            switch response.result{
            case .success(let data):
                let json = JSON(data)
                
                for i in 0 ..< json["section"].count {
                    self.sections.append(json["section"][i].intValue)
                }
                
                
                let category: CategoryByIDModel = CategoryByIDModel(id: json["id"].intValue, name: json["name"].stringValue, section: self.sections)
                
                
                completion(category)
            default:
                return print("Fail")
            }
            
        }
    }
}
