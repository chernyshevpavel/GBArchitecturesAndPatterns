//
//  FiveStepsModeCommand.swift
//  XO-game
//
//  Created by Павел Чернышев on 14.11.2020.
//  Copyright © 2020 plasmon. All rights reserved.
//

import Foundation
protocol MarkCommandProtocol {
    var player: Player { get }
    var gameboard: Gameboard { get }
    var gameboardView: GameboardView { get }
    var position: GameboardPosition { get }
    var markBefore: MarkView? { get }
    var playerBefore: Player? { get }
    
    func execute()
    func undo()
}

extension MarkCommandProtocol {
    
    func undo() {
        gameboardView.removeMarkView(at: position)
        if let markBefore = markBefore, let playerBefore = playerBefore {
            gameboardView.placeMarkView(markBefore, at: position)
            gameboard.setPlayer(playerBefore, at: position)
        }
    }
}
