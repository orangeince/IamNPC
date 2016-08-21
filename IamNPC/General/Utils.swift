//
//  Utils.swift
//  IamNPC
//
//  Created by 赵少龙 on 16/8/7.
//  Copyright © 2016年 orangeince. All rights reserved.
//

import UIKit

func alertWith(title: String, inContainer: UIViewController) {
    let alert = UIAlertController(title: title, message: nil, preferredStyle: .Alert)
    alert.addAction(UIAlertAction(title: "好的", style: .Cancel, handler: nil))
    inContainer.presentViewController(alert, animated: true, completion: nil)
}

func getDateDescription(date: NSDate) -> String {
    let dateFormatter = NSDateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    dateFormatter.locale = NSLocale.currentLocale()
    return dateFormatter.stringFromDate(date)
}
