//
//  ViewController.swift
//  iSport
//
//  Created by Gianluigi Oliva on 13/01/2019.
//  Copyright © 2019 Gianluigi Oliva. All rights reserved.
//

import UIKit
import WebKit

class NewsView: UIViewController, UITableViewDelegate, UITableViewDataSource, NewsDelegate {
    
    @IBOutlet weak var ListaNews: UITableView!
    
    var listaArticoli = [Article]()
    var isLoading = false
    var openWeb = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ListaNews.delegate = self
        ListaNews.dataSource = self
        ListaNews.rowHeight = 130
        isLoading = true
        NewsAPI.RequestAPI(callback: aggiornaTableView)
    }

    override func viewDidAppear(_ animated: Bool) {
        reloadTable()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listaArticoli.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cella = ListaNews.dequeueReusableCell(withIdentifier: "CellNews") as! CellNews
        cella.contenuto = listaArticoli[indexPath.row]
        cella.delegate = self
        cella.selectionStyle = .none
        if APICoreData.GetNewsByURL(url: listaArticoli[indexPath.row].url!) != nil {
            cella.Favorite.image = UIImage(named: "bookmarkFull")
        } else {
            cella.Favorite.image = UIImage(named: "bookmark")
        }
        return cella
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if !openWeb{
            openWeb = true
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
            
            UIView.animate(withDuration: 0.5, animations: {
                WebView.superview!.layoutIfNeeded()
            }) { (finished: Bool) in
                if finished {
                    self.openWeb = false
                }
            }
        }
    }

    
    func aggiornaTableView(){
        listaArticoli = NewsAPI.listaArticoli
        ListaNews.reloadData()
        isLoading = false
    }
    
    @IBAction func OpenMenu(_ sender: Any) {
        sideMenuController?.revealMenu()
    }
    
    @IBAction func ShowFavorite(_ sender: Any) {
        performSegue(withIdentifier: "ShowPreferiti", sender: nil)
    }
    
    func reloadTable() {
        self.ListaNews.reloadData()
    }
    
    @IBAction func ReloadButton(_ sender: Any) {
        if !isLoading {
            print("aggiorno")
            isLoading = true
            NewsAPI.RequestAPI(callback: aggiornaTableView)
        }
    }
    
}
