//
//  TaskProtocol.swift
//  task-composite
//
//  Created by Павел Чернышев on 15.11.2020.
//

import Foundation

protocol TaskProtocol {
    var name: String {get}
    var parent: TaskProtocol? {get}
    var subtasks: [TaskProtocol] {get set}
}
