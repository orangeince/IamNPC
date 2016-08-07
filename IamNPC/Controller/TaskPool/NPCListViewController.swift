//
//  NPCListViewController.swift
//  IamNPC
//
//  Created by 赵少龙 on 16/8/7.
//  Copyright © 2016年 orangeince. All rights reserved.
//

import RealmSwift
import UIKit

protocol NPCListViewControllerDelegate: class {
    func actionForPicked(npc: NPC)
}

class NPCListViewController: npcTableViewController {

    var NPCList: [NPC] = []
    var delegate: NPCListViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView(iTableView) {
            
        }
        self.title = "选择NPC"
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        loadData()
    }
    
    // TableView DataSource & Delegate
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return NPCList.count + 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .Default, reuseIdentifier: nil)
        if indexPath.row == 0 {
            cell.textLabel?.text = "＋新建NPC"
            cell.textLabel?.textColor = purpleColor
        } else {
            let npc = NPCList[indexPath.row - 1]
            cell.textLabel?.text = npc.name
        }
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        super.tableView(tableView, didSelectRowAtIndexPath: indexPath)
        if indexPath.row == 0 {
            let newVC = npcViewController(.TaskPool, identifier: "NewNPCViewController") as! NewNPCViewController
            self.navigationController?.pushViewController(newVC, animated: true)
        } else {
            let npc = NPCList[indexPath.row - 1]
            delegate?.actionForPicked(npc)
            self.navigationController?.popViewControllerAnimated(true)
        }
    }
    
    
    // MARK: Class Methods
    func loadData() {
        let realm = try! Realm()
        NPCList = realm.objects(NPC).map{$0}
        iTableView.reloadData()
    }

}
