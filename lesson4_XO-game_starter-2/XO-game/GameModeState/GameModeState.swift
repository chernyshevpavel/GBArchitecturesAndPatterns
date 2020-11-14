//
//  GameModeState.swift
//  XO-game
//
//  Created by Павел Чернышев on 12.11.2020.
//  Copyright © 2020 plasmon. All rights reserved.
//

import Foundation
enum Mode {
    case Standart, Computer, FiveSteps
}

protocol GameModeState {
    var state: GameState? {get}
    func pointHandler(position: GameboardPosition)
    func initState()
}
