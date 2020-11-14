//
//  ComputerMode.swift
//  XO-game
//
//  Created by Павел Чернышев on 12.11.2020.
//  Copyright © 2020 plasmon. All rights reserved.
//

import Foundation

class ComputerMode: GameModeState {
    
    var state: GameState? {
        willSet {
            
        }
    }
    var gameViewController: GameViewController
    var gameboard: Gameboard
    var gameboardView: GameboardView
    var firstPlayerState: PlayerInputState?
    var secondPlayerState: ComputerInputState?
    var isWaitComputer = false
    
    private lazy var referee = Referee(gameboard: gameboard)
    
    init(gameViewController: GameViewController, gameboard: Gameboard, gameboardView: GameboardView) {
        self.gameViewController = gameViewController
        self.gameboard = gameboard
        self.gameboardView = gameboardView
        gameViewController.secondPlayerTurnLabel.text = "Computer"
    }
    
    func pointHandler(position: GameboardPosition) {
        guard !isWaitComputer else { return }
        guard let state = self.state else { return }
        state.addMark(at: position)
        guard !hasWinner() else { return }
        guard state.isCompleted else { return }
        self.state = secondPlayerState
        self.state?.begin()
        self.isWaitComputer = true
        self.secondPlayerState?.markCompleted = { [weak self] in
            guard let self = self else { return }
            self.isWaitComputer = false
            guard !self.hasWinner() else { return }
            self.state = self.firstPlayerState
            self.state?.begin()
        }
        
    }
    
    func hasWinner() -> Bool {
        if let winner = referee.determineWinner() {
            state = GameEndedState(winner: winner, gameViewController: gameViewController)
            state?.begin()
            return true
        }
        return false
    }
    
    func initState() {
        firstPlayerState = PlayerInputState(player: Player.first, gameViewController: gameViewController, gameboard: gameboard, gameboardView: gameboardView, markViewPrototype: Player.first.markViewPrototype)
        
        secondPlayerState = ComputerInputState(player: Player.computer, gameViewController: gameViewController, gameboard: gameboard, gameboardView: gameboardView, markViewPrototype: Player.computer.markViewPrototype)
        
        self.state = firstPlayerState
        state?.begin();
    }
}
