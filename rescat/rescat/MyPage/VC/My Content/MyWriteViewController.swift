//
//  MyWriteViewController.swift
//  rescat
//
//  Created by 김예은 on 06/01/2019.
//  Copyright © 2019 kyeahen. All rights reserved.
//

import UIKit
import MXSegmentedPager

class MyWriteViewController: MXSegmentedPagerController {
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setBackBtn()
        setTopTabBar()

    }
    
    //MARK: 상단 탭바 설정 - 라이브러리
    func setTopTabBar() {
        
        segmentedPager.backgroundColor = #colorLiteral(red: 0.9881489873, green: 0.9882906079, blue: 0.9881178737, alpha: 1)
        segmentedPager.segmentedControl.selectionIndicatorHeight = 4
        segmentedPager.segmentedControl.selectionIndicatorLocation = .down
        segmentedPager.segmentedControl.backgroundColor = UIColor.white
        segmentedPager.segmentedControl.titleTextAttributes = [kCTForegroundColorAttributeName : #colorLiteral(red: 0.447017312, green: 0.4470854402, blue: 0.4470024109, alpha: 1), NSAttributedString.Key.font: UIFont(name: AppleSDGothicNeo.SemiBold.rawValue, size: 15)]
        segmentedPager.segmentedControl.selectedTitleTextAttributes = [kCTForegroundColorAttributeName : #colorLiteral(red: 0.7345849872, green: 0.5921546817, blue: 0.4968380928, alpha: 1), NSAttributedString.Key.font: UIFont(name: AppleSDGothicNeo.SemiBold.rawValue, size: 15)]
        segmentedPager.segmentedControl.selectionStyle = .fullWidthStripe
        segmentedPager.segmentedControl.selectionIndicatorColor = #colorLiteral(red: 0.7345849872, green: 0.5921546817, blue: 0.4968380928, alpha: 1)
        
        
    }
    
    override func segmentedPager(_ segmentedPager: MXSegmentedPager, titleForSectionAt index: Int) -> String {
        
        return ["입양/임시보호", "후원"][index]
    }
    
    override func segmentedPager(_ segmentedPager: MXSegmentedPager, didScrollWith parallaxHeader: MXParallaxHeader) {
        //print("progress \(parallaxHeader.progress)")
    }
    
}



