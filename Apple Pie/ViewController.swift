//
//  ViewController.swift
//  Apple Pie
//
//  Created by Dimon on 18.04.2020.
//  Copyright © 2020 Dimon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var listOfWords = ["cat", "dog", "mouse", "duck", "sheep", "humster", "cow"]
    let incorrectMoviesAllowed = 7
    
    var totalWins = 0 {
        didSet {
            newRound()
        }
    }
    
    var totalLosses = 0 {
        didSet {
            newRound()
        }
    }
    
    var currentGame: Game!
    
    @IBOutlet weak var treeImageView: UIImageView!
    @IBOutlet weak var correctWordLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var letterButtons: [UIButton]!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        letterButtons.forEach { button in
            button.setTitleColor(.black, for: .normal)
            button.backgroundColor = #colorLiteral(red: 0.8804071697, green: 0.8804071697, blue: 0.8804071697, alpha: 1)
            button.layer.cornerRadius = 10
        }
        newRound()
    }

    @IBAction func buttonTapped(_ sender: UIButton) {
        sender.isEnabled = false
        sender.backgroundColor = .white
        sender.setTitleColor(.white, for: .normal)
        let letterString = sender.title(for: .normal)!
        let letter = Character(letterString.lowercased())
        currentGame.playerGuessed(letter: letter)
        updateGameState()
    }
    
    func updateGameState() {
        if currentGame.incorrectMoviesRemaining < 0 {
            totalLosses += 1
        } else if currentGame.word == currentGame.formattedWord {
            totalWins += 1
        } else {
            updateUI()
        }
    }
    
    func newRound() {
        if !listOfWords.isEmpty {
            let newWord = listOfWords.removeFirst()
            currentGame = Game(word: newWord, incorrectMoviesRemaining: incorrectMoviesAllowed, guessedLetters: [])
            enableLetterButtons(true)
            updateUI()
        } else {
            scoreLabel.text = "Wins: \(totalWins), Losses: \(totalLosses)" // update last game state
            
            enableLetterButtons(false)
        }
    }
    
    func enableLetterButtons(_ enable: Bool) {
        for button in letterButtons {
            button.isEnabled = enable
            button.setTitleColor(.black, for: .normal)
            button.backgroundColor = #colorLiteral(red: 0.8804071697, green: 0.8804071697, blue: 0.8804071697, alpha: 1)
        }
    }
    
    func updateUI() {
        var letters = [String]()
        for letter in currentGame.formattedWord {
            letters.append(String(letter))
        }
        let wordWithSpacing = letters.joined(separator: " ")
        correctWordLabel.text = wordWithSpacing
        scoreLabel.text = "Wins: \(totalWins), Losses: \(totalLosses)"
        treeImageView.image = UIImage(named: "Tree \(currentGame.incorrectMoviesRemaining)")
    }

}

