//
//  UserCell.swift
//  IChat
//
//  Created by Alper on 9.11.2018.
//  Copyright © 2018 Alper. All rights reserved.
//

import UIKit






class UserCell: UITableViewCell {

    
    @IBOutlet weak var avatarImage: CustomImage!
    @IBOutlet weak var fullnameLabel: UILabel!
    
  
    
    var indexPath: IndexPath!
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    
}
