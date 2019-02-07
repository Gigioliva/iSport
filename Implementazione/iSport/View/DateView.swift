//
//  DateView.swift
//  iSport
//
//  Created by Gianluigi Oliva on 07/02/2019.
//  Copyright © 2019 Gianluigi Oliva. All rights reserved.
//

import UIKit

class DateView: UIView {
    
    var Data: UIDatePicker!

    var dismissButton: UIBarButtonItem?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit(){

        Data = UIDatePicker()
        self.addSubview(Data)
        
        Data.translatesAutoresizingMaskIntoConstraints = false
        Data.topAnchor.constraint(equalTo: Data.superview!.topAnchor, constant: 0).isActive = true
        Data.bottomAnchor.constraint(equalTo: Data.superview!.bottomAnchor, constant: 0).isActive = true
        Data.leadingAnchor.constraint(equalTo: Data.superview!.leadingAnchor, constant: 0).isActive = true
        Data.trailingAnchor.constraint(equalTo: Data.superview!.trailingAnchor, constant: 0).isActive = true
        
        Data.backgroundColor = UIColor.white
        Data.datePickerMode = .date
        
        self.layer.cornerRadius = 3
        self.clipsToBounds = true
        
    }

}
