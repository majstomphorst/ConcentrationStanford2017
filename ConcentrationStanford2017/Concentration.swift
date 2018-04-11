//
//  Concentration.swift
//  ConcentrationStanford2017
//
//  Created by Maxim Stomphorst on 11/04/2018.
//  Copyright © 2018 Maxim Stomphorst. All rights reserved.
//

import Foundation

class Concentration {
    
    // the game has a deck of cards
    var cards = [Card]() // -> card is a struct
    
    var indexOfOneAndOnlyOnFaceUpCard: Int?
    
    // is a functions that selects a card (API)
    // the index of the card in the cards array
    func choiceCards(at index: Int) {
        
        // 3 thing
        // no cards are face up: Flipcard over
        // 2 cards are face up: flip all cards facedown
        // 1 card is faceUp: check for match
        
        // ignore matched card (if not)
        if !cards[index].isMatch {
            // if indexOf..... has a value than you have a match BUT not twice the same card.
            if let matchIndex = indexOfOneAndOnlyOnFaceUpCard, matchIndex != index {
                // check if cards match
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatch = true
                    cards[index].isMatch = true
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyOnFaceUpCard = nil
            } else {
                // either no card or 2 cards are faceUp
                for flipDownIndex in cards.indices {
                    cards[flipDownIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyOnFaceUpCard = index
            }
        }
        
    }
    
    // the game has to start but the 'game'/Concentration has to know how many card the are in the game.
    init(numberOfPairsOfCards: Int) {
        for _ in 0..<numberOfPairsOfCards {
            let card = Card()
            // for every game ther have to be 2 'same' cards
            // creating a copy of the orginal card
            cards.append(card)
            cards.append(card)
        }
        // TODO: shuffle the cards
        
    }
}
