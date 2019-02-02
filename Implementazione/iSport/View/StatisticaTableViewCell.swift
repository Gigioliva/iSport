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
            TipoStatistica.text = contenuto!.type
            ValoreTeam1.text = contenuto!.home
            ValoreTeam2.text = contenuto!.away
            ProgressBarHome.progress = 0.3
            ProgressBarAway.progress = 0.6
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
