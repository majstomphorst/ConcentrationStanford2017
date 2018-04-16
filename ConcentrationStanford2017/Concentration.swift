//
//  Concentration.swift
//  ConcentrationStanford2017
//
//  Created by Maxim Stomphorst on 11/04/2018.
//  Copyright © 2018 Maxim Stomphorst. All rights reserved.
//

import Foundation

class Concentration {
    
    var cards = [Card]()
    var indexOfOneAndOnlyFaceUpCard: Int?
    var flipCount = 0
    var gameScore = 0 {
        didSet {
            print(gameScore)
        }
    }
    
    func chooseCard(at index: Int) {
        
        trackGameCount(cardIdentifier: cards[index].identifier)
        
        if !cards[index].isMatched {
            // 1. no cards are face up
            // 2. two cards are face up (either match or not)
            // 3. one card face up and chose some other card
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                // check if cards match
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    gameScore += 2
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = nil
            } else {
                // either no cards or 2 cards are face up
                for flipDownIndex in cards.indices {
                    cards[flipDownIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    
    private func trackGameCount(cardIdentifier: Int) {
        
    }
    
    init(numberOfPairsOfCards: Int) {
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        
        // Shuffle the cards
        var shuffled = [Card]()
        
        for _ in 1...cards.count {
            let randomIndex = Int(arc4random_uniform(UInt32(cards.count)))
            shuffled.append(cards.remove(at: randomIndex))
        }
        cards = shuffled
        
    }
}
