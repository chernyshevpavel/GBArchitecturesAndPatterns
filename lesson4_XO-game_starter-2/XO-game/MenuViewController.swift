//
//  MenuViewController.swift
//  XO-game
//
//  Created by Павел Чернышев on 10.11.2020.
//  Copyright © 2020 plasmon. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? GameViewController else {
            return
        }
        switch segue.identifier {
        case "standartGane": destination.mode = Mode.Standart
        case "gameWithComputer": destination.mode = Mode.Computer
        case "fiveStepsMode": destination.mode = Mode.FiveSteps
        default: destination.mode = Mode.Standart
        }
    }
}
