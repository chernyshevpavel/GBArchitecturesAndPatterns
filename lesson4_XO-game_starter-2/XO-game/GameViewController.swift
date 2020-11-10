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
    
    private let gameboard = Gameboard()
    private lazy var referee = Referee(gameboard: gameboard)
    private var currentState: GameState! {
        didSet {
            currentState.begin()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setFirstState()
        
        gameboardView.onSelectPosition = { [weak self] position in
            guard let self = self else { return }
            
            self.currentState.addMark(at: position)
            if self.currentState.isCompleted {
                self.setNextState()
            }
        }
    }
    
    func setFirstState() {
        let firstPlayer = Player.first
        currentState = PlayerInputState(player: firstPlayer,
                                        gameViewController: self,
                                        gameboard: gameboard,
                                        gameboardView: gameboardView,
                                        markViewPrototype: firstPlayer.markViewPrototype)
    }
    
    func setNextState() {
        if let winner = referee.determineWinner() {
            currentState = GameEndedState(winner: winner, gameViewController: self)
            return
            
        }
        
        if let playerInputState = currentState as? PlayerInputState {
            let nextPlayer = playerInputState.player.next
            currentState = PlayerInputState(player: nextPlayer,
                                            gameViewController: self,
                                            gameboard: gameboard,
                                            gameboardView: gameboardView,
                                            markViewPrototype: nextPlayer.markViewPrototype)
        }
    }
    
    @IBAction func restartButtonTapped(_ sender: UIButton) {
        
    }
}

