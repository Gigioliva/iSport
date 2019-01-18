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
    
    static var listaPartite = [Partita]()
    
    //AAAA-MM-GG
    static func RequestAPI(giorno: String,callback: @escaping ([Partita]) -> Void){
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

}


struct Partita: Decodable {
    let matchStatus: String?
    let matchTime: String?
    let matchHometeamName: String?
    let matchHometeamScore: String?
    let matchAwayteamName: String?
    let matchAwayteamScore: String?
    let goalscorer: [GoalList]
    let cards: [CardList]
    let statistics: [Statistic]
}

struct GoalList: Decodable {
    let time: String?
    let homeScorer: String?
    let score: String?
    let awayScorer: String?
}

struct CardList: Decodable {
    let time: String?
    let homeFault: String?
    let card: String?
    let awayFault: String?
}

struct Statistic: Decodable {
    let type: String?
    let home: String?
    let away: String?
}

