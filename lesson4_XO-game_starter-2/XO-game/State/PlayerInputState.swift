//
//  PlayerInputState.swift
//  XO-game
//
//  Created by Veaceslav Chirita on 11/2/20.
//  Copyright © 2020 plasmon. All rights reserved.
//

import Foundation

class PlayerInputState: GameState {
    
    public let player: Player
    var isCompleted = false
    
    weak var gameViewController: GameViewController?
    weak var gameboard: Gameboard?
    weak var gameboardView: GameboardView?
    
    public let markViewPrototype: MarkView
    
    init(player: Player,
         gameViewController: GameViewController,
         gameboard: Gameboard,
         gameboardView: GameboardView,
         markViewPrototype: MarkView
    ) {
        self.player = player
        self.gameViewController = gameViewController
        self.gameboard = gameboard
        self.gameboardView = gameboardView
        self.markViewPrototype = markViewPrototype
    }
    
    func begin() {
        self.isCompleted = false
        if self.player == .first {
            gameViewController?.firstPlayerTurnLabel.isHidden = false
            gameViewController?.secondPlayerTurnLabel.isHidden = true
        } else if self.player == .second{
            gameViewController?.firstPlayerTurnLabel.isHidden = true
            gameViewController?.secondPlayerTurnLabel.isHidden = false
        }
        gameViewController?.winnerLabel.isHidden = true
    }
    
    func addMark(at position: GameboardPosition) {
        Log(action: .playerInput(player: player, position: position))
        
        guard let gameboardView = gameboardView, gameboardView.canPlaceMarkView(at: position)
            else { return }
        
        gameboard?.setPlayer(player, at: position)
        gameboardView.placeMarkView(markViewPrototype.copy(), at: position)
        isCompleted = true
        
        
        //MARK: До прототипа
//        let markView: MarkView
//
//        switch player {
//        case .first:
//            markView = XView()
//        case .second:
//            markView = OView()
//        }
//
//        gameboardView.placeMarkView(markView, at: position)
//        gameboard?.setPlayer(player, at: position)
//        isCompleted = true
    }
}
