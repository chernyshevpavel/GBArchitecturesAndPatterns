//
//  TaskCaretaker.swift
//  task-composite
//
//  Created by Павел Чернышев on 16.11.2020.
//

import Foundation


final class TaskCaretaker {
    
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    
    private let key = "records"
    
    func save(records: [Task]) {
        do {
            let data = try self.encoder.encode(records)
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
