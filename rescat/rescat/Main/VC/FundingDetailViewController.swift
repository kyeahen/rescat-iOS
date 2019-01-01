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
class FundingDetailViewController : MXSegmentedPagerController, APIServiceCallback{
    
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
        segmentedPager.segmentedControl.selectedTitleTextAttributes = [kCTForegroundColorAttributeName : UIColor(red: 153/255, green: 0, blue: 0, alpha: 1)]
        segmentedPager.segmentedControl.selectionStyle = .fullWidthStripe
        segmentedPager.segmentedControl.selectionIndicatorColor = UIColor(red: 153/255, green: 0, blue: 0, alpha: 1)
    }
 
    override func segmentedPager(_ segmentedPager: MXSegmentedPager, titleForSectionAt index: Int) -> String {
        return ["댓글", "메뉴",][index]
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
