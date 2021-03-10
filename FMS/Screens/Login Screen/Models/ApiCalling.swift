import Foundation
import Alamofire
import SwiftyJSON


class ApiCalling {
    let constants = Constants()
    let userDefaults = UserDefaults.standard
    
    func logInApiCalling(email: String, password: String) {
        
        let param = [
            "email" : email as AnyObject,
            "password" : password as AnyObject
        ]
//        trimmingCharacters(in: .whitespacesAndNewlines)
        
        let requestAPI = AF.request(constants.loginPart, method: .post, parameters: param, encoding: JSONEncoding.default, headers: nil, interceptor: nil)
        
        requestAPI.responseJSON { [self] (response) in
            //Tokens coming
//            print(response.value!)
//            print(response.description.description)
            
            
            let json = JSON(response.value!)
//            print("Json \(json)")
            let refreshToken = json["refresh"].stringValue
            self.userDefaults.setValue(refreshToken, forKey: "RefreshToken")
            
            let accessToken = json["access"].stringValue
//            print("AccessToken \(accessToken) ")
            self.userDefaults.setValue(accessToken, forKey: "AccessToken")
            print(userDefaults.string(forKey: "AccessToken")!)
            
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let mainTabBarController = storyboard.instantiateViewController(identifier: "MainTabBarController")
            (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(mainTabBarController)
        }
        
    }
    
    
}
