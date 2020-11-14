//
//  StandartMode.swift
//  XO-game
//
//  Created by Павел Чернышев on 12.11.2020.
//  Copyright © 2020 plasmon. All rights reserved.
//

import Foundation

class StandartMode: GameModeState {
    
    var state: GameState? {
        willSet {
            
        }
    }
    var gameViewController: GameViewController
    var gameboard: Gameboard
    var gameboardView: GameboardView
    var firstPlayerState: PlayerInputState?
    var secondPlayerState: PlayerInputState?
    
    private lazy var referee = Referee(gameboard: gameboard)
    
    init(gameViewController: GameViewController, gameboard: Gameboard, gameboardView: GameboardView) {
        self.gameViewController = gameViewController
        self.gameboard = gameboard
        self.gameboardView = gameboardView
    }
    
    func pointHandler(position: GameboardPosition) {
        guard let state = state else { return }
        state.addMark(at: position)
        guard state.isCompleted else { return }
        if let winner = referee.determineWinner() {
            self.state = GameEndedState(winner: winner, gameViewController: gameViewController)
            self.state?.begin()
            return
        }
        if state.player == .first {
            self.state = secondPlayerState
        } else if (state.player == .second) {
            self.state = firstPlayerState
        }
        self.state?.begin()
    }
    
    func initState() {
        firstPlayerState = PlayerInputState(player: Player.first, gameViewController: gameViewController, gameboard: gameboard, gameboardView: gameboardView, markViewPrototype: Player.first.markViewPrototype)
        
        secondPlayerState = PlayerInputState(player: Player.second, gameViewController: gameViewController, gameboard: gameboard, gameboardView: gameboardView, markViewPrototype: Player.second.markViewPrototype)
        
        self.state = firstPlayerState
        state?.begin();
    }
    
}
