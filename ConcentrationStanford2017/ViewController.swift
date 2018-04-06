//
//  ViewController.swift
//  ConcentrationStanford2017
//
//  Created by Maxim Stomphorst on 06/04/2018.
//  Copyright © 2018 Maxim Stomphorst. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var flipCount = 0 {
        didSet {
            flipCountLabel.text = "flips: \(flipCount)"
        }
    }
    
    @IBOutlet weak var flipCountLabel: UILabel!
    // array of the buttons
    @IBOutlet var cardButtons: [UIButton]!
    
    var emojiChoices = ["👻","🎃","👻","🎃"]
    
    // if you touch a card
    @IBAction func touchCard(_ sender: UIButton) {
        flipCount += 1
        // get the index of the button that is pressed/touched
        if let cardNumber = cardButtons.index(of: sender) {
            flipCard(withEmoji: emojiChoices[cardNumber], on: sender)
        }
    }
    
    /*
     "withEmoji" "on" = external name
     "emoji" "button" = internal name
     */
    
    
    func flipCard(withEmoji emoji: String, on button: UIButton) {
    
        // if button == "👻" than change title and background color
        if button.currentTitle == emoji {
            button.setTitle("", for: .normal)
            button.backgroundColor = #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 1)
        } else { // if its not the ghost
            button.setTitle(emoji, for: .normal)
            button.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
        }
        
        
    }
    
}

