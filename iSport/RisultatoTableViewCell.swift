//
//  RisultatoTableViewCell.swift
//  iSport
//
//  Created by Gianluigi Oliva on 15/01/2019.
//  Copyright © 2019 Gianluigi Oliva. All rights reserved.
//

import UIKit

class RisultatoTableViewCell: UITableViewCell {

    
    @IBOutlet weak var Team1: UILabel!
    @IBOutlet weak var ScoreTeam1: UILabel!
    @IBOutlet weak var ScoreTeam2: UILabel!
    @IBOutlet weak var Team2: UILabel!
    @IBOutlet weak var StartGame: UILabel!
    @IBOutlet weak var ScoreHalfTime: UILabel!
    @IBOutlet weak var Time: UILabel!
    
    var partita: Partita?{
        
        didSet{
            Team1.text = partita!.matchHometeamName ?? "Team1"
            Team2.text = partita!.matchAwayteamName ?? "Team2"
            ScoreTeam1.text = partita!.matchHometeamScore ?? " "
            ScoreTeam2.text = partita!.matchAwayteamScore ?? " "
            StartGame.text = partita!.matchTime ?? ""
            Time.text = partita!.matchStatus ?? ""
            
            let homePrimoTempo = partita!.matchHometeamHalftimeScore ?? ""
            let awayPrimoTempo = partita!.matchAwayteamHalftimeScore ?? ""
            ScoreHalfTime.text = String("HT " + homePrimoTempo + "-" + awayPrimoTempo)
            
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
