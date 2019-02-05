//
//  OddsViewController.swift
//  iSport
//
//  Created by Gianluigi Oliva on 23/01/2019.
//  Copyright © 2019 Gianluigi Oliva. All rights reserved.
//

import UIKit
import FirebaseAuth

class OddsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableViewOdds: UITableView!
    var listaScommesse = Dictionary<String, [OddsCompleta]>()
    var listaCampionati = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableViewOdds.delegate = self
        tableViewOdds.dataSource = self
        
        tableViewOdds.estimatedRowHeight = 100
//        tableViewOdds.rowHeight = UITableView.automaticDimension
        
        let giorno = "2019-01-12"
        RisultatiAPI.UpdateDatiPartite(giorno: giorno, callback: aggiornaTabella)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return listaCampionati.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return listaCampionati[section]
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let scommesseCampionato = listaScommesse[listaCampionati[section]]!
        return scommesseCampionato.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableViewOdds.dequeueReusableCell(withIdentifier: "OddsCell", for: indexPath) as! OddsTableViewCell
        let scommesseCampionato = listaScommesse[listaCampionati[indexPath.section]]!
        let scommessa = scommesseCampionato[indexPath.row]
        cell.scommessa = scommessa
        cell.selectionStyle = .none
        cell.ViewContainer.layer.cornerRadius = 3
        return cell
    }
    
    func aggiornaTabella() {
        let listaOdds = RisultatiAPI.listaOdds
        
        var listaScommesse = [OddsCompleta]()
        for scommessa in listaOdds{
            let infoPartita = RisultatiAPI.GetPartita(matchId: scommessa.matchId!)
            let scommessaCompleta = OddsCompleta(leagueName: infoPartita?.leagueName,matchHometeamName: infoPartita?.matchHometeamName, matchAwayteamName: infoPartita?.matchAwayteamName, matchTime: infoPartita?.matchTime, matchData: infoPartita?.matchDate, matchId: scommessa.matchId, odd1: scommessa.odd1, oddX: scommessa.oddX, odd2: scommessa.odd2)
            listaScommesse.append(scommessaCompleta)
        }
        
        let campionati = listaScommesse.reduce(Set<String>(), { (acc, scommessaAttuale) in
            return acc.union([scommessaAttuale.leagueName])
        })
        
        for campioanto in campionati{
            self.listaScommesse[campioanto!] = listaScommesse.filter({ (partita) in
                return partita.leagueName == campioanto
            })
        }
        
        for campioanto in campionati{
            self.listaScommesse[campioanto!]?.sort(by: { (scommessa1, scommessa2) -> Bool in
                return scommessa1.matchTime! < scommessa2.matchTime!
            })
        }
        
        self.listaCampionati = Array(self.listaScommesse.keys)
        
        self.listaCampionati.sort { (campionato1, campionato2) -> Bool in
            return campionato1 < campionato2
        }
        
        tableViewOdds.reloadData()
        
        
    }

    @IBAction func VisualizzaCarrello(_ sender: Any) {
        performSegue(withIdentifier: "CarrelloView", sender: nil)
    }
    
    @IBAction func ShowCronologia(_ sender: Any) {
        if Auth.auth().currentUser != nil {
            performSegue(withIdentifier: "CronologiaBuy", sender: nil)
        } else {
            ApriAlert(title: "Not Logged In", message: "Please login to continue.")
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableViewOdds.reloadData()
    }
    
    @IBAction func ShowMenu(_ sender: Any) {
        sideMenuController?.revealMenu()
    }
    
    func ApriAlert (title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let OK = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
        alert.addAction(OK)
        self.present(alert, animated: true, completion: nil)
    }
}
