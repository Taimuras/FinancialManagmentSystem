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
    
    //Cell's Identifier
    let userScreenTableViewCellIdentifier = "UserTVCell"
    let mainScreenCollectionViewCellIdentifier = "MainCVC"
    let counterPartTableViewCellIdentifier = "CounterPartTBCell"
    
    //Storyboard IDs
    let tabBarViewIdintifier = "TabBarStoryBoardID"
    let addingModalVC = "AddingModalVC"
    let editingTransactionsVC = "EditingTransactionsVC"
    let editingTransferVC = "EditingTransferVC"
    let filterVC = "FilterVC"
    let userEditingVC = "UserEditingVC"
    let counterPartAddingVC = "CounterPartAddingVC"
    
    
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
    let logInEndPoint = "https://neobis-finance-sistem.herokuapp.com/account/api/token/"
    let refreshTokenApi = "https://neobis-finance-sistem.herokuapp.com/account/api/token/refresh/"
    let transitionsEndPoint = "https://neobis-finance-sistem.herokuapp.com/transaction/"
    let createTransactionEndPotin = "https://neobis-finance-sistem.herokuapp.com/transaction/"
    let mainScreenFetchIncOutBalance = "https://neobis-finance-sistem.herokuapp.com/profit_consumption_balance/"
    let walletEndPoint = "https://neobis-finance-sistem.herokuapp.com/wallet/"
    let counterAgentEndPoint = "https://neobis-finance-sistem.herokuapp.com/contractor/"
    let directionsEndPoint = "https://neobis-finance-sistem.herokuapp.com/section/"
    let createUserEndPoint = "https://neobis-finance-sistem.herokuapp.com/account/api/user/"
    let categoriesEndPoint = "https://neobis-finance-sistem.herokuapp.com/category/"
    let projectsEndPoint = "https://neobis-finance-sistem.herokuapp.com/project/"
    let allUsersEndPoint = "https://neobis-finance-sistem.herokuapp.com/account/api/user/"
    let transactionByIDEndPoint = "https://neobis-finance-sistem.herokuapp.com/transaction/"
    let deleteTransactionByIDEndPoint = "https://neobis-finance-sistem.herokuapp.com/transaction/"
    let updateTransactionByIDEndPoint = "https://neobis-finance-sistem.herokuapp.com/transaction/"
    let getUserByEmailEndPoint = "https://neobis-finance-sistem.herokuapp.com/account/api/change/user/"  // \(email.gmail.com)
    let getSessionUserEndPoint = "https://neobis-finance-sistem.herokuapp.com/account/api/session-user/"  // .post
    let deleteUserEndPoint = "https://neobis-finance-sistem.herokuapp.com/account/api/change/user/" // \(email@gmail.com)
    let updateUserEndPoint = "https://neobis-finance-sistem.herokuapp.com/account/api/change/user/" // \(email@gmail.com)
    let getAllCounterPartsEndPoint = "https://neobis-finance-sistem.herokuapp.com/contractor/"
    
    
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
    
    func dateToString(date: Date) -> String{
        let loc = Locale(identifier: "ru_RU")
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        formatter.locale = loc
        return formatter.string(from: date)
    }
    
    func stringToDate(dateString: String) -> Date{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy' 'HH:mm"
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale.current
        return dateFormatter.date(from: dateString)!
    }
    
    func dateToServer(date: Date) -> String{
        let local = Locale(identifier: "en_US_POSIX")
        let form = DateFormatter()
        form.dateFormat = "yyyy-MM-dd'T'hh:mm"
        form.locale = local
        return form.string(from: date)
    }
    
    func filteredDateToServer(date: Date) -> String{
        let local = Locale(identifier: "en_US_POSIX")
        let form = DateFormatter()
        form.dateFormat = "yyyy-MM-dd"
        form.locale = local
        return form.string(from: date)
    }
}

