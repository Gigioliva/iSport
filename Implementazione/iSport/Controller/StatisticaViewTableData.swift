//
//  StatisticaViewTableData.swift
//  iSport
//
//  Created by Gianluigi Oliva on 20/01/2019.
//  Copyright © 2019 Gianluigi Oliva. All rights reserved.
//

import UIKit

class StatisticaViewTableData: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    var statisticaLista: [Statistic]
    var previsioni: Prediction
    
    var Statistiche: UITableView
    
    init(tableView: UITableView, statistiche: [Statistic], prediction: Prediction) {
        self.Statistiche = tableView
        self.statisticaLista = statistiche
        self.previsioni = prediction
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "PREDICTION"
        case 1:
            return "STATISTIC"
        default:
            return ""
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return statisticaLista.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cella = Statistiche.dequeueReusableCell(withIdentifier: "PrevisionCell") as! PredictionTableViewCell
            cella.predizione = previsioni
            cella.selectionStyle = .none
            return cella
        } else {
            let cella = Statistiche.dequeueReusableCell(withIdentifier: "StatisticCell") as! StatisticaTableViewCell
            let contenutoCella = statisticaLista[indexPath.row]
            cella.contenuto = contenutoCella
            cella.selectionStyle = .none
            return cella
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let dimensioni: CGFloat = indexPath.section == 0 ? 80 : 33
        return dimensioni
    }

}
