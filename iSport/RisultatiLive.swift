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
    
    func aggiornaTableView(partite: [Partita]){
        listaPartite = partite
        //ordinare sull'orario di inizio
        
        
        ListaRisultati.reloadData()
    }
    
 
}
