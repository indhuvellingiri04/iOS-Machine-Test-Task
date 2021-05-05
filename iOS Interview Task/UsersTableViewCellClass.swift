//
//  TableViewCell.swift
//  iOS Interview Task
//
//  Created by developer on 04/05/21.
//

import UIKit

class UsersTableViewCellClass: UITableViewCell {
    
    var userView = UIView()
    
    var userImageView = UIImageView()
     
    var userNameLbl = UILabel()
    
    var userEmail = UILabel()
    
    var userId = UILabel()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
