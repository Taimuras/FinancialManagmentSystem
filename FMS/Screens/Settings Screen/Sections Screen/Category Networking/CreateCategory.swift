import Foundation
import Alamofire


class CreateCategory{
    
    
    let userDefaults = UserDefaults.standard
    var userAuth: Int = 0
    let constants = Constants()
    
    
    func createCategory(sectionID: Int, name: String, completion: @escaping (Int) -> ()){
        
        let param = [
            "name" : name as String,
            "section": [sectionID] as [Int],
            "type": 1
        ] as [String : Any]
        
        
        let accessToken = userDefaults.string(forKey: "AccessToken")!
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(accessToken)"
        ]
        
        
        print("Param: \(param)")
        
        let requestAPI = AF.request(constants.categoriesEndPoint, method: .post, parameters: param, encoding: JSONEncoding.default, headers: headers, interceptor: nil)
        
        
        requestAPI.responseJSON { (response) in
            
            let statusCode = response.response?.statusCode
            print(response.result)
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
