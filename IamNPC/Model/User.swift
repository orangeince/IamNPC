//
//  User.swift
//  IamNPC
//
//  Created by 赵少龙 on 16/8/7.
//  Copyright © 2016年 orangeince. All rights reserved.
//

import RealmSwift

class User: Object {
    dynamic var uid: String = NSUUID().UUIDString
    dynamic var id: Int = 0
    dynamic var name: String = ""
    dynamic var avatar: String = ""
}
