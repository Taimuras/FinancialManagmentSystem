//
//  FetchingTransactions.swift
//  FMS
//
//  Created by tami on 3/8/21.
//

import Foundation
import Alamofire
import SwiftyJSON


class FetchingTransactions {
    let constants = Constants()
    let userDefaults = UserDefaults.standard
    
        
    
    func fetchingTransactions(url: String, completion: @escaping (String) -> ()){
//        var swiftyJsonVar: JSON = []
        var sss: String = ""
        let accessToken = userDefaults.string(forKey: "AccessToken")!
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(accessToken)"
        ]
        
        
        let requestAPI = AF.request(url, method: .get, encoding: JSONEncoding.default, headers: headers, interceptor: nil)
        
        requestAPI.responseJSON { (response) in
            let json = JSON(response.value!)
            print(json["count"])
            sss = json["count"].stringValue
            completion(sss)
        }
    }
}
