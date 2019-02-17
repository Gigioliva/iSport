//
//  NewsAPI.swift
//  iSport
//
//  Created by Gianluigi Oliva on 13/01/2019.
//  Copyright © 2019 Gianluigi Oliva. All rights reserved.
//

import UIKit

class NewsAPI: NSObject {
    
    static let urlNewsAPI = "https://newsapi.org/v2/top-headlines?country=it&category=sports&apiKey=934c6661b09f427bbd2c3a27cb1f65dd"
    
    static var listaArticoli = [Article]()
    
    static func RequestAPI(callback: @escaping () -> Void){
        let url = URL(string: urlNewsAPI)!
        let temp = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10)
        URLSession.shared.dataTask(with: temp){ (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data , error == nil else {
                    print (error!)
                    errorAPI(callback: callback)
                    return
                }
                if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                    print("statusCode should be 200, but is \(httpStatus.statusCode)")
                    print(response!)
                    errorAPI(callback: callback)
                }
                
                do{
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    self.listaArticoli = try decoder.decode(Articoli.self, from: data).articles
                    callback()
                }catch let errore{
                    errorAPI(callback: callback)
                    print(errore)
                }
            }
            
        }.resume()
    }
    
    static func errorAPI(callback: @escaping () -> Void){
        self.listaArticoli = loadJson()
        callback()
    }
    
    static func loadJson() -> [Article] {
        if let url = Bundle.main.url(forResource: "news", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let risultato = try decoder.decode(Articoli.self, from: data).articles
                return risultato
            } catch {
                print("error:\(error)")
            }
        }
        return [Article]()
    }

}
