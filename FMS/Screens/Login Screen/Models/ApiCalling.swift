//
//  ApiCalling.swift
//  FMS
//
//  Created by tami on 3/6/21.
//

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
//        let url = URLRequest(url: URL(string: constants.loginPart)!)
            
        
        
        
        let requestAPI = AF.request(constants.loginPart, method: .post, parameters: param, encoding: JSONEncoding.default, headers: nil, interceptor: nil)
        
        requestAPI.responseJSON { (response) in
            //Tokens coming
//            print(response.value!)
            
            let json = JSON(response.value!)
//            print(json)
            let refreshToken = json["refresh"].stringValue
            self.userDefaults.setValue(refreshToken, forKey: "RefreshToken")
            
            
            if let refTokUsDef = self.userDefaults.string(forKey: "RefreshToken"){
                print(refTokUsDef)
            }
            
            print("\n")
            let accessToken = json["access"].stringValue
            self.userDefaults.setValue(accessToken, forKey: "AccessToken")
            if let accessTokUsDef = self.userDefaults.string(forKey: "AccessToken"){
                print(accessTokUsDef)
            }
            
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let mainTabBarController = storyboard.instantiateViewController(identifier: "MainTabBarController")
                
                // This is to get the SceneDelegate object from your view controller
                // then call the change root view controller function to change to main tab bar
            (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(mainTabBarController)
            
            
            

        }
        
    }
}
