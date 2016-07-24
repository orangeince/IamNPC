//
//  ToDo.swift
//  IamNPC
//
//  Created by 赵少龙 on 16/7/24.
//  Copyright © 2016年 orangeince. All rights reserved.
//

import RealmSwift

enum ToDoRepeatType: Int, IntegerLiteralConvertible {
    case None
    case Day
    case Week
    case Month
    case Year
    
    init(integerLiteral: Int) {
        switch integerLiteral {
        case 0:
            self = .None
        case 1:
            self = .Day
        case 2:
            self = .Week
        case 3:
            self = .Month
        case 4:
            self = .Year
        default:
            self = .None
        }
    }
}

class ToDo: Object {
    dynamic var uid: String = NSUUID().UUIDString
    dynamic var task: Task? = nil
    dynamic var bonus: Float = 0.0              //奖金
    dynamic var repeated: Int = 0
    dynamic var createAt: NSDate = NSDate()
    dynamic var completeAt: NSDate? = nil
    dynamic var deadLine: NSDate? = nil    //期限
    
    var repeatType: ToDoRepeatType {
        return ToDoRepeatType(integerLiteral: repeated)
    }
}
