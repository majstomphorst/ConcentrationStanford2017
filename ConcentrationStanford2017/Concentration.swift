//
//  Concentration.swift
//  ConcentrationStanford2017
//
//  Created by Maxim Stomphorst on 11/04/2018.
//  Copyright © 2018 Maxim Stomphorst. All rights reserved.
//

import Foundation

class Concentration {
    
    private(set) var cards = [Card]()
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            var foundIndex: Int?
            for index in cards.indices {
                if cards[index].isFaceUp {
                    if foundIndex == nil {
                        foundIndex = index
                    } else {
                        return nil
                    }
                }
            }
            return foundIndex
        }
        set(newValue) {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    private(set) var flipCount = 0
    private(set) var gameScore = 0
    
    func chooseCard(at index: Int) {
        
        assert(cards.indices.contains(index),
               "Concentration.chooseCard{at\(index): index not in cards")
        flipCount += 1
        if !cards[index].isMatched {
            // 1. no cards are face up
            // 2. two cards are face up (either match or not)
            // 3. one card face up and chose some other card
            
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                // check if cards match
                if cards[matchIndex] == cards[index] {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    gameScore += 2
                }
                if cards[index].hasBeenFlipAtLeastOnce, !cards[index].isMatched {
                    gameScore -= 1
                }
                
                cards[index].isFaceUp = true
                cards[index].hasBeenFlipAtLeastOnce = true
                
                
            } else {
                // either no cards or 2 cards are face up
                indexOfOneAndOnlyFaceUpCard = index
                if cards[index].hasBeenFlipAtLeastOnce {
                    gameScore -= 1
                    
                cards[index].hasBeenFlipAtLeastOnce = true
                } else {
                    cards[index].hasBeenFlipAtLeastOnce = true
                }
            }
        }
    }
    
    init(numberOfPairsOfCards: Int) {
        
//        assert(cards.indices.contains(numberOfPairsOfCards),
//               "Concentration.init numberOfPairsOfCards\(numberOfPairsOfCards): 1 and up")
//        
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        
        // Shuffle the cards
        var shuffled = [Card]()
        
        for _ in 1...cards.count {
            shuffled.append(cards.remove(at: cards.count.arc4random))
        }
        cards = shuffled
        
    }
}
