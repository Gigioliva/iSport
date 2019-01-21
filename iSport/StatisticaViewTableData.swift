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
    
    var Statistiche: UITableView
    
    init(tableView: UITableView, statistiche: [Statistic]) {
        self.Statistiche = tableView
        self.statisticaLista = statistiche
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return statisticaLista.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cella = Statistiche.dequeueReusableCell(withIdentifier: "StatisticCell") as! StatisticaTableViewCell
        let contenutoCella = statisticaLista[indexPath.row]
        
        cella.TipoStatistica.text = contenutoCella.type
        cella.ValoreTeam1.text = contenutoCella.home
        cella.ValoreTeam2.text = contenutoCella.away
        
        return cella
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }

}
