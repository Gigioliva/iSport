//
//  CardsTableViewDelegate.swift
//  iSport
//
//  Created by Gianluigi Oliva on 21/01/2019.
//  Copyright © 2019 Gianluigi Oliva. All rights reserved.
//

import UIKit

class CardsTableViewDelegate: NSObject, UITableViewDelegate, UITableViewDataSource {

    var tableViewCard: UITableView
    var listaCards: [CardList]
    
    init(tableView: UITableView, listaCard: [CardList]) {
        self.tableViewCard = tableView
        self.listaCards = listaCard
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listaCards.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cella = tableViewCard.dequeueReusableCell(withIdentifier: "CardsCell") as! CardsTableViewCell
        let cartellino = listaCards[indexPath.row]
        
        cella.MinutoFallo.text = cartellino.time
        cella.NomeGiocatoreCasa.text = cartellino.homeFault ?? ""
        cella.NomeGiocatoreAway.text = cartellino.awayFault ?? ""
        
        if cella.NomeGiocatoreCasa.text! == "" {
            cella.CardCasa.image = nil
        }
        if cella.NomeGiocatoreAway.text! == "" {
            cella.CardAway.image = nil
        }
        
        return cella
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    
}
