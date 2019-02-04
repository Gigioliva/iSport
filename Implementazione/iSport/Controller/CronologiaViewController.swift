//
//  CronologiaViewController.swift
//  iSport
//
//  Created by Gianluigi Oliva on 04/02/2019.
//  Copyright © 2019 Gianluigi Oliva. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class CronologiaViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    

    @IBOutlet weak var TableCronologia: UITableView!
    var listaSchedine: [String: [String: String]] = [:]
    var listaId = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TableCronologia.delegate = self
        TableCronologia.dataSource = self
        TableCronologia.rowHeight = 70
        
        if let user = Auth.auth().currentUser {
            let database = Database.database().reference()
            database.child("Schedina").child(user.uid).observeSingleEvent(of: .value) { (snapshot) in
                if let schedine = snapshot.value as? [String: [String: String]]{
                    self.listaSchedine = schedine
                    self.listaId = Array(schedine.keys)
                    self.TableCronologia.reloadData()
                } else {
                    print("conversione errata")
                }
            }

        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listaId.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cella = TableCronologia.dequeueReusableCell(withIdentifier: "TicketCell", for: indexPath) as! TicketTableViewCell
        let ticketId = listaId[indexPath.row]
        let scommessaCella = listaSchedine[ticketId]!
        let decoder = JSONDecoder()
        let scommesse: [Scommessa]
        do{
            let data = scommessaCella["ticket"]!.data(using: .utf8)!
            try scommesse = decoder.decode([Scommessa].self, from: data)
            let ticket = Ticket(ticket: scommesse, importo: scommessaCella["importo"]!, vincita: scommessaCella["vincita"]!)
            cella.ticketIdFirebase.text = ticketId
            cella.importoGiocato.text = ticket.importo
            cella.potenzialeVincita.text = ticket.vincita
        }catch {
            print("errore")
        }
        cella.selectionStyle = .none
        return cella
    }


}
