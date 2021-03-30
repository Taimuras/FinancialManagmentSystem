
import Foundation
import Alamofire
import SwiftyJSON


final class JWTAccessTokenAdapter: Interceptor {
    
    let userDefaults = UserDefaults.standard

    
    
    override func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        let accessToken = userDefaults.string(forKey: "AccessToken")!
        
        guard urlRequest.url?.absoluteString.hasPrefix("https://neobis-finance-sistem.herokuapp.com/") == true else {
            
            return completion(.success(urlRequest))
        }
        var urlRequest = urlRequest
        
        
        urlRequest.setValue("Bearer " + accessToken, forHTTPHeaderField: "Authorization")
        
        completion(.success(urlRequest))
    }
    
    
    
    override func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {

        
        if let response = request.task?.response as? HTTPURLResponse, response.statusCode == 401 {
            if request.retryCount < 3{
                refreshToken { (refreshed) in
                    if refreshed {
                        return completion(.retry)
                    } else {
                        return completion(.doNotRetry)
                    }
                }
            } else {
                completion(.doNotRetry)
            }
        } else {
            completion(.doNotRetry)
        }
        
        
        
    }
    
    
    func refreshToken(  completion: @escaping (Bool) -> ()) {
        let resfreshToken = userDefaults.string(forKey: "RefreshToken")
        
        
        let param = [
            "refresh" : resfreshToken as Any
        ] as [String : Any]
        
        
        let refreshRequest = AF.request("https://neobis-finance-sistem.herokuapp.com/account/api/token/refresh/", method: .post,parameters: param, encoding: JSONEncoding.default, headers: nil, interceptor: nil)
        refreshRequest.responseJSON { (response) in
            
            switch response.result {
            case .success(let token):
//                print(token)
                let json = JSON(token)
                let accessToken = json["access"].stringValue
//                print(accessToken)
                self.userDefaults.removeObject(forKey: "AccessToken")
                self.userDefaults.setValue(accessToken, forKey: "AccessToken")
                
                completion(true)
            case .failure( _):
                completion(false)
            }
        }
    }
    

}
