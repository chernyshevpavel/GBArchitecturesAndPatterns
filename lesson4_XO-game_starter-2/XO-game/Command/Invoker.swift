//
//  Invoker.swift
//  XO-game
//
//  Created by Veaceslav Chirita on 11/2/20.
//  Copyright © 2020 plasmon. All rights reserved.
//

import Foundation

class Invoker {
    
    public static let shared = Invoker()
    
    private let receiver = Receiver()
    
    private let bufferSize = 5
    private var commands: [Command] = []
    
    func addLogCommand(command: Command) {
        commands.append(command)
        execute()
    }
    
    private func execute() {
        guard commands.count >= bufferSize else {
            return
        }
        
        commands.forEach { receiver.writeMessageToLog($0.logMessage) }
        commands = []
    }
    
}
