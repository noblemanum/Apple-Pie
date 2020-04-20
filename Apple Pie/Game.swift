//
//  Game.swift
//  Apple Pie
//
//  Created by Dimon on 18.04.2020.
//  Copyright © 2020 Dimon. All rights reserved.
//

import Foundation

struct Game {
    var word: String
    var incorrectMoviesRemaining: Int
    var guessedLetters: [Character]
    
    mutating func playerGuessed(letter: Character) {
        guessedLetters.append(letter)
        if !word.contains(letter) {
            incorrectMoviesRemaining -= 1
        }
    }
    
    var formattedWord: String {
        var guessedWord = ""
        for letter in word {
            if guessedLetters.contains(letter) {
                guessedWord += "\(letter)"
            } else {
                guessedWord += "_"
            }
        }
        return guessedWord
    }
}
