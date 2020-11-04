//
//  QuizRandomStrategy.swift
//  Millionaer
//
//  Created by Павел Чернышев on 04.11.2020.
//

import Foundation

class QuizRandomStrategy: QuizProcessStrategy {
    func execute(quizList: [Quiz]) -> [Quiz] {
        return quizList.shuffled()
    }
}
