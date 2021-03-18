import Foundation
import Alamofire
import SwiftyJSON
import Reachability


class ApiCalling {
    let constants = Constants()
    let userDefaults = UserDefaults.standard
    var reachability: Reachability?
    var userAuth: Int = 0
    
    
    func logInApiCalling(email: String, password: String, completion: @escaping (Int) -> ()) {
        
        
        
        let param = [
            "email" : email as AnyObject,
            "password" : password as AnyObject
        ]

        
        let requestAPI = AF.request(constants.logInEndPoint, method: .post, parameters: param, encoding: JSONEncoding.default, headers: nil, interceptor: nil)
        
        requestAPI.responseJSON { [self] (response) in
            //Tokens coming
//            print(response.value!)
//            print(response.description)
//            print(response.response?.statusCode)
            let statusCode = response.response?.statusCode ?? 0
            switch statusCode{
                case 200:
                    let json = JSON(response.value!)
        //            print("Json \(json)")
                    let refreshToken = json["refresh"].stringValue
                    self.userDefaults.setValue(refreshToken, forKey: "RefreshToken")
                    let accessToken = json["access"].stringValue
        //            print("AccessToken \(accessToken) ")
                    self.userDefaults.setValue(accessToken, forKey: "AccessToken")
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let mainTabBarController = storyboard.instantiateViewController(identifier: "MainTabBarController")
                    (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(mainTabBarController)
                    userAuth = 1
                    completion(userAuth)
                    userAuth = 0
                    
                default:
                    userAuth = 0
                    completion(userAuth)
            }
            
            
        }
        
    }
    
    
}
