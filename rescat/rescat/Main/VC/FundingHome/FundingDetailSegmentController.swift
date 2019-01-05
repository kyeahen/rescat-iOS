//
//  DetailFundingViewController.swift
//  rescat
//
//  Created by jigeonho on 29/12/2018.
//  Copyright © 2018 kyeahen. All rights reserved.
//

import Foundation
import UIKit
import MXSegmentedPager
class FundingDetailSegmentController : MXSegmentedPagerController, APIServiceCallback{
    
    var idx : Int! // funding detail idx
    static var fundingIdx = -1 
    var fundingDetailInfo : FundingDetailModel!
    override func viewDidLoad() {
        print("--- 1 ---")
        super.viewDidLoad()
        segmentedPager.backgroundColor = .white
        segmentedPager.segmentedControl.selectionIndicatorLocation = .down
        segmentedPager.segmentedControl.backgroundColor = .white
        segmentedPager.segmentedControl.titleTextAttributes = [kCTForegroundColorAttributeName : UIColor.gray]
        segmentedPager.segmentedControl.selectedTitleTextAttributes = [kCTForegroundColorAttributeName : UIColor(red: 190/255, green: 153/255, blue: 129/255, alpha: 1)]
        segmentedPager.segmentedControl.selectionStyle = .fullWidthStripe
        segmentedPager.segmentedControl.selectionIndicatorColor = UIColor(red: 190/255, green: 153/255, blue: 129/255, alpha: 1)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false

    }
 
    override func segmentedPager(_ segmentedPager: MXSegmentedPager, titleForSectionAt index: Int) -> String {
        return ["상세정보", "댓글",][index]
    }
    
    override func segmentedPager(_ segmentedPager: MXSegmentedPager, didScrollWith parallaxHeader: MXParallaxHeader) {
//        print("progress \(parallaxHeader.progress)")
    }
    func requestCallback(_ datas: Any, _ code: Int) {
//
        if ( code == APIServiceCode.FUNDING_DETAIL) {
            fundingDetailInfo = datas as! FundingDetailModel
        }
    }
}
