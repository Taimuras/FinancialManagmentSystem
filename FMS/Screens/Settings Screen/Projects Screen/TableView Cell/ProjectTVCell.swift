//
//  ProjectTVCell.swift
//  FMS
//
//  Created by tami on 3/26/21.
//

import UIKit

class ProjectTVCell: UITableViewCell {
    
    let constants = Constants()
    
    
    @IBOutlet weak var projectName: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
        projectName.font = constants.fontSemiBold16
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
