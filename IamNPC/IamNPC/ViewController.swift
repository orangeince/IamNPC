//
//  ViewController.swift
//  IamNPC
//
//  Created by 赵少龙 on 16/7/19.
//  Copyright © 2016年 orangeince. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var greetingLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func greetBtnTapped(sender: UIButton) {
        greetingLabel.hidden = false
        greetingLabel.alpha = 0.0
        let origin = greetingLabel.center
        greetingLabel.center = CGPoint(x: greetingLabel.center.x, y: 0)
        UIView.animateWithDuration(
            1.0,
            animations: {
                self.greetingLabel.alpha = 1.0
                self.greetingLabel.center = origin
            }) { (finished) in
                
        }
    }


}

