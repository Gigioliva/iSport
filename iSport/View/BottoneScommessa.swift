//
//  BottoneScommessa.swift
//  iSport
//
//  Created by Gianluigi Oliva on 23/01/2019.
//  Copyright © 2019 Gianluigi Oliva. All rights reserved.
//

import UIKit

class BottoneScommessa: UIView {

    let bottoneScommessa = UIButton()
    let quotaLabel = UILabel()
    
    var premuto: Bool = false {
        
        didSet{
            if premuto {
                bottoneScommessa.backgroundColor = UIColor.orange
            } else {
                bottoneScommessa.backgroundColor = UIColor.rgb(red: 55, green: 65, blue: 74)
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit(){
        self.addSubview(bottoneScommessa)
        self.addSubview(quotaLabel)
        
        bottoneScommessa.setTitle("1", for: .normal)
        quotaLabel.text = "1.25"
        bottoneScommessa.backgroundColor = UIColor.rgb(red: 55, green: 65, blue: 74)
        bottoneScommessa.titleLabel?.textColor = UIColor.white
        quotaLabel.textAlignment = .center
        bottoneScommessa.titleLabel?.textAlignment = .center
        
        self.translatesAutoresizingMaskIntoConstraints = false
        bottoneScommessa.translatesAutoresizingMaskIntoConstraints = false
        quotaLabel.translatesAutoresizingMaskIntoConstraints = false
        addConstraint(NSLayoutConstraint(item: bottoneScommessa, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 0, constant: 40))
        addConstraint(NSLayoutConstraint(item: bottoneScommessa, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 0, constant: 40))
        addConstraint(NSLayoutConstraint(item: bottoneScommessa, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: bottoneScommessa, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: bottoneScommessa, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading
            , multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: bottoneScommessa, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: quotaLabel, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: quotaLabel, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: quotaLabel, attribute: .leading, relatedBy: .equal, toItem: bottoneScommessa, attribute: .trailing, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: quotaLabel, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: quotaLabel, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: 0))
        
    }

}
