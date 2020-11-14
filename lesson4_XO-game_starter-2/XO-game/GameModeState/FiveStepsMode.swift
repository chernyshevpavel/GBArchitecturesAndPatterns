//
//  FiveStepsMode.swift
//  XO-game
//
//  Created by Павел Чернышев on 12.11.2020.
//  Copyright © 2020 plasmon. All rights reserved.
//

import Foundation

class FiveStepsMode: GameModeState {
    
    var state: GameState? {
        willSet {
            
        }
    }
    var gameViewController: GameViewController
    var gameboard: Gameboard
    var gameboardView: GameboardView
    var firstPlayerState: PlayerInputState?
    var secondPlayerState: PlayerInputState?
    var invoker = TwoStackInwoker()
    
    private lazy var referee = Referee(gameboard: gameboard)
    
    init(gameViewController: GameViewController, gameboard: Gameboard, gameboardView: GameboardView) {
        self.gameViewController = gameViewController
        self.gameboard = gameboard
        self.gameboardView = gameboardView
    }
    
    func pointHandler(position: GameboardPosition) {
        state?.addMark(at: position)
        guard let state = state else { return }
        guard state.isCompleted else { return }
        addComand(state: state, position: position)
        changeState()
        clearBoard()
        checkEndGame()
    }
    

    func initState() {
        firstPlayerState = PlayerInputState(player: Player.first, gameViewController: gameViewController, gameboard: gameboard, gameboardView: gameboardView, markViewPrototype: Player.first.markViewPrototype)
        
        secondPlayerState = PlayerInputState(player: Player.second, gameViewController: gameViewController, gameboard: gameboard, gameboardView: gameboardView, markViewPrototype: Player.second.markViewPrototype)
        
        self.state = firstPlayerState
        state?.begin();
    }
    
    private func addComand(state: GameState, position: GameboardPosition) {
        if state.player == .first {
            invoker.addFirest(command: XMarkCommand(player: state.player, gameboard: gameboard, gameboardView: gameboardView, position: position))
        } else {
            invoker.addSecond(command: OMarkCommand(player: state.player, gameboard: gameboard, gameboardView: gameboardView, position: position))
        }
    }
    
    private func changeState() {
        if invoker.firstStack.count < 5 {
            self.state = firstPlayerState
        } else {
            self.state = secondPlayerState
            self.state?.begin()
        }
    }
    
    private func clearBoard() {
        var needClear = false;
        if invoker.firstStack.count == 5 && invoker.secondStack.count == 0 {
            needClear = true
        }
        if invoker.firstStack.count == 5 && invoker.secondStack.count == 5 {
            needClear = true
        }
        if needClear {
            self.gameboardView.clear()
        }
    }
    
    private func checkEndGame() {
        if invoker.firstStack.count >= 5 && invoker.secondStack.count >= 5 {
            invoker.executeByTurn()
            if let winner = referee.determineWinner() {
                self.state = GameEndedState(winner: winner, gameViewController: gameViewController)
                self.state?.begin()
                return
            }
            let endState = GameEndedState(winner: .first, gameViewController: gameViewController)
            endState.winner = nil
            self.state = endState
            self.state?.begin()
            return
        }
    }
}
