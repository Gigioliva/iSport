//
//  FormazioneTableViewDelegate.swift
//  iSport
//
//  Created by Gianluigi Oliva on 20/01/2019.
//  Copyright © 2019 Gianluigi Oliva. All rights reserved.
//

import UIKit

class FormazioneTableViewDelegate: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    var formazioneCasa : [Lineup]
    var formazioneAway: [Lineup]
    var tableViewFormazione: UITableView
    
    init(tableViewFormazione: UITableView,formazioneCasa: [Lineup], formazioneAway: [Lineup]) {
        self.tableViewFormazione = tableViewFormazione
        self.formazioneCasa = formazioneCasa
        self.formazioneAway = formazioneAway
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return max(formazioneCasa.count, formazioneAway.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cella = tableViewFormazione.dequeueReusableCell(withIdentifier: "CellaFormazione") as! FormazioneTableViewCell
        
        if indexPath.row < formazioneCasa.count{
            cella.NumeroGiocatoreCasa.text = formazioneCasa[indexPath.row].lineupNumber ?? ""
            cella.NomeGiocatoreCasa.text = formazioneCasa[indexPath.row].lineupPlayer ?? ""
        }else{
            cella.NumeroGiocatoreCasa.text = ""
            cella.NomeGiocatoreCasa.text = ""
        }
        
        if indexPath.row < formazioneAway.count{
            cella.NomeGiocatoreAway.text = formazioneAway[indexPath.row].lineupPlayer ?? ""
            cella.NumeroGiocatoreAway.text = formazioneAway[indexPath.row].lineupNumber ?? ""
        }else{
            cella.NomeGiocatoreAway.text = ""
            cella.NumeroGiocatoreAway.text = ""
        }
        
        return cella
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    

}
