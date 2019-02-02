//
//  RisultatiLiveViewController.swift
//  iSport
//
//  Created by Gianluigi Oliva on 13/01/2019.
//  Copyright © 2019 Gianluigi Oliva. All rights reserved.
//

import UIKit
import WebKit

class RisultatiLive: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var ListaRisultati: UITableView!
    
    var listaPartiteCampionato = Dictionary<String, [Partita]>()
    var listaCampionati = [String]()
    
    var indiceCellaSelezionata = (sezione: 0, riga: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ListaRisultati.delegate = self
        ListaRisultati.dataSource = self
        let giorno = "2019-01-12"
        
        RisultatiAPI.UpdateDatiPartite(giorno: giorno, callback: aggiornaTableView)
        
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return listaCampionati[section]
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return listaCampionati.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let nomeSezione = listaCampionati[section]
        
        return listaPartiteCampionato[nomeSezione]?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cella = ListaRisultati.dequeueReusableCell(withIdentifier: "ResultLive", for: indexPath) as! RisultatoTableViewCell
        
        let nomeSezione = listaCampionati[indexPath.section]
        let contenuto = listaPartiteCampionato[nomeSezione]!
        
        cella.partita = contenuto[indexPath.row]
        cella.selectionStyle = .none
        return cella
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        indiceCellaSelezionata.sezione = indexPath.section
        indiceCellaSelezionata.riga = indexPath.row
        performSegue(withIdentifier: "MostraStatistiche", sender: nil)
    }

    
    func aggiornaTableView(){
        
        let partite = RisultatiAPI.listaPartite
        
        let listaCampionati = partite.reduce(Set<String>(), { (acc, partitaAttuale) in
            return acc.union([partitaAttuale.leagueName!])
        })
        
        for campionato in listaCampionati{
            listaPartiteCampionato[campionato] = partite.filter({ (partita) in
                return partita.leagueName == campionato
            })
        }
        
        self.listaCampionati = Array(listaCampionati)
        
        for campionato in listaCampionati{
            self.listaPartiteCampionato[campionato]?.sort(by: { (orario1, orario2) -> Bool in
                return orario1.matchTime! < orario2.matchTime!
            })
        }
        
        self.listaCampionati.sort { (campionato1, campionato2) -> Bool in
            return campionato1 < campionato2
        }
        
//        self.listaOrari.sort { (orario1, orario2) in
//            return orario1 < orario2
//        }
 
        ListaRisultati.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MostraStatistiche"{
            let statisticaView = segue.destination as! StatisticaView
            let nomeSezione = listaCampionati[indiceCellaSelezionata.sezione]
            statisticaView.contenuto = listaPartiteCampionato[nomeSezione]![indiceCellaSelezionata.riga]
            
        }
    }
    
    @IBAction func ShowMenu(_ sender: Any) {
        sideMenuController?.revealMenu()
    }
    
}
