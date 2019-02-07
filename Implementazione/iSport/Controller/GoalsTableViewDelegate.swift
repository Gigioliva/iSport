//
//  GoalsTableViewDelegate.swift
//  iSport
//
//  Created by Gianluigi Oliva on 21/01/2019.
//  Copyright © 2019 Gianluigi Oliva. All rights reserved.
//

import UIKit

class GoalsTableViewDelegate: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    var tableViewGoal: UITableView
    var listaGoals: [GoalList]
    
    init(tableView: UITableView, listaGoal: [GoalList]) {
        self.tableViewGoal = tableView
        self.listaGoals = listaGoal
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return max(listaGoals.count, 1)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if listaGoals.count > 0{
            let cella = tableViewGoal.dequeueReusableCell(withIdentifier: "GoalsCell") as! GoalsTableViewCell
            let goal = listaGoals[indexPath.row]
            cella.contenuto = goal
            cella.selectionStyle = .none
            return cella
        }else {
            let cella = CellaVuotaTableViewCell()
            cella.testo = "No Goal"
            return cella
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    

}
