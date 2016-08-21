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
    dynamic var earned: Float = 0.0
    dynamic var lastSettlementDate: NSDate = NSDate() //上一次结算日起
    
    static var _mainUser: User? = nil
    
    static var mainUser: User {
        get {
            if _mainUser == nil {
                let realm = try! Realm()
                if let user = realm.objects(self).first {
                    _mainUser = user
                } else {
                    _mainUser = realm.create(self, value: ["name": "BigOrange", "id": -1])
                }
            }
            return _mainUser!
        }
    }
}
