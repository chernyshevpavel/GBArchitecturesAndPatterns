//
//  OMarkCommand.swift
//  XO-game
//
//  Created by Павел Чернышев on 14.11.2020.
//  Copyright © 2020 plasmon. All rights reserved.
//

import Foundation

class OMarkCommand: MarkCommandProtocol {
    
    var player: Player
    
    var gameboard: Gameboard
    
    var markBefore: MarkView?
    
    var gameboardView: GameboardView
    
    var position: GameboardPosition
    
    var playerBefore: Player?
    
    init(player: Player, gameboard: Gameboard, gameboardView: GameboardView, position: GameboardPosition) {
        self.player = player
        self.gameboard = gameboard
        self.gameboardView = gameboardView
        self.position = position
    }
    
    func execute() {
        if !gameboardView.canPlaceMarkView(at: position) {
            self.markBefore = gameboardView.markViewForPosition[position]
            self.playerBefore = gameboard.getPlayer(at: position)
            gameboardView.removeMarkView(at: position)
        }
        gameboard.setPlayer(player, at: position)
        gameboardView.placeMarkView(OView(), at: position)
    }
}
