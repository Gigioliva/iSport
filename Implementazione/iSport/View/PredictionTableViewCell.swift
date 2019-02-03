//
//  PredictionTableViewCell.swift
//  iSport
//
//  Created by Gianluigi Oliva on 03/02/2019.
//  Copyright © 2019 Gianluigi Oliva. All rights reserved.
//

import UIKit
import UICircularProgressRing

class PredictionTableViewCell: UITableViewCell {

    @IBOutlet weak var PredictionHome: UICircularProgressRing!
    @IBOutlet weak var PredictionDraw: UICircularProgressRing!
    @IBOutlet weak var PredictionAway: UICircularProgressRing!

    var predizione: Prediction? {
        didSet{
            let probHW = Double(predizione!.probHw ?? "0") ?? 0
            let probD = Double(predizione!.probD ?? "0") ?? 0
            let probAW = Double(predizione!.probAw ?? "0") ?? 0
            PredictionHome.value = CGFloat(probHW)
            PredictionDraw.value = CGFloat(probD)
            PredictionAway.value = CGFloat(probAW)
        }
    }


}
