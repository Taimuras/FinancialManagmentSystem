import Foundation
import Alamofire


class CreateCounterPart{
    let userDefaults = UserDefaults.standard
    var userAuth: Int = 0
    let constants = Constants()
    func createCounterPart(name: String, surname: String, patronymic: String, completion: @escaping (Int) -> ()){
        
        var param = [
            "name" : name as String,
            "surname" : surname as String
        ] as [String : Any]
        
        if patronymic != "" {
            param["patronymic"] = patronymic
        }
        
        
        let accessToken = userDefaults.string(forKey: "AccessToken")!
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(accessToken)"
        ]
        
        
        
        
        let requestAPI = AF.request(constants.createCounterPartEndPoint, method: .post, parameters: param, encoding: JSONEncoding.default, headers: headers, interceptor: nil)
        
        
        requestAPI.responseJSON { (response) in
            
            let statusCode = response.response?.statusCode
            print(response.description)
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
