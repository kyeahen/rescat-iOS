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
    static var category : Int!
    static var fundingIdx = -1 
    var fundingDetailInfo : FundingDetailModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setBackBtn()
       
        let warningBtn = UIBarButtonItem(image: UIImage(named: "icEtc"), //백버튼 이미지 파일 이름에 맞게 변경해주세요.
            style: .plain,
            target: self,
            action: #selector(warningAction(_:)))
        warningBtn.tintColor = UIColor.gray
        
        navigationItem.rightBarButtonItem = warningBtn
        navigationController?.interactivePopGestureRecognizer?.delegate = self as? UIGestureRecognizerDelegate
        
        if FundingDetailSegmentController.category == 0 {
            self.setNaviTitle(name: "치료비 후원")
        } else {
            self.setNaviTitle(name: "프로젝트 후원")
        }

        segmentedPager.backgroundColor = .white
        segmentedPager.segmentedControl.selectionIndicatorLocation = .down
        segmentedPager.segmentedControl.backgroundColor = .white
//        segmentedPager.segmentedControl.title
        segmentedPager.segmentedControl.titleTextAttributes = [kCTForegroundColorAttributeName : UIColor.gray]
        segmentedPager.segmentedControl.selectedTitleTextAttributes = [kCTForegroundColorAttributeName : UIColor(red: 190/255, green: 153/255, blue: 129/255, alpha: 1)]
//        segmentedPager.segmentedControl.titleTextAttributes = [kCTParagraphStyleAttributeName : 10]
        segmentedPager.segmentedControl.selectionStyle = .fullWidthStripe
        segmentedPager.segmentedControl.selectionIndicatorColor = UIColor(red: 190/255, green: 153/255, blue: 129/255, alpha: 1)
//        segmentedPager.segmentedControl.titleTextAttributes
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        self.tabBarController?.tabBar.isHidden = true
    }
    
    @objc func warningAction ( _ sender : UIButton! ){
        
        let actionSheet = UIAlertController(title: nil,
                                            message: nil,
                                            preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "신고", style: .default, handler: { result in
            //doSomething
            //            fundingRequest
            
        }))
        actionSheet.addAction(UIAlertAction(title: "cancel", style: .cancel, handler: nil))
        self.present(actionSheet, animated: true, completion: nil)
        
        
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
