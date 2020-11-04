//
//  QuizProcessStrategy.swift
//  Millionaer
//
//  Created by Павел Чернышев on 03.11.2020.
//

import Foundation

protocol QuizProcessStrategy {
    func execute(quizList: [Quiz]) -> [Quiz]
}
