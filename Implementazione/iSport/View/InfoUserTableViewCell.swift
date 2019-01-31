//
//  InfoUserTableViewCell.swift
//  iSport
//
//  Created by Gianluigi Oliva on 31/01/2019.
//  Copyright © 2019 Gianluigi Oliva. All rights reserved.
//

import UIKit

class InfoUserTableViewCell: UITableViewCell {

    @IBOutlet weak var profilImage: CustomImageView!
    @IBOutlet weak var nameUser: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        commonInit()
    }
    
    func commonInit(){
        profilImage.layer.borderWidth = 1
        profilImage.layer.masksToBounds = false
        profilImage.layer.borderColor = UIColor.black.cgColor
        profilImage.layer.cornerRadius = profilImage.frame.size.width/2
        profilImage.clipsToBounds = true
    }
    
    
}
