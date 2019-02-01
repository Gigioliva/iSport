//
//  APICoreData.swift
//  iSport
//
//  Created by Gianluigi Oliva on 23/01/2019.
//  Copyright © 2019 Gianluigi Oliva. All rights reserved.
//

import UIKit
import CoreData

class APICoreData: NSObject {
    
    static let appDelegate = UIApplication.shared.delegate as! AppDelegate
    static let contesto = appDelegate.persistentContainer.viewContext
    
    
    static func GetAllPartite() -> [PartitaCarrello]{
        var risultato = [PartitaCarrello]()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "PartitaCarrello")
        fetchRequest.returnsObjectsAsFaults = false
        do {
            let risultati = try contesto.fetch(fetchRequest)
            if risultati.count > 0 {
                risultato = risultati as! [PartitaCarrello]
            }
        } catch {
            print("Errore")
        }
        return risultato
    }
    
    static func DeletePartitaFromId(matchId: String) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "PartitaCarrello")
        fetchRequest.predicate = NSPredicate(format: "matchId= %@", matchId)
        fetchRequest.returnsObjectsAsFaults = false
        do {
            let risultati = try contesto.fetch(fetchRequest)
            if risultati.count > 0 {
                for result in risultati as! [PartitaCarrello] {
                    contesto.delete(result)
                }
            }
        } catch {
            print ("Errore")
        }
    }
    
    static func AddPartita(scommessa: OddsCompleta, quota: String, puntata: String) {
        if let scommessaPresente = GetPartitaById(matchId: scommessa.matchId!){
            scommessaPresente.quota = quota
            scommessaPresente.puntata = puntata
        } else {
            let query = NSEntityDescription.insertNewObject(forEntityName: "PartitaCarrello", into: contesto)
            query.setValue(scommessa.matchAwayteamName, forKey: "awayName")
            query.setValue(scommessa.matchHometeamName, forKey: "homeName")
            query.setValue(scommessa.matchId, forKey: "matchId")
            query.setValue(puntata, forKey: "puntata")
            query.setValue(quota, forKey: "quota")
        }
        do {
            try contesto.save()
            print ("dati salvati correttamente")
        } catch {
            print ("Errore")
        }
        
    }
    
    static func GetPartitaById(matchId: String) -> PartitaCarrello?{
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "PartitaCarrello")
        fetchRequest.predicate = NSPredicate(format: "matchId= %@", matchId)
        fetchRequest.returnsObjectsAsFaults = false
        do {
            let risultati = try contesto.fetch(fetchRequest)
            if risultati.count > 0 {
                for result in risultati as! [PartitaCarrello] {
                    return result
                }
            }
        } catch {
            print ("Errore")
        }
        return nil
    }
    
    

}
