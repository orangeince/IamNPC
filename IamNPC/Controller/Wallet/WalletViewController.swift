//
//  WalletViewController.swift
//  IamNPC
//
//  Created by 赵少龙 on 16/7/23.
//  Copyright © 2016年 orangeince. All rights reserved.
//

import UIKit
import RealmSwift

class WalletProfileCell: UITableViewCell {
    
    @IBOutlet weak var earnedLabel: UILabel!
    
}

class WalletViewController: npcTableViewController {
    
    var doneRecords: [DoneRecord] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView(iTableView) {
            
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        loadData()
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return doneRecords.isEmpty ? 1 : 2
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return doneRecords.count
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier("WalletProfileCell") as! WalletProfileCell
            cell.earnedLabel.text = String(format: "已挣得：¥%.2f", mainUser.earned)
            return cell
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier("CompletedTaskListCell") as! CompletedTaskListCell
            let record = doneRecords[indexPath.row]
            cell.contentLabel.text = record.content
            cell.earnedLabel.text = String(format: "¥%.2f", mainUser.earned)
            cell.timeLabel.text = getDateDescription(record.createdAt)
            
            return cell
        }
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0.1
        } else {
            return 18
        }
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 1 {
            return "已完成任务列表"
        }
        return nil
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 160
        } else {
            return 64
        }
    }
    
    func loadData() {
        let realm = try! Realm()
        doneRecords = realm.objects(DoneRecord.self).sorted("createdAt", ascending: false).map{$0}
        iTableView.reloadData()
    }
}
