import Foundation
import UIKit
import Alamofire
import SwiftyJSON


class FetchingDataFilterScreen{
    let userDefaults = UserDefaults.standard
    
    var wallets: [WalletModel] = []
    var counterAgents: [CounterAgentsModel] = []
    var directions: [DirectionModel] = []
    var categories: [CategoryModel] = []
    var projects: [ProjectModel] = []
    
    func fetchingWallets(url: String, completion: @escaping ([WalletModel]) -> ()) {
        let accessToken = userDefaults.string(forKey: "AccessToken")!
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(accessToken)"
        ]
        let requestAPI = AF.request(url, method: .get, encoding: JSONEncoding.default, headers: headers, interceptor: nil)
        
        requestAPI.responseJSON { (response) in
            
            switch response.result{
            case .success(let data):
                //                    print(data)
                let json = JSON(data)
                
                
                if json["results"].count == 0 {
                    let wallet = WalletModel(balance: 0, id: 0, name: "There is No Wallets!")
                    self.wallets.append(wallet)
                    completion(self.wallets)
                } else {
                    for i in 0 ... json["results"].count{
                        let balance = json["results"][i]["balance"].intValue
                        let id = json["results"][i]["id"].intValue
                        let name = json["results"][i]["name"].stringValue
                        let wallet = WalletModel(balance: balance, id: id, name: name)
                        self.wallets.append(wallet)
                        completion(self.wallets)
                    }
                }
                //                    let profit = json["profit_sum"].stringValue
                
            default:
                return print("Fail")
            }
            
        }
    }
    
    
    func fetchingCounterAgents(url: String, completion: @escaping ([CounterAgentsModel]) -> ()) {
        let accessToken = userDefaults.string(forKey: "AccessToken")!
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(accessToken)"
        ]
        let requestAPI = AF.request(url, method: .get, encoding: JSONEncoding.default, headers: headers, interceptor: nil)
        
        requestAPI.responseJSON { (response) in
            
            switch response.result{
            case .success(let data):
                
//                print(data)
                
                let json = JSON(data)
                
                
                if json["results"].count == 0 {
                    let counterAgent = CounterAgentsModel(id: 1, name: "There is no CounterParts!", surname: "", patronymic: "")
                    self.counterAgents.append(counterAgent)
                    completion(self.counterAgents)
                } else {
                    for i in 0 ... json["results"].count{
                        let name = json["results"][i]["name"].stringValue
                        let id = json["results"][i]["id"].intValue
                        let surname = json["results"][i]["surname"].stringValue
                        let patr = json["results"][i]["patronymic"].stringValue
//                        let photo = json["results"][i]["photo"].stringValue
                        let counterAgent = CounterAgentsModel(id: id, name: name, surname: surname, patronymic: patr)
                        self.counterAgents.append(counterAgent)
                        completion(self.counterAgents)
                    }
                }
                
                
            default:
                return print("Fail")
            }
            
        }
    }
    
    func fetchingDirections(url: String, completion: @escaping ([DirectionModel]) -> ()) {
        let accessToken = userDefaults.string(forKey: "AccessToken")!
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(accessToken)"
        ]
        let requestAPI = AF.request(url, method: .get, encoding: JSONEncoding.default, headers: headers, interceptor: nil)
        
        requestAPI.responseJSON { (response) in
            
//            print(response.value!)
            

            
            switch response.result{
            case .success(let data):
                
                let json = JSON(data)
//                print(json["results"].count)
                if json["results"].count == 0 {
                    let direction = DirectionModel(id: 0, name: "There is No Sections!")
                    self.directions.append(direction)
                    completion(self.directions)
                } else {
                    for i in 0 ... json["results"].count{
                        //                    let balance = json["results"][i]["balance"].intValue
                        //                    let id = json["results"][i]["id"].intValue
                        let name = json["results"][i]["name"].stringValue
                        let id = json["results"][i]["id"].intValue
                        let direction = DirectionModel(id: id, name: name)
                        self.directions.append(direction)
                        completion(self.directions)
                    }
                }
                
            default:
                return print("Fail")
            }
            
        }
    }
    
    
    func fetchingCategories(url: String, completion: @escaping ([CategoryModel]) -> ()) {
        let accessToken = userDefaults.string(forKey: "AccessToken")!
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(accessToken)"
        ]
        let requestAPI = AF.request(url, method: .get, encoding: JSONEncoding.default, headers: headers, interceptor: nil)
        
        requestAPI.responseJSON { (response) in
            
            switch response.result{
            case .success(let data):
                //                    print(data)
                let json = JSON(data)
                
                
                if json["results"].count == 0 {
                    let category = CategoryModel(id: 0, name: "There is No Categories!")
                    self.categories.append(category)
                    completion(self.categories)
                } else {
                    for i in 0 ... json["results"].count{
                        let id = json["results"][i]["id"].intValue
                        let name = json["results"][i]["name"].stringValue
                        let category = CategoryModel(id: id, name: name)
                        self.categories.append(category)
                        completion(self.categories)
                    }
                }
                
                
            default:
                return print("Fail")
            }
            
        }
    }
    
    func fetchingProjects(url: String, completion: @escaping ([ProjectModel]) -> ()) {
        let accessToken = userDefaults.string(forKey: "AccessToken")!
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(accessToken)"
        ]
        let requestAPI = AF.request(url, method: .get, encoding: JSONEncoding.default, headers: headers, interceptor: nil)
        
        requestAPI.responseJSON { (response) in
            
            switch response.result{
            case .success(let data):
                //                    print(data)
                let json = JSON(data)
                
                
                if json["results"].count == 0 {
                    let project = ProjectModel(id: 0, name: "There is No Projects!")
                    self.projects.append(project)
                    completion(self.projects)
                } else {
                    for i in 0 ... json["results"].count{
                        let id = json["results"][i]["id"].intValue
                        let name = json["results"][i]["name"].stringValue
                        let project = ProjectModel(id: id, name: name)
                        self.projects.append(project)
                        completion(self.projects)
                    }
                }
                
                
            default:
                return print("Fail")
            }
            
        }
    }
}
