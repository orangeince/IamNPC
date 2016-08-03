//
//  TimeDescriptionHeaderView.swift
//  IamNPC
//
//  Created by 赵少龙 on 16/7/23.
//  Copyright © 2016年 orangeince. All rights reserved.
//

import UIKit

class TimeDescriptionHeaderView: UIView {

    @IBOutlet weak var timeLabel: UILabel!
    
    override func awakeFromNib() {
        // TODO: set timelabel
        let currentTime = getCurrentTime()
        let weekDay = weekDayFor(currentTime.weekday)
        timeLabel.text = "\(currentTime.month)月\(currentTime.day)日 \(weekDay)"
    }

}
