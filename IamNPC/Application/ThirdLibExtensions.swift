//
//  ThirdLibExtensions.swift
//  IamNPC
//
//  Created by 赵少龙 on 16/7/24.
//  Copyright © 2016年 orangeince. All rights reserved.
//

import RealmSwift

extension Realm {
    func npcWrite(closure: Void -> Void) {
        do {
            if self.inWriteTransaction {
                closure()
            } else {
                try self.write(closure)
            }
        } catch {
            print("realm 数据库错误")
        }
    }
}
