//
//  SectionTVCell.swift
//  FMS
//
//  Created by tami on 3/30/21.
//

import UIKit

class SectionTVCell: UITableViewCell {
    let constants = Constants()
    @IBOutlet weak var sectionNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        sectionNameLabel.font = constants.fontSemiBold16
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
