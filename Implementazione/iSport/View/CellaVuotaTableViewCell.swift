//
//  CellaVuotaTableViewCell.swift
//  iSport
//
//  Created by Gianluigi Oliva on 07/02/2019.
//  Copyright © 2019 Gianluigi Oliva. All rights reserved.
//

import UIKit

class CellaVuotaTableViewCell: UITableViewCell {
    
    var label: UILabel?
    
    var testo: String?{
        didSet{
            label!.text = testo
            label!.sizeToFit()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit(){
        label = UILabel()
        label!.text = ""
        label!.textColor = UIColor.lightGray
        contentView.addSubview(label!)
        label!.sizeToFit()
        label!.translatesAutoresizingMaskIntoConstraints = false
        label!.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        label!.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        selectionStyle = .none
        label?.backgroundColor = UIColor.clear
        contentView.backgroundColor = UIColor.clear
        self.backgroundColor = UIColor.clear
    }

}
