//
//  GameViewController.swift
//  XO-game
//
//  Created by Evgeny Kireev on 25/02/2019.
//  Copyright © 2019 plasmon. All rights reserved.
//

import UIKit


class GameViewController: UIViewController {
    
    @IBOutlet var gameboardView: GameboardView!
    @IBOutlet var firstPlayerTurnLabel: UILabel!
    @IBOutlet var secondPlayerTurnLabel: UILabel!
    @IBOutlet var winnerLabel: UILabel!
    @IBOutlet var restartButton: UIButton!
    
    var gameOver = false
    private var gameboard = Gameboard()
    private var currentState: GameState!
    public var currentModeState: GameModeState?
    public var mode: Mode!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initGameModeSatae(mode: self.mode)
        self.currentModeState?.initState()
        gameboardView.onSelectPosition = { [weak self] position in
            guard let self = self else { return }
            if !self.gameOver {
                self.currentModeState?.pointHandler(position: position)
            }
        }
    }
    
    func initGameModeSatae(mode: Mode) {
        switch mode {
        case .Standart: currentModeState = StandartMode(gameViewController: self, gameboard: gameboard, gameboardView: gameboardView)
        case .Computer: currentModeState = ComputerMode(gameViewController: self, gameboard: gameboard, gameboardView: gameboardView)
        case .FiveSteps: currentModeState = FiveStepsMode(gameViewController: self, gameboard: gameboard, gameboardView: gameboardView)
        }
    }
    
    @IBAction func restartButtonTapped(_ sender: UIButton) {
        self.gameboard = Gameboard()
        self.gameboardView.clear()
        self.gameOver = false
        self.viewDidLoad()
    }
}

