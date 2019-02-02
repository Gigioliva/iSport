//
//  Test.swift
//  iSport
//
//  Created by Gianluigi Oliva on 02/02/2019.
//  Copyright © 2019 Gianluigi Oliva. All rights reserved.
//

import UIKit
import GTProgressBar

class Test: UIViewController {

    @IBOutlet weak var progress: GTProgressBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        progress.displayLabel = false
        progress.progress = 0.4
        progress.direction = GTProgressBarDirection.anticlockwise
    }
    

}
