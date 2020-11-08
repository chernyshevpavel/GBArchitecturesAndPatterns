//
//  QuizListCaretaker.swift
//  Millionaer
//
//  Created by Павел Чернышев on 04.11.2020.
//

import Foundation

final class QuizListCaretaker {
    
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    
    private let key = "quiz_list"
    
    func save(quizList: [Quiz]) {
        do {
            let data = try self.encoder.encode(quizList)
            UserDefaults.standard.set(data, forKey: key)
        } catch {
            print(error)
        }
    }
    
    func retrieveQuizList() -> [Quiz] {
        guard let data = UserDefaults.standard.data(forKey: key) else {
            return []
        }
        do {
            return try self.decoder.decode([Quiz].self, from: data)
        } catch {
            print(error)
            return []
        }
    }
    
    func defaultList() -> [Quiz] {
        return [
            Quiz(question: "На каком инструменте, как считается, играл древнерусский певец и сказитель Боян?", answers: [
                "На гуслях",
                "На виолончели",
                "На баяне",
                "На гитаре"
            ], rightAnswerIndex: 0),
            Quiz(question: "Продолжаем игру. В какой из этих стран один из официальных языков - французский?", answers: [
                "Кения",
                "Республика Гаити",
                "Эквадор",
                "Венесуэла"
            ], rightAnswerIndex: 1),
            Quiz(question: "В каком из этих фильмов не снимался Александр Абдулов?", answers: [
                "Московские каникулы",
                "Карнавал",
                "Чародеи",
                "Убить дракона"
            ], rightAnswerIndex: 0),
            Quiz(question: "В каком году произошла Куликовская битва?", answers: [
                "1360",
                "1412",
                "1380",
                "1398"
            ], rightAnswerIndex: 2),
            Quiz(question: "Кто автор музыки к детской песенке Чунга-Чанга?", answers: [
                "Зацепин",
                "Дербенёв",
                "Шпиц",
                "Шаинский"
            ], rightAnswerIndex: 3),
            
        ]
    }
}
