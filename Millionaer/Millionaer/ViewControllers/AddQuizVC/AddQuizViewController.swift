//
//  AddQuizViewController.swift
//  Millionaer
//
//  Created by Павел Чернышев on 04.11.2020.
//

import UIKit

class AddQuizViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var countCells = 1;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        // Do any additional setup after loading the view.
    }
    
    @IBAction func addCell(_ sender: Any) {
        countCells += 1
        tableView.reloadData()
    }
    
    @IBAction func save(_ sender: Any) {
        let quizListBuider: QuizListBuilderProtocol = QuizListBuilder()
        for i in 0...countCells - 1  {
            if let cell = tableView.cellForRow(at: IndexPath(row: i, section: 0)) as? QuizTableViewCell {
                for textField in cell.textFields {
                    if (textField.tag == 0) {
                        quizListBuider.addQuestion(questionIndex: i, textField.text ?? "")
                    } else {
                        quizListBuider.addAnswer(questionIndex: i, index: textField.tag - 1, answer: textField.text ?? "")
                    }
                }
                quizListBuider.addCorrectAnswerIndex(questionIndex: i, answerIndex: cell.rightAnswerSegmentControll.selectedSegmentIndex)
            }
        }
        let quizList = quizListBuider.build()
        if quizList.count > 0 {
            let quizCarataker = QuizListCaretaker()
            quizCarataker.save(quizList: quizCarataker.retrieveQuizList() + quizList)
        }
        dismiss(animated: true)
    }

}

extension AddQuizViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.countCells
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AddQuizCell", for: indexPath) as? QuizTableViewCell else {
            return UITableViewCell()
        }
        return cell
    }
}
