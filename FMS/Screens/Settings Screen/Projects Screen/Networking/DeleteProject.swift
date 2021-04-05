//
//  DeleteCounterPart.swift
//  FMS
//
//  Created by tami on 3/25/21.
//

import Foundation
import Alamofire

class DeleteProject{
    
    
    let userDefaults = UserDefaults.standard
    var userAuth: Int = 0
    let constants = Constants()
    
    
    
    
    func deleteProjectByID(id: Int, completion: @escaping (Int) -> ()){
        var success = 0
        let accessToken = userDefaults.string(forKey: "AccessToken")!
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(accessToken)"
        ]
        
        let url = constants.projectEndPoint + String(id)
        let requestAPI = AF.request(url, method: .delete, parameters: nil, encoding: JSONEncoding.default, headers: headers, interceptor: nil)
        //responseJSON = responseString
        requestAPI.responseJSON { (response) in
            switch response.result{
            case .success( _):
                success = 1
                completion(success)
                success = 0
            default:
                completion(success)
            }
            
        }
        
    }
}
