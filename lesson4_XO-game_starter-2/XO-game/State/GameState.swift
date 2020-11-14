//
//  GameState.swift
//  XO-game
//
//  Created by Veaceslav Chirita on 11/2/20.
//  Copyright © 2020 plasmon. All rights reserved.
//

import Foundation

protocol GameState {
    var player: Player {get}
    var gameViewController: GameViewController? {get}
    var isCompleted: Bool { get }
    func begin()
    func addMark(at position: GameboardPosition)
}
