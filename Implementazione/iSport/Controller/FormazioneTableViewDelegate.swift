//
//  FormazioneTableViewDelegate.swift
//  iSport
//
//  Created by Gianluigi Oliva on 20/01/2019.
//  Copyright © 2019 Gianluigi Oliva. All rights reserved.
//

import UIKit

class FormazioneTableViewDelegate: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    var formazioneCasa = [Lineup]()
    var formazioneAway = [Lineup]()
    var sostituzioni = [SostituzioniSupporto]()
    var tableViewFormazione: UITableView
    var keysFormazione: [String] = []
    
    init(tableViewFormazione: UITableView, formazioneCasa: Campo, formazioneAway: Campo) {
        self.tableViewFormazione = tableViewFormazione
        
        self.formazioneCasa = formazioneCasa.startingLineups!
        self.formazioneAway = formazioneAway.startingLineups!
        
        for sostituzione in formazioneCasa.substitutions!{
            sostituzioni.append(SostituzioniSupporto(sostituzione: sostituzione, tipo: "Home"))
        }
        
        for sostituzione in formazioneAway.substitutions!{
            sostituzioni.append(SostituzioniSupporto(sostituzione: sostituzione, tipo: "Away"))
        }
        
        sostituzioni.sort { (sostituzione1, sostituzione2) in
            return sostituzione1.sostituzione.lineupTime! < sostituzione2.sostituzione.lineupTime!
        }
        
        
        keysFormazione = ["startingLineups", "substitutions"]
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return keysFormazione.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch keysFormazione[section] {
        case "startingLineups":
            return "Lineup"
        case "substitutions":
            return "Substitutions"
        default:
            return ""
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0{
            return max(formazioneCasa.count, formazioneAway.count)
        }
        if section == 1{
            return sostituzioni.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cella = tableViewFormazione.dequeueReusableCell(withIdentifier: "CellaFormazione") as! FormazioneTableViewCell

        if indexPath.section == 0{
            if indexPath.row < formazioneCasa.count{
                cella.NumeroGiocatoreCasa.text = formazioneCasa[indexPath.row].lineupNumber ?? ""
                cella.NomeGiocatoreCasa.text = formazioneCasa[indexPath.row].lineupPlayer ?? ""
                if indexPath.row == 0 {
                    cella.MagliaHome.image = UIImage(named: "dress-yellow")
                }
            }else{
                cella.NomeGiocatoreAway.text = ""
                cella.NumeroGiocatoreAway.text = ""
                cella.MagliaHome.isHidden = true
            }
            
            if indexPath.row < formazioneAway.count{
                cella.NomeGiocatoreAway.text = formazioneAway[indexPath.row].lineupPlayer ?? ""
                cella.NumeroGiocatoreAway.text = formazioneAway[indexPath.row].lineupNumber ?? ""
                if indexPath.row == 0 {
                    cella.MagliaAway.image = UIImage(named: "dress-yellow")
                }
            }else{
                cella.NomeGiocatoreAway.text = ""
                cella.NumeroGiocatoreAway.text = ""
                cella.MagliaAway.isHidden = true
            }
        }
        
        if indexPath.section == 1{
            let contenuto = sostituzioni[indexPath.row]
            cella.NomeGiocatoreAway.text = ""
            cella.NumeroGiocatoreAway.text = ""
            cella.NomeGiocatoreAway.text = ""
            cella.NumeroGiocatoreAway.text = ""
            cella.MagliaAway.isHidden = true
            cella.MagliaHome.isHidden = true
            if contenuto.tipo == "Home"{
                cella.NomeGiocatoreCasa.text = contenuto.sostituzione.lineupPlayer ?? ""
                cella.NumeroGiocatoreCasa.text = contenuto.sostituzione.lineupNumber ?? ""
                cella.MagliaHome.isHidden = false
            }
            if contenuto.tipo == "Away"{
                cella.NomeGiocatoreAway.text = contenuto.sostituzione.lineupPlayer ?? ""
                cella.NumeroGiocatoreAway.text = contenuto.sostituzione.lineupNumber ?? ""
                cella.MagliaAway.isHidden = false
            }
            
        }
        cella.selectionStyle = .none
        return cella
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    

}


struct SostituzioniSupporto {
    let sostituzione: Lineup
    let tipo: String
}
