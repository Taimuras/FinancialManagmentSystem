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
    
    func fetchingTransactions(url: String, completion: @escaping (JSON) -> ()){
        var swiftyJsonVar: JSON = []
        AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor: nil).response { (data) in
            let json = JSON(data.value! as Any)
            swiftyJsonVar = json["results"]
            completion(swiftyJsonVar)
        }
    }
}
