import Foundation

import Alamofire
import SwiftyJSON


class GetSingleWalletByID{
    let userDefaults = UserDefaults.standard
    
    
    
    func getSinglewalletByID(url: String, completion: @escaping (WalletModel) -> ()){

        let accessToken = userDefaults.string(forKey: "AccessToken")!
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(accessToken)"
        ]
        
        
        let requestAPI = AF.request(url, method: .get, encoding: JSONEncoding.default, headers: headers, interceptor: nil)
        
        requestAPI.responseJSON { (response) in
            switch response.result{
            case .success(let data):
                let json = JSON(data)
//                print("Wallet: \(json)")
                
                let wallet: WalletModel = WalletModel(balance: json["balance"].intValue, id: json["id"].intValue, name: json["name"].stringValue)
                
                
                completion(wallet)
            default:
                return print("Fail")
            }
            
        }
    }
}
