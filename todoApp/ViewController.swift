//
//  ViewController.swift
//  todoApp
//
//  Created by a111 on 2020/11/21.
//  Copyright © 2020 a111. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,AddTask,ChangeButton {
    var tasks = [Task]()
    var tasks1 = [Task]()
    var tasks2 = [Task]()
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Task.plist")
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadTasks()
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30.0
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0: return "未完成"+" \(tasks1.count)"
        case 1: return "已完成"+" \(tasks2.count)"
        default: return nil
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return tasks1.count
        case 1: return tasks2.count
        default: return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath) as! TaskCell
        if indexPath.section == 0 {
        cell.taskNameLabel.text = tasks1[indexPath.row].name
        cell.checkBox.setBackgroundImage(UIImage(named: "checkbox"), for: UIControl.State.normal)
        cell.delegate = self
        cell.indexP = indexPath.row
        cell.section = indexPath.section
        cell.tasks = tasks1
        return cell
        }else{
            cell.taskNameLabel.text = tasks2[indexPath.row].name
            cell.checkBox.setBackgroundImage(UIImage(named: "check"), for: UIControl.State.normal)
            cell.delegate = self
            cell.indexP = indexPath.row
            cell.section = indexPath.section
            cell.tasks = tasks2
            return cell
        }
    }
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            if indexPath.section == 0 {
                context.delete(tasks1[indexPath.row])
                tasks1.remove(at: indexPath.row)
            }else{
                context.delete(tasks2[indexPath.row])
                tasks2.remove(at: indexPath.row)
            }
            saveTasks()
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
        }
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! AddTaskViewController
        vc.delegate = self
    }
    func addTask(name: String) {
        let theTask = Task(context: self.context)
        theTask.name = name
        theTask.checked = false
        tasks1.append(theTask)
        tasks.append(theTask)
        saveTasks()
        tableView.reloadData()
    }
    func saveTasks() {
        if context.hasChanges{
            do {
                try context.save()
            }catch{
                let nsError = error as NSError
                print("Error in saving data!", nsError.localizedDescription)
            }
        }
    }
    func changebutton(checked: Bool, section: Int?, index: Int?) {
        switch(section){
        case 0: do {
            tasks1[index!].checked = checked
            tasks2.append(tasks1[index!])
            tasks1.remove(at: index!)
            }
        default : do {
            tasks2[index!].checked = checked
            tasks1.append(tasks2[index!])
            tasks2.remove(at: index!)
            }
                    }
        self.saveTasks()
        tableView.reloadData()
    }
    func loadTasks(with request: NSFetchRequest<Task> = Task.fetchRequest()) {
        do{
            tasks = try context.fetch(request)
        }catch{
            print("error")
        }
        tasks1 = tasks.filter({ (task: Task) ->Bool in return task.checked == false})
        tasks2 = tasks.filter({ (task: Task) ->Bool in return task.checked == true})
        tableView.reloadData()
    }
}
