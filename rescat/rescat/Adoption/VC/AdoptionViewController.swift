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

    var idx: Int = 0 //글 번호
    var tag: Int = 0 //입양 - 임보 구분
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        print("컨테이너에서\(tag)")
        setBackBtn()
        setTopTabBar()
        setCustomView()
        setRightButton()
    }
    

    //MARK: 뷰 요소 커스텀 세팅
    func setCustomView() {
        if tag == 0 {
            setNaviTitle(name: "입양")
        } else {
            setNaviTitle(name: "임시보호")
        }
    }
    
    //MARK: rightBarButtonItem Setting
    func setRightButton() {
        
        //rightBarButtonItem 설정
        let rightButtonItem = UIBarButtonItem.init(
            image: UIImage(named: "icEtc"),
            style: .done,
            target: self,
            action: #selector(rightButtonAction(sender:))
        )
        
        rightButtonItem.tintColor =  #colorLiteral(red: 0.7685593963, green: 0.7686710954, blue: 0.7685350776, alpha: 1)
        self.navigationItem.rightBarButtonItem = rightButtonItem
    }
    
    //MARK: 신고 액션
    @objc func rightButtonAction(sender: UIBarButtonItem) {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        actionSheet.view.tintColor = #colorLiteral(red: 0.9400809407, green: 0.5585930943, blue: 0.5635480285, alpha: 1)

        actionSheet.addAction(UIAlertAction(title: "신고", style: .default, handler: { result in
            self.warnContent(idx: self.idx)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
        self.present(actionSheet, animated: true, completion: nil)
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
        
        return ["상세정보", "댓글"][index]
    }
    
    override func segmentedPager(_ segmentedPager: MXSegmentedPager, didScrollWith parallaxHeader: MXParallaxHeader) {
                //print("progress \(parallaxHeader.progress)")
    }
    
    override func segmentedPager(_ segmentedPager: MXSegmentedPager, viewControllerForPageAt index: Int) -> UIViewController {
        
        if index == 0 { //상세보기
            let detailVC = super.segmentedPager(segmentedPager, viewControllerForPageAt: 0) as! AdoptionDetailViewController
            
            detailVC.idx = idx
            detailVC.tag = tag
            
            return detailVC
            
        } else { //리뷰
            let commnetVC = super.segmentedPager(segmentedPager, viewControllerForPageAt: 1) as! AdoptionCommentViewController
            
            commnetVC.idx = idx
            commnetVC.tag = tag
            
            return commnetVC
        }
        
    }
    
}

//MARK: Networking Extension
extension AdoptionViewController {
    
    //상세보기 신고
    func warnContent(idx: Int) {
        
        DetailWarningService.shareInstance.postWarnDetail(idx: idx, params: [:], completion: { (result) in
            
            switch result {
            case .networkSuccess(_):
                self.simpleAlert(title: "", message: "해당 글을 신고하였습니다.")
                break
                
            case .accessDenied:
                self.simpleAlert(title: "", message: "자신이 작성한 글은 신고할 수 없습니다.")
                break
                
            case .networkFail :
                self.networkErrorAlert()
                
            default :
                self.simpleAlert(title: "오류", message: "다시 시도해주세요")
                break
            }
        })
    }
}


