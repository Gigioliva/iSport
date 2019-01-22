//
//  RisultatiPartite.swift
//  iSport
//
//  Created by Gianluigi Oliva on 22/01/2019.
//  Copyright © 2019 Gianluigi Oliva. All rights reserved.
//

import UIKit


struct Partita: Decodable {
    let leagueName: String?
    let matchId: String?
    let matchStatus: String?
    let matchTime: String?
    let matchHometeamName: String?
    let matchHometeamScore: String?
    let matchAwayteamName: String?
    let matchAwayteamScore: String?
    let matchHometeamHalftimeScore: String?
    let matchAwayteamHalftimeScore: String?
    let goalscorer: [GoalList]
    let cards: [CardList]
    let statistics: [Statistic]
    let lineup: Formazione
}

struct GoalList: Decodable {
    let time: String?
    let homeScorer: String?
    let score: String?
    let awayScorer: String?
}

struct CardList: Decodable {
    let time: String?
    let homeFault: String?
    let card: String?
    let awayFault: String?
}

struct Statistic: Decodable {
    let type: String?
    let home: String?
    let away: String?
}

struct Formazione: Decodable {
    let home: Campo?
    let away: Campo?
}

struct Campo: Decodable {
    let startingLineups: [Lineup]?
    let substitutions: [Lineup]?
}

struct Lineup: Decodable{
    let lineupPlayer: String?
    let lineupNumber: String?
    let lineupPosition: String?
    let lineupTime: String?
}

struct Prediction: Decodable{
    let matchId: String?
    let probHW: String?
    let probD: String?
    let probAW: String?
}

struct Odds: Decodable{
    let matchId: String?
    let odd1: String?
    let oddX: String?
    let odd2: String?
}
