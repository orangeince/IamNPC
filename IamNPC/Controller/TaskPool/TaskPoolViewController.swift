//
//  TaskPoolViewController.swift
//  IamNPC
//
//  Created by 赵少龙 on 16/7/23.
//  Copyright © 2016年 orangeince. All rights reserved.
//

import UIKit
import RealmSwift

protocol TaskCellDataSource {
    var content: String {get}
    var appearanceDesp: String {get}
    var bonus: Float {get}
}

struct TaskCellViewModel: TaskCellDataSource {
    var task: Task
    
    var content: String {
        return task.content
    }
    
    var bonus: Float {
        return task.bonus
    }
    
    var appearanceDesp: String {
        return task.appearanceType.description
    }
}

class TaskCell: UITableViewCell {
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var appearanceDespLabel: UILabel!
    @IBOutlet weak var earnedLabel: UILabel!
    
    func setupWith(datasource: TaskCellDataSource) {
        contentLabel.text = datasource.content
        appearanceDespLabel.text = datasource.appearanceDesp
        earnedLabel.text = String(format: "奖金: %.2f", datasource.bonus)
    }
}

class TaskPoolViewController: UITableViewController {

    var tasks: [Task] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "任务池"
        tableView.tableFooterView = UIView(frame: CGRectZero)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        loadData()
    }
    
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let task = tasks[indexPath.row]
        let cell = tableView.dequeueReusableCellWithIdentifier("TaskCell") as! TaskCell
        cell.setupWith(TaskCellViewModel(task: task))
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 72
    }
    
    override func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
        return .Delete
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            let alert = UIAlertController(title: "确定要删除任务吗", message: nil, preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "取消", style: .Cancel, handler: nil))
            let deleteAction = UIAlertAction(title: "确定", style: .Default, handler: {
                [weak self](action) in
                if let weakSelf = self {
                    let task = weakSelf.tasks[indexPath.row]
                    Task.remove(task)
                    weakSelf.tasks.removeAtIndex(indexPath.row)
                    tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Left)
                }
            })
            alert.addAction(deleteAction)
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
   
    // MARK: Class Methods
    func loadData() {
        let realm = try! Realm()
        tasks = realm.objects(Task.self).map{$0}
        tableView.reloadData()
    }
    

}
