//
//  GameSession.swift
//  Millionaer
//
//  Created by Павел Чернышев on 30.10.2020.
//

import Foundation

class GameSession {
    
    private var currentQuizIndex = 0;
    private(set) var isGameOver = false
    private(set) var isWin = false
    private var quizProcessSrategy: QuizProcessStrategy
    
    let hintUsageFacade: HintUsageFacade
    let progress = ProgressObservable()
    
    private(set) var quizList = QuizListCaretaker().retrieveQuizList()
    
    init(quizProcessSrategy: QuizProcessStrategy) {
        self.quizProcessSrategy = quizProcessSrategy
        self.quizList = quizProcessSrategy.execute(quizList: quizList)
        self.progress.quizCount = self.quizList.count
        self.progress.correctAnswersCount = 0
        self.hintUsageFacade = HintUsageFacade(quiz: self.quizList[currentQuizIndex])
    }
    
    public func isLastQuestion() -> Bool {
        return quizList.count == currentQuizIndex + 1
    }
    
    
    public func getCurrentQuiz() -> Quiz {
        return quizList[currentQuizIndex]
    }
    
    public func hasNextQuestion() -> Bool {
        return quizList.count > currentQuizIndex + 1
    }
    
    public func getNextQuestion() -> Quiz {
        currentQuizIndex += 1
        let nextQuestion = quizList[currentQuizIndex]
        hintUsageFacade.currentQuiz = nextQuestion
        return nextQuestion
    }
    
    public func checkAnswer(answerIndex: Int) -> Bool {
        let quiz = getCurrentQuiz()
        guard quiz.rightAnswerIndex == answerIndex else {
            isGameOver = true
            return false
        }
        progress.correctAnswersCount += 1
        if (!hasNextQuestion()) {
            isGameOver = true
            isWin = true
        }
        return true
    }
    
    public func getScore() -> Int {
        return progress.correctAnswersCount
    }
}
