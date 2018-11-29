//
//  UserTblCell.swift
//  Assignment
//
//  Created by Mudassir Abbas on 28/11/2018.
//  Copyright © 2018 Mudassir Abbas. All rights reserved.
//

import UIKit

class UserTblCell: UITableViewCell {
    //MARK: - IBOUTLETS
    @IBOutlet weak var userImg: UIImageView!
    @IBOutlet weak var userNameLbl: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
