//
//  LoginTableViewCell.swift
//  iSport
//
//  Created by Gianluigi Oliva on 01/02/2019.
//  Copyright © 2019 Gianluigi Oliva. All rights reserved.
//

import UIKit

class LoginTableViewCell: UITableViewCell {

    
    @IBOutlet weak var labelLog: UILabel!
    @IBOutlet weak var imageLog: UIImageView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
