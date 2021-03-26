
import Foundation

import Alamofire
import SwiftyJSON


class GetAllProjects{
    
    let userDefaults = UserDefaults.standard
    var projects: [ProjectModel] = []
    
    
    func getAllProjects(url: String, completion: @escaping ([ProjectModel]) -> ()){

        let accessToken = userDefaults.string(forKey: "AccessToken")!
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(accessToken)"
        ]
        
        
        let requestAPI = AF.request(url, method: .get, encoding: JSONEncoding.default, headers: headers, interceptor: nil)
        
        requestAPI.responseJSON { (response) in
            switch response.result{
            case .success(let data):
                let json = JSON(data)
//                print("Project Part: \(json)")
                self.projects.removeAll()
                for i in 0 ..< json["count"].intValue{
                    let project: ProjectModel = ProjectModel(id: json["results"][i]["id"].intValue, name: json["results"][i]["name"].stringValue)
                    self.projects.append(project)
                }
                completion(self.projects)
            default:
                return print("Fail")
            }
            
        }
    }
}
