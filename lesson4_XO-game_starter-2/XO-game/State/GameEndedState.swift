//
//  GameEndedState.swift
//  XO-game
//
//  Created by Veaceslav Chirita on 11/2/20.
//  Copyright © 2020 plasmon. All rights reserved.
//

import Foundation

class GameEndedState: GameState {
    var player: Player
    
    var isCompleted = false
    
    public var winner: Player?
    weak var gameViewController: GameViewController?
    
    public init(winner: Player, gameViewController: GameViewController) {
        self.player = winner
        self.winner = winner
        self.gameViewController = gameViewController
    }
    
    
    func begin() {
        Log(action: .gameFinished(winner: winner))
        
        gameViewController?.winnerLabel.isHidden = false
        
        if let winner = winner {
            gameViewController?.winnerLabel.text = getWinner(from: winner) + " won"
        } else {
            gameViewController?.winnerLabel.text = "There no is winner"
        }
        
        gameViewController?.firstPlayerTurnLabel.isHidden = true
        gameViewController?.secondPlayerTurnLabel.isHidden = true
        gameViewController?.gameOver = true
    }
    
    func addMark(at position: GameboardPosition) {}
    
    
    private func getWinner(from: Player) -> String {
        switch winner {
        case .first:
            return "1st player"
        case .second:
            return "2nd player"
        case .computer:
            return "Computer"
        case .none:
            return "There no is winner"
        }
    }
    
}
