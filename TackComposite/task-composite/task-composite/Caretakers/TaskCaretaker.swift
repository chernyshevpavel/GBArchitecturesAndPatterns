//
//  TaskCaretaker.swift
//  task-composite
//
//  Created by Павел Чернышев on 17.11.2020.
//

import Foundation


final class TaskCaretaker {
    
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    
    private let key = "tasks"
    
    func save(tasks: [Task]) {
        do {
            let data = try self.encoder.encode(tasks)
            UserDefaults.standard.set(data, forKey: key)
        } catch {
            print(error)
        }
    }
    
    func retrieveRecords() -> [Task] {
        guard let data = UserDefaults.standard.data(forKey: key) else {
            return []
        }
        do {
            return try self.decoder.decode([Task].self, from: data)
        } catch {
            print(error)
            return []
        }
    }
}
