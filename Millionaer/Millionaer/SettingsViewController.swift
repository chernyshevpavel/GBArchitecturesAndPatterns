//
//  SettingsViewController.swift
//  Millionaer
//
//  Created by Павел Чернышев on 03.11.2020.
//

import UIKit

protocol QuizProcessChangeDelegate {
    func change(_ sender: UISegmentedControl)
}

class SettingsViewController: UIViewController {

    var quizProcessChangeDelegate: QuizProcessChangeDelegate?
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        segmentControl.selectedSegmentIndex = Game.shared.quizProcess.rawValue
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func quizProcessSelect(_ sender: UISegmentedControl) {
        quizProcessChangeDelegate?.change(sender)
    }
}
