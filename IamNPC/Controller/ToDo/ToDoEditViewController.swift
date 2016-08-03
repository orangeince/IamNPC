//
//  ToDoEditViewController.swift
//  IamNPC
//
//  Created by 赵少龙 on 16/7/24.
//  Copyright © 2016年 orangeince. All rights reserved.
//

import RealmSwift
import UIKit

protocol TaskCellDataSource {
    var title: String {get}
    var tag: String {get}
    var content: String {get}
    var completedCount: String {get}
}

struct TaskCellViewModel: TaskCellDataSource {
    var task: Task
    
    var title: String {
        return task.title
    }
    var tag: String {
        return task.tag
    }
    var completedCount: String {
        return "完成: \(task.completedCount)"
    }
    var content: String {
        return task.content
    }
    
}

class TaskCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tagLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var completedCountLabel: UILabel!
    
    func setupWith(dataSource: TaskCellDataSource) {
        titleLabel.text = dataSource.title
        tagLabel.text = dataSource.tag
        contentLabel.text = dataSource.content
        completedCountLabel.text = dataSource.completedCount
    }
}

class ToDoEditViewController: npcTableViewController {
    
    var tasks: [Task] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView(iTableView) {
            
        }
    }
    override func viewWillAppear(animated: Bool) {
        loadDatas()
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count + 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = UITableViewCell()
            cell.textLabel?.text = "＋新建任务"
            cell.textLabel?.textColor = purpleColor
            return cell
        }
        if let cell = tableView.dequeueReusableCellWithIdentifier("TaskCell") as? TaskCell {
            let task = tasks[indexPath.row - 1]
            let taskVM = TaskCellViewModel(task: task)
            cell.setupWith(taskVM)
            return cell
        }
        return UITableViewCell()
    }
    
    // MARK: Class Methods
    func loadDatas() {
        let realm = try! Realm()
        tasks = realm.objects(Task.self).map{$0}
        iTableView.reloadData()
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        super.tableView(tableView, didSelectRowAtIndexPath: indexPath)
        if indexPath.row == 0 {
            // TODO: 新建任务
            let newTaskVC = npcViewController(.ToDo, identifier: "TaskNewViewController") as! TaskNewViewController
            newTaskVC.modalTransitionStyle = .CoverVertical
            self.presentViewController(newTaskVC, animated: true, completion: nil)
            
        } else {
            // TODO: 分配ToDo
        }
    }

}
