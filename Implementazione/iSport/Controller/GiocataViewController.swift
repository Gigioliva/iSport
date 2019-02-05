//
//  GiocataViewController.swift
//  iSport
//
//  Created by Gianluigi Oliva on 05/02/2019.
//  Copyright © 2019 Gianluigi Oliva. All rights reserved.
//

import UIKit

class GiocataViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var Ticket: UITableView!
    @IBOutlet weak var Puntata: UILabel!
    @IBOutlet weak var PotenzialeVincita: UILabel!
    
    var biglietto: Ticket?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Puntata.text = biglietto?.importo
        PotenzialeVincita.text = biglietto?.vincita
        Ticket.delegate = self
        Ticket.dataSource = self
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return biglietto?.ticket.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cella = Ticket.dequeueReusableCell(withIdentifier: "CarrelloCell", for: indexPath) as! CarrelloTableViewCell
        if let evento = biglietto?.ticket[indexPath.row]{
            cella.Squadre.text = evento.homeNmae + " - " + evento.awayName
            cella.Puntata.bottoneScommessa.text = evento.puntata
            cella.Puntata.quotaLabel.text = evento.quota
            cella.ViewContainer.layer.cornerRadius = 3
        }
        cella.selectionStyle = .none
        return cella
    }

}
