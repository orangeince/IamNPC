//
//  TaskCardCollectionView.swift
//  IamNPC
//
//  Created by 赵少龙 on 16/8/16.
//  Copyright © 2016年 orangeince. All rights reserved.
//

import UIKit

protocol TaskCardCollectionViewDelegate: class {
    func taskCardCollectionView(collectionView: TaskCardCollectionView, commitTaskAtIndex: Int)
}

class TaskCardCollectionView: UIView, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, TaskCardCelDelegate {

    var collectionView: UICollectionView!
    var taskModels: [NPCTaskCellViewModel] = [] 
    weak var delegate: TaskCardCollectionViewDelegate?
    override func awakeFromNib() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .Horizontal
        collectionView = UICollectionView(frame: self.frame, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = UIColor.whiteColor()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.registerNib(UINib(nibName: "TaskCardCell", bundle: nil), forCellWithReuseIdentifier: "TaskCardCell")
        self.addSubview(collectionView)
    }
    
    override func layoutSubviews() {
        collectionView.frame = self.bounds
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return taskModels.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("TaskCardCell", forIndexPath: indexPath) as! TaskCardCell
        let taskModel = taskModels[indexPath.row]
        cell.setupWith(taskModel)
        cell.delegate = self
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: 200, height: 240)
    }
    // MARK: TaskCardCelDelegate
    func taskCardCellCommitTask(cell: TaskCardCell) {
        if let idx = collectionView.indexPathForCell(cell) {
            delegate?.taskCardCollectionView(self, commitTaskAtIndex: idx.item)
        }
    }
    
    // MARK: Class Methods
    func reloadData() {
        collectionView.reloadData()
    }
    
    func removeItemAt(index: Int) {
        taskModels.removeAtIndex(index)
        let indexPath = NSIndexPath(forItem: index, inSection: 0)
        collectionView.deleteItemsAtIndexPaths([indexPath])
    }
    
    func updateItemAt(index: Int) {
        let indexPath = NSIndexPath(forItem: index, inSection: 0)
        collectionView.reloadItemsAtIndexPaths([indexPath])
    }
}
