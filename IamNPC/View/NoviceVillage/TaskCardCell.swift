//
//  TaskCardCell.swift
//  IamNPC
//
//  Created by 赵少龙 on 16/8/16.
//  Copyright © 2016年 orangeince. All rights reserved.
//

import UIKit

protocol TaskCardCelDelegate: class {
    func taskCardCellCommitTask(cell: TaskCardCell)
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
        return taskLifeCycle.completedCountDescription
    }
    
    var appearanceType: TaskAppearanceType {
        return taskLifeCycle.task!.appearanceType
    }
}
class TaskCardCell: UICollectionViewCell {

    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var bonusLabel: UILabel!
    @IBOutlet weak var completeBtn: UIButton!
    @IBOutlet weak var appearanceTypeLabel: UILabel!
    @IBOutlet weak var appearanceTypeBackground: UIView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var appearanceTypeMaskView: UIView!
    
    weak var delegate: TaskCardCelDelegate?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        appearanceTypeMaskView.layer.masksToBounds = true
        completeBtn.layer.cornerRadius = completeBtn.frame.height / 2.0
        completeBtn.layer.masksToBounds = true
        completeBtn.layer.borderWidth = 0.5
        completeBtn.layer.borderColor = completeBtn.tintColor.CGColor
        
        appearanceTypeBackground.layer.cornerRadius = appearanceTypeBackground.frame.height / 2.0
        appearanceTypeBackground.layer.masksToBounds = true
    }
    func setupWith(dataSource: NPCTaskCellDataSource) {
        bonusLabel.text = String(format:"¥%.2f", dataSource.bonus)
        contentLabel.text = dataSource.content
        
        let appearanceType = dataSource.appearanceType
        appearanceTypeLabel.text = appearanceType.shortDesp + " " + dataSource.completedCountDesp
        appearanceTypeBackground.backgroundColor = appearanceType.tintColor
        
    }
    @IBAction func btnTouchDown(sender: UIButton) {
        changeBtnState(sender, isHightlight: true)
    }
    
    @IBAction func btnTouchCancel(sender: UIButton) {
        changeBtnState(sender, isHightlight: false)
    }
    
    @IBAction func btnDragInside(sender: UIButton) {
        changeBtnState(sender, isHightlight: true)
    }
    
    @IBAction func btnDragOutSide(sender: UIButton) {
        changeBtnState(sender, isHightlight: false)
    }
    @IBAction func commitTask(sender: UIButton) {
        delegate?.taskCardCellCommitTask(self)
        changeBtnState(sender, isHightlight: false)
    }
    
    func changeBtnState(btn: UIButton, isHightlight: Bool) {
        if isHightlight {
            btn.backgroundColor = btn.tintColor
            btn.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        } else {
            btn.backgroundColor = UIColor.whiteColor()
            btn.setTitleColor(btn.tintColor, forState: .Normal)
        }
    }
}
