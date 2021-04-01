import Foundation

import Alamofire
import SwiftyJSON


class GetSingleProjectByID{
    let userDefaults = UserDefaults.standard
    
    
    
    func getSingleProjectByID(url: String, completion: @escaping (ProjectModel) -> ()){

        let accessToken = userDefaults.string(forKey: "AccessToken")!
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(accessToken)"
        ]
        
        
        let requestAPI = AF.request(url, method: .get, encoding: JSONEncoding.default, headers: headers, interceptor: nil)
        
        requestAPI.responseJSON { (response) in
            switch response.result{
            case .success(let data):
                let json = JSON(data)
//                                print("Project: \(json)")
                
                let project: ProjectModel = ProjectModel(id: json["id"].intValue, name: json["name"].stringValue)
                    
                completion(project)
            default:
                return print("Fail")
            }
            
        }
    }
}
