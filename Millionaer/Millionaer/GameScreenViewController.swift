//
//  GameScreenViewController.swift
//  Millionaer
//
//  Created by Павел Чернышев on 27.10.2020.
//

import UIKit

protocol GameSceneDelagate: class {
    func endGame(score: Int)
}

class GameScreenViewController: UIViewController {

    @IBOutlet var answerButtons: [UIButton]!
    @IBOutlet weak var processBtn: UIButton!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var progressLabel: UILabel!
    
    var quizList: [Quiz] = []
    var gameSession: GameSession = Game.shared.initGameSession()
    
    weak var gameSceneDelegate: GameSceneDelagate?
    
    var observer: NSKeyValueObservation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initQuizList()
        guard quizList.count > 0 else {
            fatalError("Quzes not found")
        }
        showQuiz(quiz: Game.shared.gameSession.getCurrentQuiz())
        progressLabel.text = ""
        observer = progressOserver()
    }

    @IBAction func answerSelected(_ sender: UIButton) {
        let tag = Int(sender.tag)
        let quiz = gameSession.getCurrentQuiz()
        showRightAnswer(quiz: quiz)
        guard gameSession.checkAnswer(answerIndex: tag) else {
            showGaneOverBtn()
            return
        }
        if (Game.shared.gameSession.isWin) {
            showWinBtn()
        } else {
            showNextQuestionBtn()
        }
    }
    
    @IBAction func processBtnTap(_ sender: Any) {
        guard !gameSession.isGameOver else {
            endGame()
            return
        }
        processBtn.isHidden = true
        processBtn.setTitle("", for: .normal)
        for btn in answerButtons {
            btn.backgroundColor = .white
            btn.isEnabled = true
            btn.alpha = 1
        }
        loadNextQuestion()
    }
    
    private func progressOserver() -> NSKeyValueObservation {
        return {
            Game.shared.gameSession.progress.observe(\ProgressObservable.correctAnswersCount, options: .initial) { [weak self] (object, change) in
                self?.progressLabel.text = "\(object.correctAnswersCount) / \(object.quizCount)"
            }
        }()
    }
    
    private func loadNextQuestion() {
        if gameSession.hasNextQuestion() {
            showQuiz(quiz: gameSession.getNextQuestion())
        }
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
        if let gameSceneDelegate = gameSceneDelegate {
            gameSceneDelegate.endGame(score: gameSession.getScore())
        }
        Game.shared.addRecord(Record(date: Date(), score: gameSession.getScore()))
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
    
    private func showRightAnswer(quiz: Quiz) {
        for btn in answerButtons {
            btn.isEnabled = false
            btn.alpha = 0.5
            if btn.tag == quiz.rightAnswerIndex {
                btn.backgroundColor = .green
            } else {
                btn.backgroundColor = .red
            }
        }
    }
    
    private func initQuizList() {
        self.quizList = Game.shared.gameSession.quizList
    }
}
