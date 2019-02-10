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
    
    
    
    static func UpdateDatiPartite(giorno: String, callback: @escaping () -> Void){
        RequestAPI(giorno: giorno, callback: callback)
        
    }
    
    
    
    //AAAA-MM-GG
    private static func RequestAPI(giorno: String, callback: @escaping () -> Void){
        let stringURL = String(urlRisultatiAPI + "&from=" + giorno + "&to=" + giorno + "&APIkey=" + risultatiKey)
        let url = URL(string: stringURL)!
        let temp = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10)
        URLSession.shared.dataTask(with: temp){ (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data , error == nil else {
                    errorAPI(callback: callback)
                    return
                }
                if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                    print("statusCode should be 200, but is \(httpStatus.statusCode)")
                    errorAPI(callback: callback)
                }
                
                do{
                    print("temp")
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    self.listaPartite = try decoder.decode([Partita].self, from: data)
                    PredictionAPI(giorno: giorno, callback: callback)
                }catch let errore{
                    errorAPI(callback: callback)
                    print(errore)
                }
            }
            
            }.resume()
    }
    
    private static func PredictionAPI(giorno: String, callback: @escaping () -> Void){
        print("call")
        let stringURL = String(urlPredizioniAPI + "&from=" + giorno + "&to=" + giorno + "&APIkey=" + risultatiKey)
        let url = URL(string: stringURL)!
        let temp = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10)
        URLSession.shared.dataTask(with: temp){ (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data , error == nil else {
                    errorAPI(callback: callback)
                    return
                }
                if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                    print("statusCode should be 200, but is \(httpStatus.statusCode)")
                    errorAPI(callback: callback)
                }
                
                do{
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    self.listaPredizioni = try decoder.decode([Prediction].self, from: data)
                    OddsAPI(giorno: giorno, callback: callback)
                }catch let errore{
                    errorAPI(callback: callback)
                    print(errore)
                }
            }
            
            }.resume()
    }
    
    private static func OddsAPI(giorno: String, callback: @escaping () -> Void){
        let stringURL = String(urlOddsAPI + "&from=" + giorno + "&to=" + giorno + "&APIkey=" + risultatiKey)
        let url = URL(string: stringURL)!
        let temp = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10)
        URLSession.shared.dataTask(with: temp){ (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data , error == nil else {
                    errorAPI(callback: callback)
                    return
                }
                if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                    print("statusCode should be 200, but is \(httpStatus.statusCode)")
                    errorAPI(callback: callback)
                }
                
                do{
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let listaTemporanea = try decoder.decode([Odds].self, from: data)
                    self.listaOdds = filtraOdds(scommesse: listaTemporanea)
                    callback()
                }catch let errore{
                    errorAPI(callback: callback)
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
    
    static func errorAPI(callback: @escaping () -> Void){
        listaPartite = loadJson(filename: "live")
        listaPredizioni = loadJson(filename: "prediction")
        listaOdds = loadJson(filename: "odds")
        callback()
    }
    
    static func loadJson<T: Decodable>(filename: String) -> [T] {
        if let url = Bundle.main.url(forResource: filename, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let risultato = try decoder.decode([T].self, from: data)
                return risultato
            } catch {
                print("error:\(error)")
            }
        }
        return [T]()
    }
    
}
