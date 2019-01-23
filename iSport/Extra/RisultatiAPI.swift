//
//  RisultatiAPI.swift
//  iSport
//
//  Created by Gianluigi Oliva on 15/01/2019.
//  Copyright © 2019 Gianluigi Oliva. All rights reserved.
//

import UIKit

class RisultatiAPI: NSObject {
    
    static let risultatiKey = "a18e74f2068e82f420233df2be5c306daed0fb3a49a62595be3f8e7477d1d28f"
    static let urlRisultatiAPI = "https://apifootball.com/api/?action=get_events"
    static let urlOddsAPI = "https://apifootball.com/api/?action=get_odds"
    static let urlPredizioniAPI = "https://apifootball.com/api/?action=get_predictions"
    
    static var listaPartite = [Partita]()
    static var listaPredizioni = [Prediction]()
    static var listaOdds = [Odds]()
    
    //AAAA-MM-GG
    static func RequestAPI(giorno: String, callback: @escaping ([Partita]) -> Void){
        let stringURL = String(urlRisultatiAPI + "&from=" + giorno + "&to=" + giorno + "&APIkey=" + risultatiKey)
        let url = URL(string: stringURL)!
        URLSession.shared.dataTask(with: url){ (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data , error == nil else {
                    print (error!)
                    return
                }
                if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                    print("statusCode should be 200, but is \(httpStatus.statusCode)")
                    print(response!)
                }
                
                do{
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    self.listaPartite = try decoder.decode([Partita].self, from: data)
                    callback(listaPartite)
                }catch let errore{
                    print(errore)
                }
            }
            
            }.resume()
    }
    
    static func PredictionAPI(giorno: String){
        let stringURL = String(urlPredizioniAPI + "&from=" + giorno + "&to=" + giorno + "&APIkey=" + risultatiKey)
        let url = URL(string: stringURL)!
        URLSession.shared.dataTask(with: url){ (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data , error == nil else {
                    print (error!)
                    return
                }
                if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                    print("statusCode should be 200, but is \(httpStatus.statusCode)")
                    print(response!)
                }
                
                do{
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    self.listaPredizioni = try decoder.decode([Prediction].self, from: data)
                }catch let errore{
                    print(errore)
                }
            }
            
            }.resume()
    }
    
    static func OddsAPI(giorno: String, callback: @escaping ([Odds]) -> Void){
        let stringURL = String(urlOddsAPI + "&from=" + giorno + "&to=" + giorno + "&APIkey=" + risultatiKey)
        let url = URL(string: stringURL)!
        URLSession.shared.dataTask(with: url){ (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data , error == nil else {
                    print (error!)
                    return
                }
                if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                    print("statusCode should be 200, but is \(httpStatus.statusCode)")
                    print(response!)
                }
                
                do{
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let listaTemporanea = try decoder.decode([Odds].self, from: data)
                    self.listaOdds = filtraOdds(scommesse: listaTemporanea)
                    callback(self.listaOdds)
                }catch let errore{
                    print(errore)
                }
            }
            
            }.resume()
    }
    
    static func GetPrediction(matchId: String) -> Prediction? {
        let predizione = listaPredizioni.filter { (prediction) in
            return prediction.matchId == matchId
        }
        return predizione.count > 0 ? predizione[0] : nil
    }
    
    static func GetOdds(matchId: String) -> Odds? {
        let scommessa = listaOdds.filter { (odd) in
            return odd.matchId == matchId
        }
        return scommessa.count > 0 ? scommessa[0] : nil
    }
    
    static func GetPartita(matchId: String) -> Partita? {
        let partita = listaPartite.filter { (partita) in
            return partita.matchId == matchId
        }
        return partita.count > 0 ? partita[0] : nil
    }
    
    
    static func filtraOdds(scommesse: [Odds]) -> [Odds]{
        var risultato = [Odds]()
        let listaMatchId = scommesse.reduce(Set<String>(), { (acc, scommessaAttuale) in
            return acc.union([scommessaAttuale.matchId!])
        })
        
        for matchId in listaMatchId{
            let temp = scommesse.filter({ (odds) in
                return odds.matchId == matchId
            })
            risultato.append(temp[0])
        }
        
        return risultato
        
    }
    

}
