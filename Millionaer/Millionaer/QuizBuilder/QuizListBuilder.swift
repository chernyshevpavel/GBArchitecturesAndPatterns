//
//  QuizListBuilder.swift
//  Millionaer
//
//  Created by Павел Чернышев on 04.11.2020.
//

import Foundation

class QuizListBuilder: QuizListBuilderProtocol {
    
    class TmpQuiz {
        var question = ""
        var answers: [Int:String] = [:]
        var correctAnswerIndex = -1
    
        public func canTransformToQuiz() -> Bool {
            var res = true
            if self.question.count == 0 {
                res = false
            }
            for i in 0...3 {
                if self.answers[i]?.count == 0 {
                    res = false
                    break
                }
            }
            if self.correctAnswerIndex < 0 {
                res = false
            }
            return res
        }
        
        public func toQuiz() -> Quiz {
            var answerList: [String] = []
            let answers = self.answers.sorted { (arg0, arg1) -> Bool in
                return arg0.key < arg1.key
            }
            for answer in answers {
                answerList.append(answer.value)
            }
            return Quiz(question: self.question, answers: answerList, rightAnswerIndex: self.correctAnswerIndex)
        }

    }
    
    var quizList: Dictionary<Int, TmpQuiz> = [:]
    
    func addQuestion(questionIndex: Int, _ question: String) {
        let tmpQuiz = get(byIndex: questionIndex)
        tmpQuiz.question = question
    }
    
    func addAnswer(questionIndex: Int, index: Int, answer: String) {
        let tmpQuiz = get(byIndex: questionIndex)
        tmpQuiz.answers[index] = answer
    }
    
    func addCorrectAnswerIndex(questionIndex: Int, answerIndex: Int) {
        let tmpQuiz = get(byIndex: questionIndex)
        tmpQuiz.correctAnswerIndex = answerIndex
    }
    
    func build() -> [Quiz] {
        var quizList: [Quiz] = []
        for tmpQuiz in self.quizList {
            if tmpQuiz.value.canTransformToQuiz() {
                quizList.append(tmpQuiz.value.toQuiz())
            }
        }
        return quizList
    }
    
    private func get(byIndex index: Int) -> TmpQuiz {
        if let tmpQuiz = quizList[index] {
            return tmpQuiz
        } else {
            let tmpQuiz = TmpQuiz()
            quizList[index] = tmpQuiz
            return tmpQuiz
        }
    }
}
