//
//  QuizTableViewCell.swift
//  Millionaer
//
//  Created by Павел Чернышев on 04.11.2020.
//

import UIKit

class QuizTableViewCell: UITableViewCell {

    
    @IBOutlet var textFields: [UITextField]!
    @IBOutlet weak var rightAnswerSegmentControll: UISegmentedControl!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func textBoxEndEditing(_ sender: Any) {
        
    }
    
    public func getTextFields() -> [UITextField] {
        return textFields
    }
    

}
