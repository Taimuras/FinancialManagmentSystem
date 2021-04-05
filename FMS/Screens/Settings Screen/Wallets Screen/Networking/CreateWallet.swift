import Foundation
import Alamofire


class CreateWallet{
    
    
    let userDefaults = UserDefaults.standard
    var userAuth: Int = 0
    let constants = Constants()
    func createWallet(name: String, balance: Int, completion: @escaping (Int) -> ()){
        
        let param = [
            "name" : name as String,
            "balance" : balance as Int
        ] as [String : Any]
        
        
        let accessToken = userDefaults.string(forKey: "AccessToken")!
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(accessToken)"
        ]
        
        
        
        
        let requestAPI = AF.request(constants.walletEndPoint, method: .post, parameters: param, encoding: JSONEncoding.default, headers: headers, interceptor: nil)
        
        
        requestAPI.responseJSON { (response) in
            
            let statusCode = response.response?.statusCode
//            print(response.description)
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
