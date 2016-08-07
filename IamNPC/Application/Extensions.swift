//
//  Extensions.swift
//  IamNPC
//
//  Created by 赵少龙 on 16/7/23.
//  Copyright © 2016年 orangeince. All rights reserved.
//

import UIKit

extension UIView {
    class func loadFromNib(name: String) -> UIView? {
        if let view = Bundle.loadNibNamed(name, owner: self, options: nil).first {
            return view as? UIView
        }
        return nil
    }
    
}

extension NSDate {
    func tomorrow() -> NSDate {
        return NSDate(timeInterval: 24 * 3600, sinceDate: self).midnight()
    }
    
    func nextMonday() -> NSDate {
        let calendar = NSCalendar.currentCalendar()
        let componments = calendar.components([.Weekday], fromDate: self)
        //周日是第一天。所以先-1
        var weekday = componments.weekday - 1
        if weekday == 0 {
            weekday = 7
        }
        let offset = 7 - weekday + 1
        return NSDate(timeInterval: NSTimeInterval(24 * 3600 * offset), sinceDate: self).midnight()
    }
    
    func firstDayOfNextMonth() -> NSDate {
        let calendar = NSCalendar.currentCalendar()
        let componments = calendar.components([.Month, .Year], fromDate: self)
        componments.month += 1
        return calendar.dateFromComponents(componments)!
    }
    
    func midnight() -> NSDate {
        let calendar = NSCalendar.currentCalendar()
        return calendar.dateBySettingHour(0, minute: 0, second: 0, ofDate: self, options: [.MatchStrictly])!
    }
}

