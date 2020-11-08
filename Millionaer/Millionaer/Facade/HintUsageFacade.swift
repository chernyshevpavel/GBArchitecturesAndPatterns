//
//  HintUsageFacade.swift
//  Millionaer
//
//  Created by Павел Чернышев on 05.11.2020.
//

import Foundation
import UIKit

public class HintUsageFacade {
    var currentQuiz: Quiz
    
    init(quiz: Quiz) {
        self.currentQuiz = quiz
    }
    
    func callFriend(uiBtns: [UIButton]) {
        let randomNum = Int(arc4random_uniform(100))
        var btnIndex = currentQuiz.rightAnswerIndex
        if randomNum < 20 {
            btnIndex = random(except: currentQuiz.rightAnswerIndex)
        }
        for btn in uiBtns {
            if btn.tag == btnIndex {
                showGreenBorder(btn: btn)
            }
        }
    }
    
    func useAuditoryHelp(uiBtns: [UIButton]) {
        for btn in uiBtns {
            showBlackBorder(btn: btn)
            if (btn.tag != currentQuiz.rightAnswerIndex) {
                btn.alpha = CGFloat(Float(arc4random_uniform(50) + 30) / 100)
            }
        }
    }
    
    func use50to50Hint(uiBtns: [UIButton]) {
        let correctIndex = currentQuiz.rightAnswerIndex
        let secondAnswer = random(except: correctIndex)
        
        for btn in uiBtns {
            if (btn.tag == correctIndex || btn.tag == secondAnswer) {
                showGreenBorder(btn: btn)
            }
        }
    }
    
    private func showGreenBorder(btn: UIButton) {
        btn.layer.cornerRadius = 5
        btn.layer.borderWidth = 2
        btn.layer.borderColor = UIColor.green.cgColor
    }
    
    private func showBlackBorder(btn: UIButton) {
        btn.layer.cornerRadius = 5
        btn.layer.borderWidth = 2
        btn.layer.borderColor = UIColor.black.cgColor
    }
    
    private func random(except: Int) -> Int{
        var i = -1
        repeat {
            i = Int(arc4random_uniform(4))
        } while i == except;
        return i
    }
}
