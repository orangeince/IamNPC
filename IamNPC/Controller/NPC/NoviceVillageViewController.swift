//
//  NoviceVillageViewController.swift
//  IamNPC
//
//  Created by 赵少龙 on 16/7/24.
//  Copyright © 2016年 orangeince. All rights reserved.
//

import UIKit

class NoviceVillageViewController: npcTableViewController, NPCTaskCellDelegate {
    @IBOutlet weak var infoView: UIView!

    var dataSource: [(NPC, [TaskLifeCycle])] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView(iTableView) {
            //self.iTableView.tableHeaderView = TimeDescriptionHeaderView.loadFromNib("TimeDescriptionHeaderView") as? TimeDescriptionHeaderView
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        loadData()
    }
    
    // MARK: TableView DataSource & Delegate
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return dataSource.count
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("NPCTaskCell") as! NPCTaskCell
        let taskModels = dataSource[indexPath.section].1.map{NPCTaskCellViewModel(taskLifeCycle:$0)}
        cell.taskModels = taskModels
        cell.delegate = self
        //let taskLifeCycle = dataSource[indexPath.section].1[indexPath.row]
        //cell.setupWith(NPCTaskCellViewModel(taskLifeCycle: taskLifeCycle), delegate: self)
        return cell
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let npc = dataSource[section].0
        return npc.name
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 260
    }
    
    // MARK: NPCTaskCellDelegate
    func npcTaskCell(cell: NPCTaskCell, commitTaskAtIndex idx: Int) {
        if let indexPath = iTableView.indexPathForCell(cell) {
            var data = dataSource[indexPath.section]
            let taskLifeCycle = data.1[idx]
            taskLifeCycle.commitTask()
            if !taskLifeCycle.shouldAppear {
                data.1.removeAtIndex(idx)
                dataSource[indexPath.section] = data
                cell.removeItemAt(idx)
                if data.1.count <= 1 {
                    updateInfoView()
                }
            } else {
                cell.updateItemAt(idx)
            }
        }
    }
    
    // Class Methods
    func loadData() {
        dataSource = TaskLifeCycle.allNPCTaskOfToday()
        iTableView.reloadData()
        updateInfoView()
    }
    
    func updateInfoView() {
        if dataSource.isEmpty {
            infoView.hidden = false
            return
        }
        for data in dataSource {
            if !data.1.isEmpty {
                infoView.hidden = true
                return
            }
        }
        infoView.hidden = false
    }

}
