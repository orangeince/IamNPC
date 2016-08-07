//
//  Constants.swift
//  IamNPC
//
//  Created by 赵少龙 on 16/7/23.
//  Copyright © 2016年 orangeince. All rights reserved.
//

import UIKit


let SharedApplication = UIApplication.sharedApplication()
let ApplicationDelegate = (SharedApplication.delegate as! AppDelegate)
let MainWindow = SharedApplication.keyWindow
let UserDefaults = NSUserDefaults.standardUserDefaults()
let Bundle = NSBundle.mainBundle()
let MainScreen = UIScreen.mainScreen()
let DefaultNotificationCenter = NSNotificationCenter.defaultCenter()

let purpleColor = UIColor(red: 255/255, green: 22/255, blue: 93/255, alpha: 1)
let lightBlueColor = UIColor(red: 62/255, green: 193/255, blue: 211/255, alpha: 1)

func getCurrentTime() -> NSDateComponents {
    let calendar = NSCalendar.currentCalendar()
    return calendar.components([.Year, .Month, .Day, .Minute, .Second, .Weekday], fromDate: NSDate())
}

func weekDayFor(day: Int) -> String {
    switch day {
    case 1:
        return "星期日"
    case 2:
        return "星期一"
    case 3:
        return "星期二"
    case 4:
        return "星期三"
    case 5:
        return "星期四"
    case 6:
        return "星期五"
    case 7:
        return "星期六"
    default:
        return "未知"
    }
}


// MARK: Colors
//rgb(1, 200, 155) 绿色，配白色好看
//rgb(210, 65, 33) 橘红，配白色
//rgb(96, 81, 70) 浅咖啡色，配白色
//rgb(48, 205, 193) 青蓝色，配白色
//rgb(18, 86, 117) 藏青色, 配白