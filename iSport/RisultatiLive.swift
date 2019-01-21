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
    
    var listaPartite = [Partita]()
    
    var indiceCellaSelezionata: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ListaRisultati.delegate = self
        ListaRisultati.dataSource = self
        RisultatiAPI.RequestAPI(giorno: "2019-01-12", callback: aggiornaTableView)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listaPartite.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cella = ListaRisultati.dequeueReusableCell(withIdentifier: "ResultLive") as! RisultatoTableViewCell
        cella.partita = listaPartite[indexPath.row]
        
        return cella
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        indiceCellaSelezionata = indexPath.row
        performSegue(withIdentifier: "MostraStatistiche", sender: nil)
    }
    
    
    func aggiornaTableView(partite: [Partita]){
        listaPartite = partite
        
        listaPartite.sort(by: { (parita1, partita2) -> Bool in
            return parita1.matchTime! < partita2.matchTime!
            })
        
        
        ListaRisultati.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MostraStatistiche"{
            let statisticaView = segue.destination as! StatisticaView
            statisticaView.contenuto = listaPartite[indiceCellaSelezionata]
            
        }
    }
    
 
}
