//
//  NPCListViewController.swift
//  IamNPC
//
//  Created by 赵少龙 on 16/7/24.
//  Copyright © 2016年 orangeince. All rights reserved.
//

import UIKit

class NPCListViewController: npcTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView(iTableView) {
            
        }
    }
    
    // MARK: TableView DataSource & Delegate
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            let header = TimeDescriptionHeaderView.loadFromNib("TimeDescriptionHeaderView") as! TimeDescriptionHeaderView
            return header
        }
        return nil
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 32.0
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60
    }

}
