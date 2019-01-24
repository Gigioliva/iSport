//
//  LabelNews.swift
//  iSport
//
//  Created by Gianluigi Oliva on 13/01/2019.
//  Copyright © 2019 Gianluigi Oliva. All rights reserved.
//

import UIKit

class LabelNews: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        layer.borderWidth = 0.5
        layer.cornerRadius = 4
        backgroundColor = UIColor.rgb(red: 21, green: 29, blue: 75)
        layer.borderColor! = UIColor.rgb(red: 106, green: 109, blue: 138).cgColor
        layer.masksToBounds = true
        sizeToFit()
        clipsToBounds = true
        adjustsFontSizeToFitWidth = true
        textAlignment = NSTextAlignment.center
        font = UIFont.init(name: "Arial", size: 20)
        font = UIFont.boldSystemFont(ofSize: 20)
        textColor = UIColor.white
        text = text?.uppercased()
        
    }

    let padding = UIEdgeInsets(top: 0, left: 8, bottom: 2, right: 8)
    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: padding))
    }
    
    
}
