//
//  ResultTableViewController.swift
//  Millionaer
//
//  Created by Павел Чернышев on 28.10.2020.
//

import UIKit

class ResultTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return Game.shared.records.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ResultCell", for: indexPath)
                let record = Game.shared.records[indexPath.row]
                let dateFormatter = DateFormatter()
                dateFormatter.dateStyle = .short
                cell.textLabel?.text = "Date: \(dateFormatter.string(from: record.date))   Score: \(record.score)"
                return cell
    }


}
