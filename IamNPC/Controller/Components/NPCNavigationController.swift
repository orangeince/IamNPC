//
//  NPCNavigationController.swift
//  IamNPC
//
//  Created by 赵少龙 on 16/8/7.
//  Copyright © 2016年 orangeince. All rights reserved.
//

import UIKit

class NPCNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let textColor = UIColor.whiteColor()
        let attributes = NSDictionary(object: textColor, forKey: NSForegroundColorAttributeName) as? [String : AnyObject]
        self.navigationBar.tintColor = textColor
        self.navigationBar.titleTextAttributes = attributes
        //UINavigationBar.appearance().titleTextAttributes =  attributes
    }

    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
}
