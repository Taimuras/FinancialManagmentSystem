import Foundation
import Alamofire
import SwiftyJSON


class ApiCalling {
    let constants = Constants()
    let userDefaults = UserDefaults.standard
    
    func logInApiCalling(email: String, password: String) {
        
        let param = [
            "email" : email.trimmingCharacters(in: .whitespacesAndNewlines) as AnyObject,
            "password" : password.trimmingCharacters(in: .whitespacesAndNewlines) as AnyObject
        
        ]
        
        let requestAPI = AF.request(constants.loginPart, method: .post, parameters: param, encoding: JSONEncoding.default, headers: nil, interceptor: nil)
        
        requestAPI.responseJSON { (response) in
            //Tokens coming
//            print(response.value!)
            
            let json = JSON(response.value!)
            let refreshToken = json["refresh"].stringValue
            self.userDefaults.setValue(refreshToken, forKey: "RefreshToken")
            
            let accessToken = json["access"].stringValue
            self.userDefaults.setValue(accessToken, forKey: "AccessToken")
            
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let mainTabBarController = storyboard.instantiateViewController(identifier: "MainTabBarController")
            (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(mainTabBarController)
        }
        
    }
    
    func updateAccessToken(){
        let refreshToken = UserDefaults.standard.string(forKey: "RefreshToken")
        let param = ["refresh" : refreshToken]
        
        
        let requestTorefreshToken = AF.request(constants.refreshToken, method: .post, parameters: param as Parameters, encoding: JSONEncoding.default, headers: nil, interceptor: nil)
        requestTorefreshToken.responseJSON { (response) in
            let json = JSON(response.value!)
            let accessToken = json["access"].stringValue
            self.userDefaults.setValue(accessToken, forKey: "AccessToken")
        }
    }
}
