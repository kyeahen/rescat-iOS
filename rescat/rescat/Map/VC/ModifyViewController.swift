//
//  ModifyViewController.swift
//  rescat
//
//  Created by jigeonho on 30/12/2018.
//  Copyright © 2018 kyeahen. All rights reserved.
//

import Foundation
import UIKit
class ModifyViewController : UIViewController{
//    @IBOutlet var modifyButton : UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
//        modifyButton.addTarget(self, action: #selector(modifiyRequestAction), for: .touchUpInside)
    }
    @objc func modifiyRequestAction(_ sender : UIButton!){
        self.dismiss(animated: true, completion: nil)
    }
}
