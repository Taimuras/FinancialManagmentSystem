//
//  CounterPartTBCell.swift
//  FMS
//
//  Created by tami on 3/25/21.
//

import UIKit

class CounterPartTBCell: UITableViewCell {

    let constants = Constants()
    @IBOutlet weak var lastAndFirstNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        lastAndFirstNameLabel.font = constants.fontSemiBold16
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
