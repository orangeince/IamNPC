//
//  NewNPCViewController.swift
//  IamNPC
//
//  Created by 赵少龙 on 16/8/7.
//  Copyright © 2016年 orangeince. All rights reserved.
//

import UIKit
import RealmSwift

class NewNPCViewController: UIViewController {
    
    @IBOutlet weak var nameField: UITextField!
    var npc: NPC?

    override func viewDidLoad() {
        super.viewDidLoad()
        nameField.text = npc?.name
        self.title = "新建NPC"
    }

    @IBAction func saveBtnTapped(sender: AnyObject) {
        guard nameField.text != nil else {
            alertWith("请输入NPC的名字", inContainer: self)
            return
        }
        let realm = try! Realm()
        let name = self.nameField.text!
        realm.npcWrite{
            if let npc = self.npc {
                npc.name = name
            } else {
                realm.create(NPC.self, value: ["name": name], update: false)
            }
        }
        self.dismissViewControllerAnimated(true, completion: nil)
    }

}
