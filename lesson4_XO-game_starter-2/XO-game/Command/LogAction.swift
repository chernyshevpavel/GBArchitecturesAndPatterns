//
//  LogAction.swift
//  XO-game
//
//  Created by Veaceslav Chirita on 11/2/20.
//  Copyright © 2020 plasmon. All rights reserved.
//

import Foundation

public enum LogAction {
    case playerInput(player: Player, position: GameboardPosition)
    case gameFinished(winner: Player?)
    case restartGame
}

func Log(action: LogAction) {
    let command = Command(action: action)
    Invoker.shared.addLogCommand(command: command)
    
}
