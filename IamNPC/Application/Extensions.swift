//
//  Extensions.swift
//  IamNPC
//
//  Created by 赵少龙 on 16/7/23.
//  Copyright © 2016年 orangeince. All rights reserved.
//

import UIKit

extension UIView {
    class func loadFromNib(name: String) -> UIView? {
        if let view = Bundle.loadNibNamed(name, owner: self, options: nil).first {
            return view as? UIView
        }
        return nil
    }
    
}

