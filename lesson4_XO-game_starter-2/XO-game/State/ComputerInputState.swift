//
//  AIInputState.swift
//  XO-game
//
//  Created by Павел Чернышев on 10.11.2020.
//  Copyright © 2020 plasmon. All rights reserved.
//

import Foundation

class ComputerInputState: GameState {
    
    public let player: Player
    var isCompleted = false
    var markCompleted = {}
    
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
    
    func getFreePositions() -> [GameboardPosition] {
        var array: [GameboardPosition] = []
        guard let gameboardView = self.gameboardView else { return array }
        for column in 0 ..< GameboardSize.columns {
            for row in 0 ..< GameboardSize.rows {
                let boardPosition = GameboardPosition(column: column, row: row)
                if (gameboardView.canPlaceMarkView(at: boardPosition)) {
                    array.append(boardPosition)
                }
            }
        }
        return array
    }
    
    func begin() {
        isCompleted = false
        gameViewController?.firstPlayerTurnLabel.isHidden = true
        gameViewController?.secondPlayerTurnLabel.isHidden = false
        gameViewController?.winnerLabel.isHidden = true
        // thinking
        let freePositions = getFreePositions()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            if freePositions.count > 1 {
                let position = freePositions[Int(arc4random_uniform(UInt32(freePositions.count)))]
                self?.addMark(at: position)
            }
        }
    }

    
    func addMark(at position: GameboardPosition) {
        Log(action: .playerInput(player: player, position: position))
        guard let gameboardView = gameboardView, gameboardView.canPlaceMarkView(at: position)
            else { return }
        gameboard?.setPlayer(player, at: position)
        gameboardView.placeMarkView(markViewPrototype.copy(), at: position)
        isCompleted = true
        self.markCompleted()
    }
}
