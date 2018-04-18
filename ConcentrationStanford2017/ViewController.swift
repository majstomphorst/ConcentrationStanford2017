//
//  ViewController.swift
//  ConcentrationStanford2017
//
//  Created by Maxim Stomphorst on 06/04/2018.
//  Copyright © 2018 Maxim Stomphorst. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // creating the game with the number of buttons on the board
    lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    
    var numberOfPairsOfCards: Int { return (cardButtons.count + 1) / 2 }
    var flipCount = 0 { didSet { flipCountLabel.text = "Flips: \(flipCount)" } }
    var gameScore = 0 { didSet { gameScoreLabel.text = "Score: \(gameScore)" } }
    
    override func viewDidLoad() {
        indexTheme = Int(arc4random_uniform(UInt32(themeList.count)))
        emojiChoices = themeList[indexTheme].emojis
        view.backgroundColor = themeList[indexTheme].backgroundColor
        for cardButton in cardButtons {
            cardButton.backgroundColor = themeList[indexTheme].cardBackgroundColor
        }
    }
    
    @IBOutlet weak var gameScoreLabel: UILabel!
    @IBOutlet weak var flipCountLabel: UILabel!
    @IBOutlet var cardButtons: [UIButton]!
    @IBOutlet var backGround: UIView!
    
    @IBAction func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.index(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("chosen card was not in cardButtons")
        }
    }
    
    @IBAction func touchNewGame(_ sender: UIButton) {
        game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
        indexTheme = Int(arc4random_uniform(UInt32(themeList.count)))
        emojiChoices = themeList[indexTheme].emojis
        view.backgroundColor = themeList[indexTheme].backgroundColor
        for cardButton in cardButtons {
            cardButton.backgroundColor = themeList[indexTheme].cardBackgroundColor
        }
        updateViewFromModel()
    }
    
    func updateViewFromModel() {
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
        flipCount = game.flipCount
        gameScore = game.gameScore
    }
    
    var emojiChoices = [String]()
    var emoji = [Int:String]()
    
    func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
            emoji[card.identifier] = emojiChoices.remove(at: emojiChoices.count.arc4random)
        }
        return emoji[card.identifier] ?? "?"
    }
    
    private var indexTheme = 0
    
    var themeList: [Theme] = [
        Theme(name: "animals",
              emojis: ["🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐻", "🙊", "🐔","🐧"],
              backgroundColor: UIColor.green,
              cardBackgroundColor: UIColor.blue),
        Theme(name: "face",
              emojis: ["😀", "😁", "😆", "🤣", "😇", "🤪", "😎", "🤓", "🤩","🤯"],
              backgroundColor: UIColor.yellow,
              cardBackgroundColor: UIColor.black),
        Theme(name: "clothes",
              emojis: ["👚", "👕", "👖", "👔", "👗", "👓", "👠", "🎩", "👟", "⛱","🎽"],
              backgroundColor: UIColor.blue,
              cardBackgroundColor: UIColor.yellow),
        Theme(name: "halloween",
              emojis: ["💀", "👻", "👽", "🙀", "🦇", "🕷", "🕸", "🎃", "🎭","😈", "⚰"],
              backgroundColor: UIColor.black,
              cardBackgroundColor: UIColor.orange)
    ]
}

extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
    }
}

