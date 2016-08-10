//
//  NPCTaskCell.swift
//  IamNPC
//
//  Created by 赵少龙 on 16/8/10.
//  Copyright © 2016年 orangeince. All rights reserved.
//

import UIKit

protocol NPCTaskCellDelegate: class {
    func actionForDoneBtnTapped(cell: NPCTaskCell)
}
protocol NPCTaskCellDataSource {
    var content: String {get}
    var bonus: Float {get}
    var completedCountDesp: String {get}
    var appearanceType: TaskAppearanceType {get}
}

struct NPCTaskCellViewModel: NPCTaskCellDataSource {
    var taskLifeCycle: TaskLifeCycle
    init(taskLifeCycle: TaskLifeCycle) {
        self.taskLifeCycle = taskLifeCycle
    }
    
    var content: String {
        return taskLifeCycle.task!.content
    }
    
    var bonus: Float {
        return taskLifeCycle.task!.bonus
    }
    
    var completedCountDesp: String {
        return "\(taskLifeCycle.completedCount)/\(taskLifeCycle.totalCompletedCount)"
    }
    
    var appearanceType: TaskAppearanceType {
        return taskLifeCycle.task!.appearanceType
    }
}

class NPCTaskCell: UITableViewCell {

    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var bonusLabel: UILabel!
    @IBOutlet weak var completedCountLabel: UILabel!
    @IBOutlet weak var appearanceTypeLabel: UILabel!
    @IBOutlet weak var doneBtn: UIButton!
    weak var delegate: NPCTaskCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setupWith(dataSource: NPCTaskCellDataSource, delegate: NPCTaskCellDelegate) {
        self.delegate = delegate
        contentLabel.text = dataSource.content
        bonusLabel.text = String(format: "¥%.2f", dataSource.bonus)
        completedCountLabel.text = dataSource.completedCountDesp
        appearanceTypeLabel.text = dataSource.appearanceType.description
    }

    @IBAction func doneBtnTapped(sender: AnyObject) {
        delegate?.actionForDoneBtnTapped(self)
    }

}
