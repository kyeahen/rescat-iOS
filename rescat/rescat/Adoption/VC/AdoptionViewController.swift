//
//  AdoptionViewController.swift
//  rescat
//
//  Created by 김예은 on 02/01/2019.
//  Copyright © 2019 kyeahen. All rights reserved.
//

import UIKit
import MXSegmentedPager

class AdoptionViewController: MXSegmentedPagerController {

    var idx: Int = 0
    var tag: Int = 0
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setBackBtn()
        setTopTabBar()
        setNaviTitle(name: "입양")
        
//        btn = UIButton()
//        btn.frame = CGRect(x: 0, y: self.view.frame.height, width: 375, height: 49)
//        btn.setTitle("입양할래", for: .normal)
//        btn.backgroundColor = #colorLiteral(red: 0.948010385, green: 0.566582799, blue: 0.5670218468, alpha: 1)
//        btn.titleLabel?.textColor = UIColor.white
//        self.view.addSubview(btn)
        
    }
    
    func setCustomView() {
        if idx == 0 {
            self.navigationItem.title = "입양"
        } else {
            self.navigationItem.title = "임시보호"
        }
    }
    
    //MARK: 상단 탭바 설정
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
        
        return ["상세정보", "댓글"][index]
    }
    
    override func segmentedPager(_ segmentedPager: MXSegmentedPager, didScrollWith parallaxHeader: MXParallaxHeader) {
                print("progress \(parallaxHeader.progress)")
    }
    
    override func segmentedPager(_ segmentedPager: MXSegmentedPager, viewControllerForPageAt index: Int) -> UIViewController {
        
        if index == 0 {
            let detailVC = super.segmentedPager(segmentedPager, viewControllerForPageAt: 0) as! AdoptionDetailViewController
            
            detailVC.idx = idx
            detailVC.tag = tag
            
            return detailVC
            
        } else {
            let commnetVC = super.segmentedPager(segmentedPager, viewControllerForPageAt: 1) as! AdoptionCommentViewController
            
            commnetVC.idx = idx
            commnetVC.tag = tag
            
            return commnetVC
        }
        
    }
    
}


