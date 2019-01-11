//
//  FirstViewController.swift
//  rescat
//
//  Created by jigeonho on 30/12/2018.
//  Copyright © 2018 kyeahen. All rights reserved.
//

import Foundation
import UIKit
class FirstViewController : UITableViewController , APIServiceCallback {
    
    var detailData : FundingDetailModel!
    @IBOutlet var payButton : UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        print("------ funding detail ------ \(FundingDetailSegmentController.fundingIdx)")

//        payButton.addTarget(self, action: #selector(payButtonAction), for: .touchUpInside)
//payButt
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    @objc func payButtonAction( _ sender : UIButton!) {
//        let vc
        print("payment")
    }
    override func loadView(){
        print("asd")
    }
    func requestCallback(_ datas: Any, _ code: Int) {
        if code == APIServiceCode.FUNDING_DETAIL {
            detailData = datas as! FundingDetailModel
            print("funding detail model \(detailData.bankName)")
            self.loadView()
        } else { }
    }
}
