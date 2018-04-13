//
//  ViewController.swift
//  ConcentrationStanford2017
//
//  Created by Maxim Stomphorst on 06/04/2018.
//  Copyright © 2018 Maxim Stomphorst. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // is an instance of the game 'concentration'
    lazy var game = Concentration(numberOfPairsOfCards: cardButtons.count / 2 + 1)
    
    var flipCount = 0 {
        didSet {
            flipCountLabel.text = "flips: \(flipCount)"
        }
    }
    
    @IBOutlet weak var flipCountLabel: UILabel!
    @IBOutlet var cardButtons: [UIButton]!
    
    // if you touch a card
    @IBAction func touchCard(_ sender: UIButton) {
        flipCount += 1
        // get the index of the button that is pressed/touched
        if let cardNumber = cardButtons.index(of: sender) {
            game.choiceCards(at: cardNumber)
            // now the ui can change we have to update the view from the model
            updateViewFromModel()
        } else {
            print("choosen card was not in cardbuttons")
        }
    }
    // if press start new game
    @IBAction func newGame(_ sender: UIButton) {
        game = Concentration(numberOfPairsOfCards: cardButtons.count / 2 + 1)
        flipCount = 0
        renewEmojiChoices()
        updateViewFromModel()
    }
    
    // match the model and the UI
    func updateViewFromModel() {
        // looking at every card on the UI
        for index in cardButtons.indices {
            
            let button = cardButtons[index]
            let card = game.cards[index]
            
            // check every card if its faceUp
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: .normal)
                button.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
            } else {
                button.setTitle("", for: .normal)
                button.backgroundColor = card.isMatch ? #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 0) : #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 1)
            }
        }
    }
    
    var emojiChoices = ["👻","🦇","👿","👺","👽","😼","😱","🤮","🤠","🤬","🚻"]
    
    var emoji = [Int:String]()
    
    func emoji(for card: Card) -> String {
        // filling the dictonary on demand
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count - 1)))
            emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
        }
        return emoji[card.identifier] ?? "?"
//        if emoji[card.identifier] != nil {
//            return emoji[card.identifier]!
//        } else {
//            return "?"
//        }
    }
    func renewEmojiChoices() {
        emojiChoices = ["👻","🦇","👿","👺","👽","😼","😱","🤮","🤠","🤬","🚻"]
    }
    
}

