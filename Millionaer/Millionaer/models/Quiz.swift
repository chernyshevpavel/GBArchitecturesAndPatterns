//
//  Quiz.swift
//  Millionaer
//
//  Created by Павел Чернышев on 28.10.2020.
//

import Foundation

struct Quiz: Codable {
    var question: String
    var answers: [String]
    var rightAnswerIndex: Int
}
