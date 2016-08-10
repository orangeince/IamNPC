//
//  npcTableViewController.swift
//  IamNPC
//
//  Created by 赵少龙 on 16/7/24.
//  Copyright © 2016年 orangeince. All rights reserved.
//

import UIKit

class npcTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var iTableView: UITableView!
    private var _tableView: UITableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: tableview dalaget datasource
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 0
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return UITableViewCell()
    }

    func setupTableView(tableView: UITableView,closure: Void -> Void) {
        _tableView = tableView
        _tableView?.dataSource = self
        _tableView?.delegate = self
        if _tableView?.style == .Plain {
            _tableView?.tableFooterView = UIView(frame: CGRectZero)
        }
        closure()
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
}
