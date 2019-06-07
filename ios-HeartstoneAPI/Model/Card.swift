//
//  Model.swift
//  ios-HeartstoneAPI
//
//  Created by Guilherme Piccoli on 06/06/19.
//  Copyright © 2019 Guilherme Piccoli. All rights reserved.
//
//   let card = try? newJSONDecoder().decode(Card.self, from: jsonData)

import Foundation

struct ListCard: Codable {
    
}

// MARK: - Card
struct Card: Codable {
    let cardId, dbfId, name, cardSet: String?
    let type, faction, rarity: String?
    let cost, attack, health: Int?
    let text, flavor, artist: String?
    let collectible, elite: Bool?
    let playerClass: String?
    let img: String?
    let imgGold: String?
    let locale: String?
}

