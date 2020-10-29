//
//  GameScreenViewController.swift
//  Millionaer
//
//  Created by Павел Чернышев on 27.10.2020.
//

import UIKit

class GameScreenViewController: UIViewController {

    @IBOutlet var answerButtons: [UIButton]!
    @IBOutlet weak var processBtn: UIButton!
    @IBOutlet weak var questionLabel: UILabel!
    
    var quizList: [Quiz] = []
    var currentQuizIndex = 0
    var isGameOver = false
    var isWin = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initQuizList()
        guard quizList.count > currentQuizIndex else {
            fatalError("Quzes not found")
        }
        showQuiz(quiz: quizList[currentQuizIndex])
    }

    @IBAction func answerSelected(_ sender: UIButton) {
        let tag = Int(sender.tag)
        guard quizList.count > currentQuizIndex else {
            return
        }
        let quiz = quizList[currentQuizIndex]
        guard quiz.rightAnswerIndex == tag else {
            isGameOver = true
            showGaneOverBtn()
            return
        }
        if (isLastQuestion()) {
            isGameOver = true
            showWinBtn()
        } else {
            showNextQuestionBtn()
        }
    }
    
    @IBAction func processBtnTap(_ sender: Any) {
        guard !isGameOver else {
            endGame()
            return
        }
        processBtn.isHidden = true
        processBtn.setTitle("", for: .normal)
        loadNextQuestion()
    }
    
    private func isLastQuestion() -> Bool {
        return quizList.count == currentQuizIndex + 1
    }
    
    private func loadNextQuestion() {
        currentQuizIndex += 1
        let quiz = quizList[currentQuizIndex]
        showQuiz(quiz: quiz)
    }
    
    private func showWinBtn() {
        processBtn.backgroundColor = .green
        processBtn.setTitle("You are win!", for: .normal)
        processBtn.isHidden = false
    }
    
    private func showNextQuestionBtn() {
        processBtn.backgroundColor = .green
        processBtn.setTitle("Next", for: .normal)
        processBtn.isHidden = false
    }
    
    private func showGaneOverBtn() {
        processBtn.backgroundColor = .red
        processBtn.setTitle("Game Over", for: .normal)
        processBtn.isHidden = false
    }
    
    private func endGame() {
        dismiss(animated: true)
    }
    
    private func showQuiz(quiz: Quiz) {
        questionLabel.text = quiz.question
        for answerBtn in answerButtons {
            let tag = Int(answerBtn.tag)
            guard quiz.answers.count > tag else { continue }
            answerBtn.setTitle(quiz.answers[tag], for: .normal)
        }
    }
    
    private func showRightAnswer() {
        
    }
    
    private func initQuizList() {
        quizList = [
            Quiz(question: "На каком инструменте, как считается, играл древнерусский певец и сказитель Боян?", answers: [
                "На гуслях",
                "На виолончели",
                "На баяне",
                "На гитаре"
            ], rightAnswerIndex: 0),
            Quiz(question: "Продолжаем игру. В какой из этих стран один из официальных языков - французский?", answers: [
                "Кения",
                "Республика Гаити",
                "Эквадор",
                "Венесуэла"
            ], rightAnswerIndex: 1),
            Quiz(question: "В каком из этих фильмов не снимался Александр Абдулов?", answers: [
                "Московские каникулы",
                "Карнавал",
                "Чародеи",
                "Убить дракона"
            ], rightAnswerIndex: 0),
            Quiz(question: "В каком году произошла Куликовская битва?", answers: [
                "1360",
                "1412",
                "1380",
                "1398"
            ], rightAnswerIndex: 2),
            Quiz(question: "Кто автор музыки к детской песенке Чунга-Чанга?", answers: [
                "Зацепин",
                "Дербенёв",
                "Шпиц",
                "Шаинский"
            ], rightAnswerIndex: 3),
            
        ]
    }
}
