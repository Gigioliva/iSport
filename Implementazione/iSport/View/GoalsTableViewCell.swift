//
//  GoalsTableViewCell.swift
//  iSport
//
//  Created by Gianluigi Oliva on 21/01/2019.
//  Copyright © 2019 Gianluigi Oliva. All rights reserved.
//

import UIKit

class GoalsTableViewCell: UITableViewCell {

    @IBOutlet weak var ScoreGoal: UILabel!
    @IBOutlet weak var GiocatoreAway: UILabel!
    @IBOutlet weak var GiocatoreCasa: UILabel!
    @IBOutlet weak var BallAway: UIImageView!
    @IBOutlet weak var BallHome: UIImageView!
    @IBOutlet weak var MinutoGoalHome: UILabel!
    @IBOutlet weak var MinutoGoalAway: UILabel!
    
    var contenuto: GoalList? {
        didSet{
            ScoreGoal.text = contenuto!.score
            if contenuto?.homeScorer != "" {
                GiocatoreCasa.text = contenuto?.homeScorer
                MinutoGoalHome.text = contenuto?.time
                GiocatoreAway.text = ""
                MinutoGoalAway.text = ""
                BallAway.isHidden = true
            }
            if contenuto?.awayScorer != "" {
                GiocatoreAway.text = contenuto?.awayScorer
                MinutoGoalAway.text = contenuto?.time
                GiocatoreCasa.text = ""
                MinutoGoalHome.text = ""
                BallHome.isHidden = true
            }
        }
    }
    

}
