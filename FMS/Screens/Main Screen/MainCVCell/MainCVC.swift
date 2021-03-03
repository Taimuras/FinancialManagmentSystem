//
//  MainCVC.swift
//  FMS
//
//  Created by tami on 3/2/21.
//

import UIKit

class MainCVC: UICollectionViewCell {

    @IBOutlet weak var actionIcon: UIImageView!
    @IBOutlet weak var companyName: UILabel!
    @IBOutlet weak var bankName: UILabel!
    @IBOutlet weak var dateOfAction: UILabel!
    @IBOutlet weak var actionValue: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        contentView.layer.cornerRadius = 10.0
        contentView.layer.masksToBounds = true
        
        // Initialization code
    }

}
