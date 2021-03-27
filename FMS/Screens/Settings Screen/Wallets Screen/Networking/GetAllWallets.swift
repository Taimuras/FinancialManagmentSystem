
import Foundation

import Alamofire
import SwiftyJSON


class GetAllWallets{
    
    let userDefaults = UserDefaults.standard
    var wallets: [WalletModel] = []
    
    
    func getAllWallets(url: String, completion: @escaping ([WalletModel]) -> ()){

        let accessToken = userDefaults.string(forKey: "AccessToken")!
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(accessToken)"
        ]
        
        
        let requestAPI = AF.request(url, method: .get, encoding: JSONEncoding.default, headers: headers, interceptor: nil)
        
        requestAPI.responseJSON { (response) in
            switch response.result{
            case .success(let data):
                let json = JSON(data)
//                print("Wallet Part: \(json)")
                self.wallets.removeAll()
                for i in 0 ..< json["count"].intValue{
                    let wallet: WalletModel = WalletModel(balance: json["results"][i]["balance"].intValue, id: json["results"][i]["id"].intValue, name: json["results"][i]["name"].stringValue)
                        

                    self.wallets.append(wallet)
                }
                completion(self.wallets)
            default:
                return print("Fail")
            }
            
        }
    }
}
