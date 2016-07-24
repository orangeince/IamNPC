//
//  Task.swift
//  IamNPC
//
//  Created by 赵少龙 on 16/7/24.
//  Copyright © 2016年 orangeince. All rights reserved.
//

import Foundation
import RealmSwift

class Task: Object {
    dynamic var uid: String = NSUUID().UUIDString
    dynamic var title: String = ""
    dynamic var content: String = ""
    dynamic var tag: String = ""
    dynamic var completedCount: Int = 0
    dynamic var lastAssignTime: NSDate = NSDate()
    dynamic var createAt: NSDate = NSDate()
    
    override static func primaryKey() -> String? {
        return "uid"
    }
    
}
