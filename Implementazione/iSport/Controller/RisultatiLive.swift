//
//  RisultatiLiveViewController.swift
//  iSport
//
//  Created by Gianluigi Oliva on 13/01/2019.
//  Copyright © 2019 Gianluigi Oliva. All rights reserved.
//

import UIKit
import WebKit

class RisultatiLive: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var ListaRisultati: UITableView!
    
    var listaPartiteCampionato = Dictionary<String, [Partita]>()
    var listaCampionati = [String]()
    
    var indiceCellaSelezionata = (sezione: 0, riga: 0)
    var giorno: String = "2019-01-12"
    var viewBlack: UIView?
    var datePicket: DateView?
    let dateFormatter = DateFormatter()
    var startUpdate = false
    var picketOpen = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ListaRisultati.delegate = self
        ListaRisultati.dataSource = self
        dateFormatter.dateFormat = "yyyy-MM-dd"
        Update()
        
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if listaCampionati.count > 0{
            return listaCampionati[section]
        }else {
            return nil
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return max(listaCampionati.count, 1)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if listaCampionati.count > 0 {
            let nomeSezione = listaCampionati[section]
            return listaPartiteCampionato[nomeSezione]?.count ?? 0
        }else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if listaCampionati.count > 0 {
            let cella = ListaRisultati.dequeueReusableCell(withIdentifier: "ResultLive", for: indexPath) as! RisultatoTableViewCell
            
            let nomeSezione = listaCampionati[indexPath.section]
            let contenuto = listaPartiteCampionato[nomeSezione]!
            
            cella.partita = contenuto[indexPath.row]
            cella.selectionStyle = .none
            return cella
        }else{
            let cella = CellaVuotaTableViewCell()
            cella.testo = "No Match"
            return cella
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if listaCampionati.count > 0{
            indiceCellaSelezionata.sezione = indexPath.section
            indiceCellaSelezionata.riga = indexPath.row
            performSegue(withIdentifier: "MostraStatistiche", sender: nil)
        }
    }

    
    func Update(){
        startUpdate = true
        viewBlack = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        viewBlack!.backgroundColor = UIColor(white: 0, alpha: 0.5)
        self.view.addSubview(viewBlack!)
        let activity = UIActivityIndicatorView()
        activity.startAnimating()
        viewBlack?.addSubview(activity)
        activity.translatesAutoresizingMaskIntoConstraints = false
        activity.centerXAnchor.constraint(equalTo: viewBlack!.centerXAnchor).isActive = true
        activity.centerYAnchor.constraint(equalTo: viewBlack!.centerYAnchor).isActive = true
        RisultatiAPI.UpdateDatiPartite(giorno: giorno, callback: aggiornaTableView)
    }
    
    func aggiornaTableView(){
        
        let partite = RisultatiAPI.listaPartite
        
        let listaCampionati = partite.reduce(Set<String>(), { (acc, partitaAttuale) in
            return acc.union([partitaAttuale.leagueName!])
        })
        
        for campionato in listaCampionati{
            listaPartiteCampionato[campionato] = partite.filter({ (partita) in
                return partita.leagueName == campionato
            })
        }
        
        self.listaCampionati = Array(listaCampionati)
        
        for campionato in listaCampionati{
            self.listaPartiteCampionato[campionato]?.sort(by: { (orario1, orario2) -> Bool in
                return orario1.matchTime! < orario2.matchTime!
            })
        }
        
        self.listaCampionati.sort { (campionato1, campionato2) -> Bool in
            return campionato1 < campionato2
        }
 
        ListaRisultati.reloadData()
        viewBlack!.removeFromSuperview()
        startUpdate = false
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MostraStatistiche"{
            let statisticaView = segue.destination as! StatisticaView
            let nomeSezione = listaCampionati[indiceCellaSelezionata.sezione]
            statisticaView.contenuto = listaPartiteCampionato[nomeSezione]![indiceCellaSelezionata.riga]
            
        }
    }
    
    @IBAction func ShowMenu(_ sender: Any) {
        sideMenuController?.revealMenu()
    }
    
    @IBAction func ShowData(_ sender: Any) {
        if !startUpdate && !picketOpen{
            picketOpen = true
            viewBlack = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
            viewBlack!.backgroundColor = UIColor(white: 0, alpha: 0.5)
            self.view.addSubview(viewBlack!)
            datePicket = DateView()
            viewBlack!.addSubview(datePicket!)
            datePicket!.Data.date = dateFormatter.date(from: giorno)!
            datePicket!.translatesAutoresizingMaskIntoConstraints = false
            datePicket!.topAnchor.constraint(equalTo: datePicket!.superview!.topAnchor, constant: 10).isActive = true
            datePicket!.leadingAnchor.constraint(equalTo: datePicket!.superview!.leadingAnchor, constant: 10).isActive = true
            datePicket!.trailingAnchor.constraint(equalTo: datePicket!.superview!.trailingAnchor, constant: -10).isActive = true
            datePicket!.addConstraint(NSLayoutConstraint(item: datePicket!, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 0, constant: 200))
            
            viewBlack!.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissDatePicker)))
        }else if picketOpen{
            dismissDatePicker()
        }
        
    }
    
    @objc func dismissDatePicker(){
        let date = datePicket!.Data.date
        giorno = dateFormatter.string(from: date)
        viewBlack!.removeFromSuperview()
        picketOpen = false
        Update()
    }
    
}
