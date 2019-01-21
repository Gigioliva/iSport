//
//  StatisticaView.swift
//  iSport
//
//  Created by Gianluigi Oliva on 19/01/2019.
//  Copyright © 2019 Gianluigi Oliva. All rights reserved.
//

import UIKit

class StatisticaView: UIViewController {

    @IBOutlet weak var Campionato: UILabel!
    @IBOutlet weak var OrarioInizio: UILabel!
    @IBOutlet weak var Team1Name: UILabel!
    @IBOutlet weak var Team2Name: UILabel!
    @IBOutlet weak var Team1Score: UILabel!
    @IBOutlet weak var Team2Score: UILabel!
    @IBOutlet weak var MatchStatus: UILabel!
    @IBOutlet weak var HalfTimeScore: UILabel!
    
    @IBOutlet weak var Dettagli: UITableView!
    
    
    
    var contenuto: Partita?
    var statisticaLista = [Statistic]()
    
    var statisticheDelegate: StatisticaViewTableData?
    var formazioneDelegate: FormazioneTableViewDelegate?
    var goalsDelegate: GoalsTableViewDelegate?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        Campionato.text = contenuto!.leagueName ?? Campionato.text
        OrarioInizio.text = contenuto!.matchTime ?? OrarioInizio.text
        Team1Name.text = contenuto!.matchHometeamName ?? Team1Name.text
        Team2Name.text = contenuto!.matchAwayteamName ?? Team2Name.text
        Team1Score.text = contenuto!.matchHometeamScore ?? Team1Score.text
        Team2Score.text = contenuto!.matchAwayteamScore ?? Team2Score.text
        MatchStatus.text = contenuto!.matchStatus ?? MatchStatus.text
        
        let homePrimoTempo = contenuto!.matchHometeamHalftimeScore ?? "0"
        let awayPrimoTempo = contenuto!.matchAwayteamHalftimeScore ?? "0"
        HalfTimeScore.text = String("HT " + homePrimoTempo + "-" + awayPrimoTempo)
        statisticaLista = contenuto!.statistics
        
        statisticheDelegate = StatisticaViewTableData(tableView: Dettagli, statistiche: statisticaLista)
        formazioneDelegate = FormazioneTableViewDelegate(tableViewFormazione: Dettagli, formazioneCasa: (contenuto?.lineup.home?.startingLineups)!, formazioneAway: (contenuto?.lineup.away?.startingLineups)!)
        goalsDelegate = GoalsTableViewDelegate(tableView: Dettagli, listaGoal: (contenuto?.goalscorer)!)
        
        Dettagli.delegate=statisticheDelegate
        Dettagli.dataSource = statisticheDelegate
        
    }
    
    
    @IBAction func ShowStatistiche(_ sender: Any) {
        Dettagli.delegate=statisticheDelegate
        Dettagli.dataSource = statisticheDelegate
        Dettagli.reloadData()
    }
    
    
    @IBAction func ShowFormazione(_ sender: Any) {
        Dettagli.delegate=formazioneDelegate
        Dettagli.dataSource = formazioneDelegate
        Dettagli.reloadData()
    }
    
    @IBAction func ShowGoal(_ sender: Any) {
        Dettagli.delegate=goalsDelegate
        Dettagli.dataSource = goalsDelegate
        Dettagli.reloadData()
    }
    

}

