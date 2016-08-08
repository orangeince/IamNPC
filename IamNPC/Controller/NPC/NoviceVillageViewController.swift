//
//  NoviceVillageViewController.swift
//  IamNPC
//
//  Created by 赵少龙 on 16/7/24.
//  Copyright © 2016年 orangeince. All rights reserved.
//

import UIKit

class NoviceVillageViewController: npcTableViewController {

    var dataSource: [(NPC, [TaskLifeCycle])] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView(iTableView) {
            self.iTableView.tableHeaderView = TimeDescriptionHeaderView.loadFromNib("TimeDescriptionHeaderView") as? TimeDescriptionHeaderView
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
        return dataSource[section].1.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        //let npc = dataSource[indexPath.section]
        let taskLifeCycle = dataSource[indexPath.section].1[indexPath.row]
        cell.textLabel?.text = taskLifeCycle.task!.content
        return cell
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 32.0
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60
    }
    
    
    // Class Methods
    func loadData() {
        dataSource = TaskLifeCycle.allNPCTaskOfToday()
        iTableView.reloadData()
    }

}
