//
//  UserTBCell.swift
//  FMS
//
//  Created by tami on 3/16/21.
//

import UIKit

class UserTBCell: UITableViewCell {
    
    let constants = Constants()

    @IBOutlet weak var AvatarImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var emailLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        design()
    }

    
    
}


extension UserTBCell{
    func design (){
   

        nameLabel.font = constants.fontSemiBold16
        emailLabel.font = constants.fontRegular13
        
       
        
        
    }
}

