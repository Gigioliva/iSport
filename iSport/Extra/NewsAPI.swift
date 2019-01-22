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
    
    static func RequestAPI(callback: @escaping ([Article]) -> Void){
        let url = URL(string: urlNewsAPI)!
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
                    self.listaArticoli = try decoder.decode(Articoli.self, from: data).articles
                    callback(listaArticoli)
                }catch let errore{
                    print(errore)
                }
            }
            
        }.resume()
    }
    

}
