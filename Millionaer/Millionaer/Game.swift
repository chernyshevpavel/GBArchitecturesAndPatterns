//
//  Records.swift
//  Millionaer
//
//  Created by Павел Чернышев on 30.10.2020.
//

import Foundation

final class Game {
    
    private let recordsCaretaker = RecordsCaretaker()
    
    static let shared = Game()
    
    var quizProcess: QuizProcess = .serial
    var gameSession: GameSession = GameSession(quizProcessSrategy: QuizSerialStrategy())
    
    private init() {
        self.records = self.recordsCaretaker.retrieveRecords()
    }
    
    public func initGameSession() -> GameSession
    {
        switch quizProcess {
        case .serial: gameSession = GameSession(quizProcessSrategy: QuizSerialStrategy())
        case .random: gameSession = GameSession(quizProcessSrategy: QuizRandomStrategy())
        }
        return gameSession
    }
    
    private(set) var records: [Record] {
        didSet {
            recordsCaretaker.save(records: self.records)
        }
    }
    
    func addRecord(_ record: Record) {
        self.records.append(record)
    }
    
    func clearRecords() {
        self.records = []
    }
    
}
