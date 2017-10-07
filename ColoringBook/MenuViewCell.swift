//
//  MenuViewCell.swift
//  ColoringBook
//
//  Created by Admin on 2017-09-27.
//  Copyright © 2017 Odyssey. All rights reserved.
//

import UIKit

class MenuViewCell: UITableViewCell {
    
    @IBOutlet var icon: UIImageView!
    
    @IBOutlet var title: UILabel!
    
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        //hello
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
