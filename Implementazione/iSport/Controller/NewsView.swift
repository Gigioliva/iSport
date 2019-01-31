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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.rgb(red: 226, green: 227, blue: 228)
        ListaNews.delegate = self
        ListaNews.dataSource = self
        ListaNews.backgroundColor = UIColor.rgb(red: 226, green: 227, blue: 228)
        ListaNews.rowHeight = 150
        NewsAPI.RequestAPI(callback: aggiornaTableView)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listaArticoli.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cella = ListaNews.dequeueReusableCell(withIdentifier: "CellNews") as! CellNews
        cella.contenuto = listaArticoli[indexPath.row]
        cella.delegate = self
        cella.selectionStyle = .none
        return cella
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let window = UIApplication.shared.keyWindow!
        let WebView = WebViewNews()
        window.addSubview(WebView)
        WebView.urlNews = listaArticoli[indexPath.row].url!
        
        WebView.translatesAutoresizingMaskIntoConstraints = false
        WebView.topAnchorAnimated = WebView.topAnchor.constraint(equalTo: WebView.superview!.safeAreaLayoutGuide.topAnchor, constant: 0)
        
        WebView.constraintHeight = NSLayoutConstraint(item: WebView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 0, constant: 0)
        WebView.constraintHeight!.isActive = true
        
        WebView.bottomAnchor.constraint(equalTo: WebView.superview!.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
        WebView.leadingAnchor.constraint(equalTo: WebView.superview!.safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true
        WebView.trailingAnchor.constraint(equalTo: WebView.superview!.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true

        WebView.superview!.layoutIfNeeded()
        
        WebView.constraintHeight!.isActive=false
        WebView.topAnchorAnimated!.isActive=true
        UIView.animate(withDuration: 1, animations: {
            WebView.superview!.layoutIfNeeded()
        })
    }

    
    func aggiornaTableView(){
        listaArticoli = NewsAPI.listaArticoli
        ListaNews.reloadData()
    }
    
    @IBAction func OpenMenu(_ sender: Any) {
        sideMenuController?.revealMenu()
    }
    
    
    
}
