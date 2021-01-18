//
//  AddTaskViewController.swift
//  todoApp
//
//  Created by a111 on 2020/11/21.
//  Copyright © 2020 a111. All rights reserved.
//

import UIKit
import CoreData
protocol AddTask {
    func addTask(name: String)
}

class AddTaskViewController: UIViewController {

    @IBAction func addAction(_ sender: Any) {
        if taskNameOutlet.text != " " {
            delegate?.addTask(name: taskNameOutlet.text!)
            navigationController?.popViewController(animated: true)
        }
        
    }
    @IBOutlet weak var taskNameOutlet: UITextField!
    
    var delegate: AddTask?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

}
