//
//  Notizie.swift
//  iSport
//
//  Created by Gianluigi Oliva on 22/01/2019.
//  Copyright © 2019 Gianluigi Oliva. All rights reserved.
//

import UIKit

struct Article: Decodable {
    let author: String?
    let title: String?
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
}

struct Articoli: Decodable {
    let status: String
    let articles: [Article]
}
