//
//  QuizBuilderProtocol.swift
//  Millionaer
//
//  Created by Павел Чернышев on 04.11.2020.
//

import Foundation

protocol QuizListBuilderProtocol {
    func addQuestion(questionIndex: Int, _ question: String);
    func addAnswer(questionIndex: Int, index: Int, answer: String)
    func addCorrectAnswerIndex(questionIndex: Int, answerIndex: Int)
    func build() -> [Quiz]
}

