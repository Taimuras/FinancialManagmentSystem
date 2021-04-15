//
//  CategoryTVCell.swift
//  FMS
//
//  Created by tami on 3/30/21.
//

import UIKit

class CategoryTVCell: UITableViewCell {
    let constants = Constants()
    @IBOutlet weak var categoryLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        categoryLabel.font = constants.fontSemiBold16
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
