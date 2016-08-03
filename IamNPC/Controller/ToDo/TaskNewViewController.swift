//
//  TaskNewViewController.swift
//  IamNPC
//
//  Created by 赵少龙 on 16/7/24.
//  Copyright © 2016年 orangeince. All rights reserved.
//

import UIKit
import RealmSwift

class TaskNewViewController: UIViewController {

    @IBOutlet weak var doneBtn: UIBarButtonItem!
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var tagField: UITextField!
    @IBOutlet weak var despTextView: UITextView!
    @IBOutlet weak var despView: UIView!
    @IBOutlet weak var despLabel: UILabel!
    
    var task: Task? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        despView.layer.cornerRadius = 8
        despView.layer.borderWidth = 0.5
        despView.layer.borderColor = despLabel.textColor.CGColor
        
    }
    override func viewWillDisappear(animated: Bool) {
        prepareForDismiss()
    }

    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    // MARK: Action
    @IBAction func cancelNavBtnTapped(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func doneBtnTapped(sender: UIBarButtonItem) {
        let title = titleField.text ?? ""
        if title.isEmpty {
            let alert = UIAlertController(title: "标题不能为空", message: nil, preferredStyle: .Alert)
            let action = UIAlertAction(title: "好的", style: .Cancel, handler: nil)
            alert.addAction(action)
            self.presentViewController(alert, animated: true, completion: nil)
            return
        }
        let realm = try! Realm()
        let task = Task()
        realm.npcWrite {
            task.title = self.titleField.text!
            task.tag = self.tagField.text ?? ""
            task.content = self.despTextView.text
            realm.add(task)
            self.dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    // MARK: Class Methods
    func prepareForDismiss() {
        titleField.resignFirstResponder()
        tagField.resignFirstResponder()
        despTextView.resignFirstResponder()
    }
    
}
