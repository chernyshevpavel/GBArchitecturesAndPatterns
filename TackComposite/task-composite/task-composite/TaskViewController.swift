//
//  ViewController.swift
//  task-composite
//
//  Created by Павел Чернышев on 15.11.2020.
//

import UIKit

class TaskViewController: UITableViewController {
    
    var parentTask: TaskProtocol?
    var taskList: [TaskProtocol] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let nc = self.navigationController else {
            return }
        nc.navigationBar.topItem?.rightBarButtonItem = self.createAddBtn()
    }
    
    public func createAddBtn() -> UIBarButtonItem {
        return UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(test(sender:)))
    }

    @objc func test(sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Add new task", message: "Create a task.", preferredStyle: .alert)
        alert.addTextField { (tf) in }
        alert.addAction(UIAlertAction(title: NSLocalizedString("Create", comment: "Default action"), style: .default, handler: { [weak self] _ in
            if let text = alert.textFields?.first?.text, text.count > 0 {
                let task = Task(name: text)
                self?.taskList.append(task)
                self?.parentTask?.subtasks.append(task)
                self?.tableView.reloadData()
            }
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.taskList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = taskList[indexPath.row].name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let nc = self.navigationController else {
            return }
        let task = taskList[indexPath.row]
        let tvc = TaskViewController(style: self.tableView.style)
        tvc.loadView()
        nc.pushViewController(tvc, animated: false)
        tvc.navigationController?.navigationBar.topItem?.title = "\(task.name)"
        tvc.navigationController?.navigationBar.topItem?.rightBarButtonItem = tvc.createAddBtn()
        tvc.parentTask = task
        tvc.taskList = task.subtasks
    }
}

