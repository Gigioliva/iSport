//
//  StatisticaView.swift
//  iSport
//
//  Created by Gianluigi Oliva on 19/01/2019.
//  Copyright © 2019 Gianluigi Oliva. All rights reserved.
//

import UIKit
import UICircularProgressRing

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
    
    @IBOutlet weak var RingHome: UICircularProgressRing!
    @IBOutlet weak var RingDraw: UICircularProgressRing!
    @IBOutlet weak var RingAway: UICircularProgressRing!
    
    
    var contenuto: Partita?
    var statisticaLista = [Statistic]()
    
    var statisticheDelegate: StatisticaViewTableData?
    var formazioneDelegate: FormazioneTableViewDelegate?
    var goalsDelegate: GoalsTableViewDelegate?
    var cardsDelegate: CardsTableViewDelegate?
    

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
        formazioneDelegate = FormazioneTableViewDelegate(tableViewFormazione: Dettagli, formazioneCasa: (contenuto?.lineup.home)!, formazioneAway: (contenuto?.lineup.away)!)
        goalsDelegate = GoalsTableViewDelegate(tableView: Dettagli, listaGoal: (contenuto?.goalscorer)!)
        cardsDelegate = CardsTableViewDelegate(tableView: Dettagli, listaCard: (contenuto?.cards)!)
        
        Dettagli.delegate = statisticheDelegate
        Dettagli.dataSource = statisticheDelegate
        
        let predizione = RisultatiAPI.GetPrediction(matchId: (contenuto?.matchId)!)!
        
        RingHome.value = CGFloat(Double(predizione.probHw!)!)
        RingDraw.value = CGFloat(Double(predizione.probD!)!)
        RingAway.value = CGFloat(Double(predizione.probAw!)!)
        
    }
    
    
    @IBAction func ShowStatistiche(_ sender: Any) {
        Dettagli.delegate=statisticheDelegate
        Dettagli.dataSource = statisticheDelegate
        Dettagli.reloadData()
    }
    
    @IBAction func ShowCards(_ sender: Any) {
        Dettagli.delegate = cardsDelegate
        Dettagli.dataSource = cardsDelegate
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

