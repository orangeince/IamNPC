//
//  ToDoListViewController.swift
//  IamNPC
//
//  Created by 赵少龙 on 16/7/23.
//  Copyright © 2016年 orangeince. All rights reserved.
//

import UIKit

class ToDoListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(named: "navbtn_todo_add"),
            style: .Plain,
            target: self,
            action: #selector(newBtnTapped))
        navigationItem.rightBarButtonItem?.tintColor = UIColor.whiteColor()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(named: "navbtn_todo_history"),
            style: .Plain,
            target: nil,
            action: nil)
        navigationItem.leftBarButtonItem?.tintColor = UIColor.whiteColor()

    }
    
    
    // MARK: TableView Delegate & DataSource
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 2
        } else {
            return 1
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCellWithIdentifier("TodoCell") {
            return cell
        }
        return UITableViewCell()
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
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    // MARK: action
    func newBtnTapped() {
        let editVc = npcViewController(.ToDo, identifier: "ToDoEditViewController") as! ToDoEditViewController
        self.navigationController?.pushViewController(editVc, animated: true)
    }
    
}
