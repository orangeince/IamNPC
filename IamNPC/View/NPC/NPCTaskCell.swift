//
//  NPCTaskCell.swift
//  IamNPC
//
//  Created by 赵少龙 on 16/8/10.
//  Copyright © 2016年 orangeince. All rights reserved.
//

import UIKit

protocol NPCTaskCellDelegate: class {
    func npcTaskCell(cell: NPCTaskCell, commitTaskAtIndex: Int)
}

protocol NPCTaskCellDataSource {
    var content: String {get}
    var bonus: Float {get}
    var completedCountDesp: String {get}
    var appearanceType: TaskAppearanceType {get}
}

class NPCTaskCell: UITableViewCell, TaskCardCollectionViewDelegate {

    weak var delegate: NPCTaskCellDelegate?
    var taskModels: [NPCTaskCellViewModel] {
        get {
            return taskCardCollectionView.taskModels
        }
        set {
            taskCardCollectionView.taskModels = newValue
            taskCardCollectionView.reloadData()
        }
    }
    @IBOutlet weak var taskCardCollectionView: TaskCardCollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        taskCardCollectionView.delegate = self
    }

    // MARK: TaskCardCollectionViewDelegate
    func taskCardCollectionView(collectionView: TaskCardCollectionView, commitTaskAtIndex idx: Int) {
        delegate?.npcTaskCell(self, commitTaskAtIndex: idx)
    }
    
    func removeItemAt(index: Int) {
        taskCardCollectionView.removeItemAt(index)
    }
    func updateItemAt(index: Int) {
        taskCardCollectionView.updateItemAt(index)
    }
}
