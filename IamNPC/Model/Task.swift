//
//  Task.swift
//  IamNPC
//
//  Created by 赵少龙 on 16/7/24.
//  Copyright © 2016年 orangeince. All rights reserved.
//

import Foundation
import RealmSwift

class NPC: Object {
    dynamic var uid: String = NSUUID().UUIDString
    dynamic var name: String = ""
    dynamic var avatar: String = ""
    //var tasks = List<Task>()
    let tasks = LinkingObjects(fromType: Task.self, property: "npc")
    
    override static func primaryKey() -> String? {
        return "uid"
    }
}

enum TaskAppearanceType: Int, IntegerLiteralConvertible {
    case Once = 0
    case Daily
    case Weekly
    case Mounthly
    
    init(integerLiteral value: Int) {
        switch value {
        case 0:
            self = Once
        case 1:
            self = Daily
        case 2:
            self = Weekly
        case 3:
            self = Mounthly
        default:
            self = Once
        }
    }
    
    var description: String {
        switch self {
        case .Once:
            return "仅一次"
        case .Daily:
            return "每天"
        case .Weekly:
            return "每周"
        case .Mounthly:
            return "每月"
        }
    }
    
    var shortDesp: String {
        switch self {
        case .Once:
            return "一"
        case .Daily:
            return "天"
        case .Weekly:
            return "周"
        case .Mounthly:
            return "月"
        }
    }
    
    var tintColor: UIColor {
        switch self {
        case .Once:
            return UIColor.RGB(203, 10, 69)
        case .Daily:
            return UIColor.RGB(149, 225, 211)
        case .Weekly:
            return UIColor.RGB(243, 129, 129)
        case .Mounthly:
            return UIColor.RGB(229, 104, 45)
        }
    }
}

class Task: Object {
    dynamic var uid: String = NSUUID().UUIDString
    dynamic var title: String = ""
    dynamic var content: String = ""
    dynamic var needCompletedCount: Int = 0         //在任务的周期内需要完成的次数
    dynamic var appearance: Int = 0                 //任务出现的周期
    dynamic var bonus: Float = 0.0                  //奖金
    dynamic var createdBy: Int = 0                  //任务创建人
    dynamic var assignTo: Int = 0                   //被指派人
    //dynamic var status: Int = 0                     //状态 0-常态(可完成,可重复) 10-终结态(已完成)
    dynamic var createdAt: NSDate = NSDate()
    
    dynamic var npc: NPC?
    //let npcs = LinkingObjects(fromType: NPC.self, property: "tasks")
    
    var appearanceType: TaskAppearanceType {
        return TaskAppearanceType(integerLiteral: appearance)
    }
    
    override static func primaryKey() -> String? {
        return "uid"
    }
    
    static func createTaskWith(data: [String: AnyObject]) {
        let realm = try! Realm()
        realm.npcWrite{
            let task = realm.create(self, value: data, update: true)
            TaskLifeCycle.pushTask(task)
        }
    }
}

class TaskLifeCycle: Object {
    dynamic var uid: String = NSUUID().UUIDString
    dynamic var id: Int = 0
    dynamic var status: Int = 0                     //任务的状态 0-常态(生命周期可运转) 10-终结态
    dynamic var reviveDate: NSDate = NSDate()       //任务的重生时间
    dynamic var totalCompletedCount: Int = 0
    dynamic var completedCount: Int = 0             //周期内任务的完成次数
    dynamic var lastCompleteDate: NSDate = NSDate() //最后一次完成任务的时间
    
    dynamic var task: Task?
    
    static func pushTask(task: Task) {
        let newItem = TaskLifeCycle()
        let realm = try! Realm()
        realm.npcWrite{
            //newItem.totalCompletedCount = task.needCompletedCount
            newItem.task = task
            newItem.metabolic()
            realm.add(newItem)
        }
    }
    
    //新陈代谢，根据任务更新生命周期
    func metabolic() {
        guard let task = task where task.appearanceType != .Once && self.status == 0 else {
            return
        }
        let now = NSDate()
        //当前时间还没有到重生时间则不更新
        if self.reviveDate.compare(now) == .OrderedDescending {
            return
        }
        let realm = try! Realm()
        realm.npcWrite{
            self.completedCount = 0
            switch task.appearanceType {
            case .Daily:
                self.reviveDate = now.tomorrow()
            case .Weekly:
                self.reviveDate = now.nextMonday()
            case .Mounthly:
                self.reviveDate = now.firstDayOfNextMonth()
            default:
                break
            }
        }
    }
    
    var shouldAppear: Bool {
        if status != 0 {
            return false
        }
        metabolic()
        if completedCount < task!.needCompletedCount {
            return true
        }
        return false
    }
    
    var completedCountDescription: String {
        return "\(completedCount)/\(task!.needCompletedCount)"
    }
    
    class func allNPCTaskOfToday() -> [(NPC, [TaskLifeCycle])] {
        let realm = try! Realm()
        var dict: [NPC: [TaskLifeCycle]] = [:]
        realm.objects(self).filter("status == 0").forEach{
            lifeCycle in
            if lifeCycle.shouldAppear {
                let npc = lifeCycle.task!.npc!
                var arr = dict[npc] ?? []
                arr.append(lifeCycle)
                dict[npc] = arr
            }
        }
        return dict.map{$0}
    }
    
    func commitTask() {
        let realm = try! Realm()
        realm.npcWrite{
            self.completedCount += 1
            self.totalCompletedCount += 1
            self.lastCompleteDate = NSDate()
            let doneRecord = realm.create(DoneRecord.self)
            doneRecord.content = self.task!.content
            doneRecord.task = self.task
            doneRecord.user = mainUser
            doneRecord.summary = "当前完成情况: \(self.completedCount)/\(self.task!.needCompletedCount)"
            if self.completedCount == self.task!.needCompletedCount {
                doneRecord.earned = self.task!.bonus
                mainUser.earned += self.task!.bonus
            }
        }
    }
    
}

class DoneRecord: Object {
    dynamic var uid: String = NSUUID().UUIDString
    dynamic var id: Int = 0
    dynamic var content: String = ""
    dynamic var earned: Float = 0.0
    dynamic var createdAt: NSDate = NSDate()
    dynamic var task: Task?
    dynamic var user: User?
    dynamic var summary: String = "" //备注信息，目前用于表示当前是第几次完成任务。如果任务要求完成3次之后才给奖励，这个就可以表示啦
}
