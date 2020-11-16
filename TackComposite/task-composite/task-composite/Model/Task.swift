//
//  Task.swift
//  task-composite
//
//  Created by Павел Чернышев on 15.11.2020.
//

import Foundation

class Task: TaskProtocol {
    var name: String
    
    var parent: TaskProtocol?
    
    var subtasks: [TaskProtocol] = []
    
    init(name: String) {
        self.name = name
    }
}
