//
//  HistoryCVCell.swift
//  FMS
//
//  Created by tami on 3/31/21.
//

import UIKit

class HistoryCVCell: UICollectionViewCell {
    
    let constants = Constants()
    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var actionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    
    @IBOutlet weak var view: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        
        design()
        
        // Initialization code
    }
    
    
    
    func design(){

        contentView.layer.cornerRadius = 10.0
        contentView.layer.masksToBounds = true
        userNameLabel.font = constants.fontBold18
        actionLabel.font = constants.fontSemiBold14
        dateLabel.font = constants.fontRegular12
        
    }

}
