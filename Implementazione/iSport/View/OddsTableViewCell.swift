//
//  OddsTableViewCell.swift
//  iSport
//
//  Created by Gianluigi Oliva on 23/01/2019.
//  Copyright © 2019 Gianluigi Oliva. All rights reserved.
//

import UIKit
import CoreData

class OddsTableViewCell: UITableViewCell {

    @IBOutlet weak var DataOra: UILabel!
    @IBOutlet weak var Squadre: UILabel!
    
    @IBOutlet weak var Bottone1: BottoneScommessa!
    @IBOutlet weak var BottoneX: BottoneScommessa!
    @IBOutlet weak var Bottone2: BottoneScommessa!
    
    var scommessa : OddsCompleta? {
        
        didSet{
            DataOra.text = scommessa!.matchData! + " - " + scommessa!.matchTime!
            Squadre.text = scommessa!.matchHometeamName! + " - " + scommessa!.matchAwayteamName!
            Bottone1.quotaLabel.text = scommessa!.odd1
            Bottone2.quotaLabel.text = scommessa!.odd2
            BottoneX.quotaLabel.text = scommessa!.oddX
            Bottone1.bottoneScommessa.setTitle("1", for: .normal)
            Bottone2.bottoneScommessa.setTitle("2", for: .normal)
            BottoneX.bottoneScommessa.setTitle("X", for: .normal)
        }
    }

    
    func commonInit(){
        Bottone1.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(aggiungiAlCarrello(_:))))
        BottoneX.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(aggiungiAlCarrello(_:))))
        Bottone2.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(aggiungiAlCarrello(_:))))
        
        AggiornaPulsanti()
        
    }
    
    func AggiornaPulsanti() {
        if let puntata = APICoreData.GetPartitaById(matchId: (scommessa?.matchId)!){
            Bottone1.premuto = puntata.puntata == Bottone1.bottoneScommessa.titleLabel!.text
            Bottone2.premuto = puntata.puntata == Bottone2.bottoneScommessa.titleLabel!.text
            BottoneX.premuto = puntata.puntata == BottoneX.bottoneScommessa.titleLabel!.text
        } else {
            Bottone1.premuto = false
            Bottone2.premuto = false
            BottoneX.premuto = false
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        commonInit()
    }
    
    @objc func aggiungiAlCarrello(_ sender: UITapGestureRecognizer){
        let bottonePremuto = sender.view as! BottoneScommessa
        APICoreData.AddPartita(scommessa: scommessa!, quota: bottonePremuto.quotaLabel.text!, puntata: (bottonePremuto.bottoneScommessa.titleLabel?.text)!)
        AggiornaPulsanti()
    }
    
    
}
