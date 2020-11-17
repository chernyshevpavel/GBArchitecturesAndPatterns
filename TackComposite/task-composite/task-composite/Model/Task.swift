//
//  Task.swift
//  task-composite
//
//  Created by Павел Чернышев on 15.11.2020.
//

import Foundation

class Task: TaskProtocol, Codable {
    var name: String
    
    var parent: TaskProtocol?
    
    var subtasks: [TaskProtocol] = []
    
    init(name: String) {
        self.name = name
    }
    
    enum CodingKeys: String, CodingKey {
        case name
        case parent
        case subtasks
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(parent as? Task, forKey: .parent)
        try container.encode(subtasks as? [Task], forKey: .subtasks)
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        parent = try? container.decode(Task.self, forKey: .parent)
        subtasks = try container.decode([Task].self, forKey: .subtasks)
    }
}
