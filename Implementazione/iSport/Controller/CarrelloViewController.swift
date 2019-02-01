//
//  CarrelloViewController.swift
//  iSport
//
//  Created by Gianluigi Oliva on 23/01/2019.
//  Copyright © 2019 Gianluigi Oliva. All rights reserved.
//

import UIKit
import CoreData

class CarrelloViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var importo: UITextField!
    @IBOutlet weak var listaCarrello: UITableView!
    @IBOutlet weak var quotaTotLabel: UILabel!
    @IBOutlet weak var vincitaPotenziale: UILabel!
    
    @IBOutlet weak var constraintBottom: NSLayoutConstraint!
    
    var listaScommesse = [PartitaCarrello]()
    
    var quotaTotale: Double = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        addDoneButtonOnKeyboard()
        
        listaCarrello.delegate = self
        listaCarrello.dataSource = self
        
        listaCarrello.estimatedRowHeight = 60
        listaCarrello.rowHeight = UITableView.automaticDimension
        listaCarrello.allowsSelection = false
        
        UpdateDati()
        
    }
    
    func UpdateDati() {
        listaScommesse = APICoreData.GetAllPartite()
        listaCarrello.reloadData()
        calcolaQuota()
        calcolaPotenzialeVincita()
    }
    
    
    @IBAction func ImportoAggiornato(_ sender: Any) {
        calcolaPotenzialeVincita()
    }
    
    func calcolaQuota() {
        quotaTotale = listaScommesse.reduce(Double(1), { (acc, scommessa) in
            return acc * (Double(scommessa.quota!) ?? 1.0)
        })
        quotaTotale = Double(round(quotaTotale * 100) / 100)
        quotaTotLabel.text = String(quotaTotale)
    }
    
    func calcolaPotenzialeVincita()  {
        let importoGiocato = Double(importo.text!) ?? 0
        let vincita = Double(round(importoGiocato * quotaTotale * 100) / 100)
        vincitaPotenziale.text = String(vincita)
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listaScommesse.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cella = listaCarrello.dequeueReusableCell(withIdentifier: "CarrelloCell", for: indexPath) as! CarrelloTableViewCell
        let scommessa = listaScommesse[indexPath.row]
        cella.Squadre.text = scommessa.homeName! + " - " + scommessa.awayName!
        cella.Puntata.bottoneScommessa.setTitle(scommessa.puntata!, for: .normal)
        cella.Puntata.quotaLabel.text = scommessa.quota
        
        return cella
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            APICoreData.DeletePartitaFromId(matchId: listaScommesse[indexPath.row].matchId!)
            UpdateDati()
        }
    }

    
    
    func addDoneButtonOnKeyboard() {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
        doneToolbar.barStyle = UIBarStyle.default
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(doneButtonAction))
        
        var items = [UIBarButtonItem]()
        items.append(flexSpace)
        items.append(done)
        
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        self.importo.inputAccessoryView = doneToolbar
    }
    
    @objc func doneButtonAction() {
        self.importo.resignFirstResponder()
    }
    
    @objc func handleKeyboardNotification(notification: NSNotification) {
        
        if let userInfo = notification.userInfo {
            
            let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect
            
            let isKeyboardShowing = notification.name == UIResponder.keyboardWillShowNotification
            
            constraintBottom?.constant = isKeyboardShowing ? keyboardFrame!.height : 0
            
            UIView.animate(withDuration: 0, delay: 0, options: UIView.AnimationOptions.curveEaseOut, animations: {
                
                self.view.layoutIfNeeded()
                
            }, completion: nil)
        }
    }
    
}
