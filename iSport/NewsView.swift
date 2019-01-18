//
//  ViewController.swift
//  iSport
//
//  Created by Gianluigi Oliva on 13/01/2019.
//  Copyright © 2019 Gianluigi Oliva. All rights reserved.
//

import UIKit
import WebKit

class NewsView: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var ListaNews: UITableView!
    
    var listaArticoli = [Article]()
    
    var webFrame: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.rgb(red: 226, green: 227, blue: 228)
        ListaNews.delegate = self
        ListaNews.dataSource = self
        ListaNews.backgroundColor = UIColor.rgb(red: 226, green: 227, blue: 228)
        ListaNews.estimatedRowHeight = UITableView.automaticDimension
        ListaNews.rowHeight = UITableView.automaticDimension
        NewsAPI.RequestAPI(callback: aggiornaTableView)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listaArticoli.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cella = ListaNews.dequeueReusableCell(withIdentifier: "CellNews") as! CellNews
        cella.Anteprima.text = listaArticoli[indexPath.row].title
        cella.TipoSport.text = getDate(dataStringa: listaArticoli[indexPath.row].publishedAt!)
        cella.urlImmagine = listaArticoli[indexPath.row].urlToImage
        return cella
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.width * 9/16 + 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        webFrame = UIView()
        let window = UIApplication.shared.keyWindow!
        
        webFrame.frame = window.frame
        webFrame.backgroundColor = UIColor(white: 0, alpha: 0.5)
        webFrame.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(closeWebFrame)))
        
        let webView = WKWebView()
        
//        webView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: 0)
//
//        UIView.animate(withDuration: 2, animations: {
//            webView.frame = CGRect(x: 0, y: 50, width: window.frame.width, height: window.frame.height - 50)
//        })
        if let url = URL(string: listaArticoli[indexPath.row].url!) {
            let request = URLRequest(url: url)
            webView.load(request)
        }
        webFrame.addSubview(webView)
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.topAnchor.constraint(equalTo: webView.superview!.topAnchor, constant: 50).isActive = true
        webView.bottomAnchor.constraint(equalTo: webView.superview!.bottomAnchor, constant: 0).isActive = true
        webView.leadingAnchor.constraint(equalTo: webView.superview!.leadingAnchor, constant: 0).isActive = true
        webView.trailingAnchor.constraint(equalTo: webView.superview!.trailingAnchor, constant: 0).isActive = true
        
        
        
        window.addSubview(webFrame)
        
        webFrame.translatesAutoresizingMaskIntoConstraints = false
        webFrame.topAnchor.constraint(equalTo: webFrame.superview!.topAnchor, constant: 0).isActive = true
        webFrame.bottomAnchor.constraint(equalTo: webFrame.superview!.bottomAnchor, constant: 0).isActive = true
        webFrame.leadingAnchor.constraint(equalTo: webFrame.superview!.leadingAnchor, constant: 0).isActive = true
        webFrame.trailingAnchor.constraint(equalTo: webFrame.superview!.trailingAnchor, constant: 0).isActive = true

    }
    
    @objc func closeWebFrame(){
        webFrame.removeFromSuperview()
    }
    
    func aggiornaTableView(articoli: [Article]){
        listaArticoli = articoli
        ListaNews.reloadData()
    }
    
    func getDate(dataStringa: String) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        guard let date = dateFormatter.date(from: dataStringa) else {
            fatalError("ERROR: Date conversion failed due to mismatched format.")
        }
        dateFormatter.dateFormat = "yyyy"
        let year = dateFormatter.string(from: date)
        dateFormatter.dateFormat = "MM"
        let month = dateFormatter.string(from: date)
        dateFormatter.dateFormat = "dd"
        let day = dateFormatter.string(from: date)
        
        return String(year+"-"+month+"-"+day)
    }
}
