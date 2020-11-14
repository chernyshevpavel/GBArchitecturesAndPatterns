//
//  TwoSteckInwoker.swift
//  XO-game
//
//  Created by Павел Чернышев on 14.11.2020.
//  Copyright © 2020 plasmon. All rights reserved.
//

import Foundation

class TwoStackInwoker {
    private(set) var firstStack: [MarkCommandProtocol] = []
    private(set) var secondStack: [MarkCommandProtocol] = []
    
    func addFirest(command: MarkCommandProtocol)  {
        firstStack.append(command)
    }
    
    func addSecond(command: MarkCommandProtocol)  {
        secondStack.append(command)
    }
    
    func executeByTurn() {
        let itemsCount = firstStack.count + secondStack.count
        var firstTurn = true;
        for _ in 0..<itemsCount {
            if firstStack.count == 0 {
                firstTurn = false
            }
            if secondStack.count == 0 {
                firstTurn = true
            }
            if firstTurn && firstStack.count > 0 {
                firstStack.removeFirst().execute()
            }
            if !firstTurn && secondStack.count > 0 {
                secondStack.removeFirst().execute()
            }
            firstTurn = !firstTurn
        }
    }
}
