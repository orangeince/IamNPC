//
//  AppConfig.swift
//  IamNPC
//
//  Created by 赵少龙 on 16/7/23.
//  Copyright © 2016年 orangeince. All rights reserved.
//

import UIKit

enum MainBoard: String {
    case Main
    case NPC
    case ToDo
    case Wallet
}

func npcViewController(board: MainBoard, identifier: String) -> UIViewController {
    let storyBoard = UIStoryboard(name: board.rawValue, bundle: nil)
    return storyBoard.instantiateViewControllerWithIdentifier(identifier)
}