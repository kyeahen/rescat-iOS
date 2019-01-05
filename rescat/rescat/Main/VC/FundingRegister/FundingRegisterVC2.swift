//
//  FundingRegisterVC2_2.swift
//  rescat
//
//  Created by jigeonho on 05/01/2019.
//  Copyright © 2019 kyeahen. All rights reserved.
//

import Foundation
import UIKit
class FundingRegisterVC2 : UIViewController {
    static var fundingRequest = FundingRequestModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        print("\(gsno(FundingRegisterVC2.fundingRequest.title))")
    }
}
