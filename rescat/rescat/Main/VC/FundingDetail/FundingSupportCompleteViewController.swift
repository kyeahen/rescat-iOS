//
//  FundingSupportCompleteViewController.swift
//  rescat
//
//  Created by jigeonho on 09/01/2019.
//  Copyright © 2019 kyeahen. All rights reserved.
//

import Foundation
import UIKit
class FundingSupportCompleteViewController : UIViewController{
    override func viewDidLoad() {
        if FundingDetailSegmentController.category == 0 {
            self.setNaviTitle(name: "치료비 후원")
        } else {
            self.setNaviTitle(name: "프로젝트 후원")
        }
        super.viewDidLoad()
    }
    
}
