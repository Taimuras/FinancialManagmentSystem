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
    
    
    //MARK: Cell's and Stroyboard's IDs
    //Cell's Identifier
    let userScreenTableViewCellIdentifier = "UserTVCell"
    let mainScreenCollectionViewCellIdentifier = "MainCVC"
    let counterPartTableViewCellIdentifier = "CounterPartTBCell"
    let projectPartTableViewCellIdentifier = "ProjectTVCell"
    let walletPartTableViewCellIdentifier = "WalletTVCell"
    let sectionsPartTableViewCellIdentifier = "SectionTVCell"
    let categoryPartTableViewCellIdentifier = "CategoryTVCell"
    let historyCollectionViewCellIdentifier = "HistoryCVCell"
    
    //Storyboard IDs
    let tabBarViewIdintifier = "TabBarStoryBoardID"
    let addingModalVC = "AddingModalVC"
    let editingTransactionsVC = "EditingTransactionsVC"
    let editingTransferVC = "EditingTransferVC"
    let filterVC = "FilterVC"
    let userEditingVC = "UserEditingVC"
    let counterPartAddingVC = "CounterPartAddingVC"
    let counterPartEditingVC = "EditingCounterPartVC"
    let projectPartEditingVC = "EditingProjectsVC"
    let walletsPartEditingVC = "EditingWalletsVC"
    let sectionPartEditingVC = "EditingSectionVC"
    let categoryPartEditingVC = "EditingCategoryVC"
    let historyVC = "HistoryVC"
    
    
    
    //Segues IDs
    let filterSegue = "FilterSegue"
    
    
    //MARK: Fonts
    //Font Bold size
    let fontBold34 = UIFont(name: "OpenSans-Bold", size: 34)
    let fontBold18 = UIFont(name: "OpenSans-Bold", size: 18)
    let fontBold16 = UIFont(name: "OpenSans-Bold", size: 16)
    let fontBold14 = UIFont(name: "OpenSans-Bold", size: 14)
    
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
    
    
    // MARK: EndPoints
    // Server
    let server = "https://neobis-finance-sistem.herokuapp.com/"
    
    //Log In and Refersh Token
    let logInEndPoint = "https://neobis-finance-sistem.herokuapp.com/account/api/token/"
    let refreshTokenApi = "https://neobis-finance-sistem.herokuapp.com/account/api/token/refresh/"
    
    //Summary of pro, con and Total Balance
    let mainScreenFetchIncOutBalance = "https://neobis-finance-sistem.herokuapp.com/profit_consumption_balance/"
    
    //History End point
    let historyEndPoint = "https://neobis-finance-sistem.herokuapp.com/history/"
    let deletingHistoryEndPoint = "https://neobis-finance-sistem.herokuapp.com/delete-history/"
    
    // All 6 needed end Point(CRUD). All changes Only by ID!
    let transactionEndPoint = "https://neobis-finance-sistem.herokuapp.com/transaction/"
    let sectionEndPoint = "https://neobis-finance-sistem.herokuapp.com/section/"
    let counterAgentEndPoint = "https://neobis-finance-sistem.herokuapp.com/contractor/"
    let walletEndPoint = "https://neobis-finance-sistem.herokuapp.com/wallet/"
    let categoriesEndPoint = "https://neobis-finance-sistem.herokuapp.com/category/"
    let projectEndPoint = "https://neobis-finance-sistem.herokuapp.com/project/"

    //Create User and Get all Users
    let createUserEndPoint = "https://neobis-finance-sistem.herokuapp.com/account/api/user/"
    let allUsersEndPoint = "https://neobis-finance-sistem.herokuapp.com/account/api/user/"
    
    // update delete User By Email
    let crudUserByEmail = "https://neobis-finance-sistem.herokuapp.com/account/api/change/user/"
    
    
    // Get Session User
    let getSessionUserEndPoint = "https://neobis-finance-sistem.herokuapp.com/account/api/session-user/"
    
    //Analytics
    let analyticsProjectsEndPoint = "https://neobis-finance-sistem.herokuapp.com/analytics/prjects/"
    let analyticsContractorEndPoint = "https://neobis-finance-sistem.herokuapp.com/analytics/transaction/"
 
   
    
    // MARK: Date Formating Funcs
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
    
    func stringToDateHistory(dateString: String) -> String{
        let array = dateString.split(separator: "T")
        let day = array[0].split(separator: "-")
        let time = array[1].split(separator: ":")
        
        var date = day[2] + "." + day[1] + "." + day[0] + " в "
        date += time[0] + ":" + time[1]
        
        
        return date
    }
    
    
}

