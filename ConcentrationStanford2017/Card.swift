//
//  Card.swift
//  ConcentrationStanford2017
//
//  Created by Maxim Stomphorst on 11/04/2018.
//  Copyright © 2018 Maxim Stomphorst. All rights reserved.
//

import Foundation

struct Card {
    
    var isFaceUp = false
    var isMatched = false
    var identifier: Int
    
    static var identifierFactory = 0
    static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
}
