//
//  ViewController.swift
//  ConcentrationStanford2017
//
//  Created by Maxim Stomphorst on 06/04/2018.
//  Copyright © 2018 Maxim Stomphorst. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
    
    var flipCount = 0 { didSet { flipCountLabel.text = "Flips: \(flipCount)" } }
    
    @IBOutlet weak var flipCountLabel: UILabel!
    
    @IBOutlet var cardButtons: [UIButton]!
    
    @IBAction func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = cardButtons.index(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
            //flipCard(withEmoji: emojiChoices[cardNumber], on: sender)
        } else {
            print("chosen card was not in cardButtons")
        }
    }
    @IBAction func touchNewGame(_ sender: UIButton) {
        emojiChoices = ["🦇", "😱", "🙀", "😈", "🎃", "👻", "🍭", "🍬", "🍎","🐨"]
        game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
        flipCount = 0
        updateViewFromModel()
    }
    
    func updateViewFromModel() {
        let randomIndexTheme = Int(arc4random_uniform(UInt32(themeList.count)))
        
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: .normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            } else {
                button.setTitle("", for: .normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 0) : #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 1)
            }
        }
    }
    
    var emojiChoices = ["🦇", "😱", "🙀", "😈", "🎃", "👻", "🍭", "🍬", "🍎","🐨"]

    var emoji = [Int:String]()
    
    func emoji(for card: Card) -> String {
        let randomIndexTheme = Int(arc4random_uniform(UInt32(themeList.count)))
        
        if emoji[card.identifier] == nil, themeList[randomIndexTheme].emojis.count > 0 {
            emoji[card.identifier] = themeList[randomIndexTheme].emojis.removeFirst()
        }
        
//        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
//            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
//            emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
//        }
        
        return emoji[card.identifier] ?? "?"
    }
    
    var themeList: [Theme] = [
        Theme(name: "animals",
              emojis: ["🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐻", "🙊", "🐔","🐧"]),
        Theme(name: "face",
              emojis: ["😀", "😁", "😆", "🤣", "😇", "🤪", "😎", "🤓", "🤩","🤯"]),
        Theme(name: "clothes",
              emojis: ["👚", "👕", "👖", "👔", "👗", "👓", "👠", "🎩", "👟", "⛱","🎽"]),
        Theme(name: "halloween",
              emojis: ["💀", "👻", "👽", "🙀", "🦇", "🕷", "🕸", "🎃", "🎭","😈", "⚰"])
    ]
}

