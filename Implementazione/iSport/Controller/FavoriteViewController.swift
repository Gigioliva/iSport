//
//  FavoriteViewController.swift
//  iSport
//
//  Created by Gianluigi Oliva on 03/02/2019.
//  Copyright © 2019 Gianluigi Oliva. All rights reserved.
//

import UIKit

class FavoriteViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, NewsDelegate {
    
    @IBOutlet weak var ListaFavoriti: UITableView!
    var ListaNews = [News]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ListaFavoriti.delegate = self
        ListaFavoriti.dataSource = self
        ListaFavoriti.rowHeight = 130
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        reloadTable()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ListaNews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cella = ListaFavoriti.dequeueReusableCell(withIdentifier: "CellNews") as! CellNews
        let articolo = ListaNews[indexPath.row]
        let news = Article(author: "", title: articolo.title, description: "", url: articolo.url, urlToImage: articolo.urlToImage, publishedAt: "")
        cella.contenuto = news
        cella.delegate = self
        cella.selectionStyle = .none
        if APICoreData.GetNewsByURL(url: news.url!) != nil {
            cella.Favorite.image = UIImage(named: "bookmarkFull")
        } else {
            cella.Favorite.image = UIImage(named: "bookmark")
        }
        return cella
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let window = UIApplication.shared.keyWindow!
        let WebView = WebViewNews()
        window.addSubview(WebView)
        WebView.urlNews = ListaNews[indexPath.row].url!
        
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
        })
    }

    
    func reloadTable() {
        ListaNews = APICoreData.GetAllNews()
        self.ListaFavoriti.reloadData()
    }
    
}
