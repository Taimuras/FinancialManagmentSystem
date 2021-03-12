//
//  Constants.swift
//  FMS
//
//  Created by tami on 3/3/21.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON



class Constants {
    let userDefaults = UserDefaults.standard
    
    //Storyboard IDs
    let mainScreenCollectionViewCellIdentifier = "MainCVC"
    let tabBarViewIdintifier = "TabBarStoryBoardID"
    let addingModalVC = "AddingModalVC"
    let editingTransactionsVC = "EditingTransactionsVC"
    let editingTransferVC = "EditingTransferVC"
    let filterVC = "FilterVC"
    
    
    //Segues IDs
    let filterSegue = "FilterSegue"
    
    //Font Bold size
    let fontBold34 = UIFont(name: "OpenSans-Bold", size: 34)
    let fontBold18 = UIFont(name: "OpenSans-Bold", size: 18)
    let fontBold16 = UIFont(name: "OpenSans-Bold", size: 16)
    
    //Font SemiBold size
    let fontSemiBold36 = UIFont(name: "OpenSans-SemiBold", size: 36)
    let fontSemiBold20 = UIFont(name: "OpenSans-SemiBold", size: 20)
    let fontSemiBold17 = UIFont(name: "OpenSans-SemiBold", size: 17)
    let fontSemiBold18 = UIFont(name: "OpenSans-SemiBold", size: 18)
    let fontSemiBold16 = UIFont(name: "OpenSans-SemiBold", size: 16)
    let fontSemiBold14 = UIFont(name: "OpenSans-SemiBold", size: 14)
    let fontSemiBold10 = UIFont(name: "OpenSans-SemiBold", size: 10)
    let fontSemiBold13 = UIFont(name: "OpenSans-SemiBold", size: 13)
    
    //Font Regular size
    let fontRegular12 = UIFont(name: "OpenSans-Regular", size: 12)
    let fontRegular13 = UIFont(name: "OpenSans-Regular", size: 13)
    let fontRegular14 = UIFont(name: "OpenSans-Regular", size: 14)
    let fontRegular17 = UIFont(name: "OpenSans-Regular", size: 17)
    
    
    
    let server = "https://neobis-finance-sistem.herokuapp.com/"
    let loginPart = "https://neobis-finance-sistem.herokuapp.com/account/api/token/"
    let refreshTokenApi = "https://neobis-finance-sistem.herokuapp.com/account/api/token/refresh/"
    let fetchingAllTransactions = "https://neobis-finance-sistem.herokuapp.com/transaction/"
    let mainScreenFetchIncOutBalance = "https://neobis-finance-sistem.herokuapp.com/profit_consumption_balance/"
    
    
    
    func updateAccessToken(){
        let refreshToken = UserDefaults.standard.string(forKey: "RefreshToken")
        let param = ["refresh" : refreshToken]
        let requestTorefreshToken = AF.request(refreshTokenApi, method: .post, parameters: param as Parameters, encoding: JSONEncoding.default, headers: nil, interceptor: nil)
        requestTorefreshToken.responseJSON { (response) in
            let json = JSON(response.value!)
            let accessToken = json["access"].stringValue
            self.userDefaults.setValue(accessToken, forKey: "AccessToken")
        }
    }
    
}

