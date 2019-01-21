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
    
    var listaPartiteOra = Dictionary<String, [Partita]>()
    var listaOrari = [String]()
    
    var indiceCellaSelezionata = (sezione: 0, riga: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ListaRisultati.delegate = self
        ListaRisultati.dataSource = self
        RisultatiAPI.RequestAPI(giorno: "2019-01-12", callback: aggiornaTableView)
        
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return listaOrari[section]
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return listaOrari.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let nomeSezione = listaOrari[section]
        
        return listaPartiteOra[nomeSezione]?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cella = ListaRisultati.dequeueReusableCell(withIdentifier: "ResultLive", for: indexPath) as! RisultatoTableViewCell
        
        let nomeSezione = listaOrari[indexPath.section]
        let contenuto = listaPartiteOra[nomeSezione]!
        
        cella.partita = contenuto[indexPath.row]
        
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
    
    
    func aggiornaTableView(partite: [Partita]){
        
        let listaOrari = partite.reduce(Set<String>(), { (acc, partitaAttuale) in
            return acc.union([partitaAttuale.matchTime!])
        })
        
        for orario in listaOrari{
            listaPartiteOra[orario] = partite.filter({ (partita) in
                return partita.matchTime == orario
            })
        }
        
        self.listaOrari = Array(listaOrari)
        self.listaOrari.sort { (orario1, orario2) in
            return orario1 < orario2
        }
 
        ListaRisultati.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MostraStatistiche"{
            let statisticaView = segue.destination as! StatisticaView
            let nomeSezione = listaOrari[indiceCellaSelezionata.sezione]
            
            statisticaView.contenuto = listaPartiteOra[nomeSezione]![indiceCellaSelezionata.riga]
            
        }
    }
    
 
}
