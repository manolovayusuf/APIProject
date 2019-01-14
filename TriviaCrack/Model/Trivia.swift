//
//  Trivia.swift
//  TriviaCrack
//
//  Created by Manny Yusuf on 1/14/19.
//  Copyright © 2019 Manny Yusuf. All rights reserved.
//

import Foundation

struct TriviaCrack: Codable {
    var results: [TriviaQuestion]
}

struct TriviaQuestion: Codable {
    let category: String
    let type: String
    let difficulty: String
    let question: String
    let correct_answer: String
    let incorrect_answers: [String]
}
