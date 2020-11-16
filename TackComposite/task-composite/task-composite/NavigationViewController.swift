//
//  NavigationViewController.swift
//  task-composite
//
//  Created by Павел Чернышев on 15.11.2020.
//

import UIKit

class NavigationViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        guard let tvc = segue.destination as? TaskViewController else {
            return
        }
        tvc.myNVC = self
    }

}
