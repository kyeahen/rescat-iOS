//
//  BBB.swift
//  rescat
//
//  Created by jigeonho on 08/01/2019.
//  Copyright © 2019 kyeahen. All rights reserved.
//

import Foundation
import UIKit
class BBB : UIViewController {
    @IBOutlet var outer : UIView!
    @IBOutlet var first : UIView!
    @IBOutlet var second : UIView!
    @IBOutlet var myscroll : UIScrollView!
    @IBAction func change ( _ sender : UIButton! ){
        if sender.tag == 0 {
//
                myscroll.frame = CGRect(x: 0, y: 0, width: 375, height: 667)
            myscroll.contentSize = CGSize(width: 375, height: 1000) // You can set height, whatever you want.

            
        } else {
            myscroll.frame = CGRect(x: 0, y: 0, width: 375, height: 1000)
            myscroll.contentSize = CGSize(width: 375, height: 2000) // You can set height, whatever you want.

        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
