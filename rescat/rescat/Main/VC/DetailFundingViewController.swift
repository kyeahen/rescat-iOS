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
class DetailFundingViewController :  MXSegmentedPagerController{
    override func viewDidLoad() {
        super.viewDidLoad()
        segmentedPager.backgroundColor = .white
        
        // Parallax Header
//        segmentedPager.parallaxHeader.view = headerView
//        segmentedPager.parallaxHeader.mode = .fill
//        segmentedPager.parallaxHeader.height = 382
//        segmentedPager.parallaxHeader.minimumHeight = 10
        
        // Segmented Control customization
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
}
