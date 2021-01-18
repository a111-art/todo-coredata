//
//  TaskCell.swift
//  todoApp
//
//  Created by a111 on 2020/11/21.
//  Copyright © 2020 a111. All rights reserved.
//

import UIKit
import CoreData
protocol ChangeButton {
    func changebutton(checked: Bool, section: Int?, index: Int?)
}
class TaskCell: UITableViewCell {
    var delegate: ChangeButton?
    var indexP: Int?
    var section: Int?
    var tasks = [Task]()
    
    @IBOutlet weak var checkBox: UIButton!
    @IBOutlet weak var taskNameLabel: UILabel!
    @IBAction func checkBoxAction(_ sender: Any) {
        if (tasks[indexP!].checked) {
                delegate?.changebutton(checked: false, section: section!, index: indexP!)
          } else {
                delegate?.changebutton(checked: true, section: section!, index: indexP!)
        }
        
     }
    }
    


