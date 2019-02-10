//
//  StatisticaTableViewCell.swift
//  iSport
//
//  Created by Gianluigi Oliva on 19/01/2019.
//  Copyright © 2019 Gianluigi Oliva. All rights reserved.
//

import UIKit
import GTProgressBar

class StatisticaTableViewCell: UITableViewCell {

    @IBOutlet weak var TipoStatistica: UILabel!
    @IBOutlet weak var ValoreTeam1: UILabel!
    @IBOutlet weak var ValoreTeam2: UILabel!
    
    @IBOutlet weak var ProgressBarHome: GTProgressBar!
    @IBOutlet weak var ProgressBarAway: GTProgressBar!
    
    var contenuto: Statistic? {
        
        didSet{
            TipoStatistica.text = contenuto!.type?.uppercased()
            ValoreTeam1.text = contenuto!.home
            ValoreTeam2.text = contenuto!.away
            let valoreHome = Float(contenuto?.home ?? "0") ?? 0
            let valoreAway = Float(contenuto?.away ?? "0") ?? 0
            ProgressBarHome.progress = CGFloat(valoreHome / (valoreHome + valoreAway))
            ProgressBarAway.progress = CGFloat(valoreAway / (valoreHome + valoreAway))
            
            if ProgressBarHome.progress > 0.5 {
                ProgressBarHome.barFillColor = UIColor.rgb(red: 0, green: 150, blue: 0)
                ProgressBarAway.barFillColor = UIColor.red
            }else if ProgressBarHome.progress == 0.5{
                ProgressBarHome.barFillColor = UIColor.rgb(red: 0, green: 150, blue: 0)
                ProgressBarAway.barFillColor = UIColor.rgb(red: 0, green: 150, blue: 0)
            }else {
                ProgressBarHome.barFillColor = UIColor.red
                ProgressBarAway.barFillColor = UIColor.rgb(red: 0, green: 150, blue: 0)
            }
            
        }
    }

}
