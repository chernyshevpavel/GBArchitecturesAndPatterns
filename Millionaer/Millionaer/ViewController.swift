//
//  ViewController.swift
//  Millionaer
//
//  Created by Павел Чернышев on 27.10.2020.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var resultLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func StartGame(_ sender: Any) {
        performSegue(withIdentifier: "StartGame", sender: sender)
    }
    
    @IBAction func showResults(_ sender: Any) {
        performSegue(withIdentifier: "Results", sender: sender)
    }
    
    @IBAction func showSettings(_ sender: Any) {
        performSegue(withIdentifier: "settings", sender: sender)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "StartGame" {
            guard let gvc = segue.destination as? GameScreenViewController else { return }
            gvc.gameSceneDelegate = self
        } else if segue.identifier == "settings" {
            guard let svc = segue.destination as? SettingsViewController else { return }
            svc.quizProcessChangeDelegate = self
        }
    }
    
}

extension ViewController: GameSceneDelagate {
    func endGame(score: Int) {
        resultLabel.text = "Last result: \(score)"
    }
}

extension ViewController: QuizProcessChangeDelegate {
    func change(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
            case 0: Game.shared.quizProcess = .serial
            case 1: Game.shared.quizProcess = .random
            default: Game.shared.quizProcess = . serial
        }
    }
}

