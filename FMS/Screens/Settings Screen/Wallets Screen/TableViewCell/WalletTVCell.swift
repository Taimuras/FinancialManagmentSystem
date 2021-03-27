//
//  WalletTVCell.swift
//  FMS
//
//  Created by tami on 3/27/21.
//

import UIKit

class WalletTVCell: UITableViewCell {
    let constants = Constants()
    
    
    @IBOutlet weak var walletNameLabel: UILabel!
    

    override func awakeFromNib() {
        
        
        walletNameLabel.font = constants.fontSemiBold16
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        
        
        super.setSelected(selected, animated: animated)
        

        // Configure the view for the selected state
    }
    
}
