//
//  PostBoxDetailViewController.swift
//  rescat
//
//  Created by 김예은 on 08/01/2019.
//  Copyright © 2019 kyeahen. All rights reserved.
//

import UIKit

class PostBoxDetailViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var jobLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var houseLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var etcLabel: UILabel!
    
    var idx: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setBackBtn()
        getPostDetail(_idx: idx)

    }

    //MARK: 입양 완료 액션
    @IBAction func adoptAction(_ sender: UIButton) {
        postAccept(_idx: idx)
    }
    

}

//MARK: Networking Extension
extension PostBoxDetailViewController {
    
    //우체통 상세보기
    func getPostDetail(_idx: Int) {
        
        PostBoxDetailService.shareInstance.getPostBoxDetail(idx: _idx,completion: {
            (result) in
            
            switch result {
            case .networkSuccess(let data) :
                let postData = data as? PostBoxDetailData
                
                if let resResult = postData {
                    self.nameLabel.text = resResult.careApplication.name
                    self.phoneLabel.text = resResult.careApplication.phone
                    self.jobLabel.text = resResult.careApplication.job
                    self.addressLabel.text = resResult.careApplication.address
                    
                    
                    let house = resResult.careApplication.houseType
                    
                    if house == houseMapping.apart.rawValue {
                        self.houseLabel.text = "아파트"
                    } else if house == houseMapping.house.rawValue {
                        self.houseLabel.text = "주택"
                    } else if house == houseMapping.many.rawValue {
                        self.houseLabel.text = "다세대 주택"
                    } else {
                        self.houseLabel.text = "원룸"
                    }
                    
                    if resResult.careApplication.companionExperience == true {
                        self.statusLabel.text = "있음"
                    } else {
                        self.statusLabel.text = "없음"
                    }

                    self.etcLabel.text = resResult.careApplication.finalWord
                    
                }
                break
                
            case .accessDenied :
                self.simpleAlert(title: "", message: "회원가입 후, 이용할 수 있습니다.")
                break
                
            case .networkFail :
                self.networkErrorAlert()
                
            default :
                self.simpleAlert(title: "오류", message: "다시 시도해주세요")
                break
            }
        })
    }
    
    //입양 및 임보 신청 승낙
    func postAccept(_idx: Int) {
        
        
        AceceptAdoptService.shareInstance.postAccepdAdopt(idx: _idx) {
            (result) in
            
            switch result {
            case .networkSuccess(_ ):
                self.simpleAlert(title: "", message: "신청을 승낙하셨습니다")
                break
                
                
            case .accessDenied:
                self.simpleAlert(title: "", message: "신청 승낙에 대한 권한이 없습니다.")
                break
                
            case .duplicated:
                self.simpleAlert(title: "", message: "관련 글 및 신청을 찾을 수 없습니다.")
                
            case .networkFail:
                self.networkErrorAlert()
                break
                
            default:
                self.simpleAlert(title: "오류", message: "다시 시도해주세요.")
                break
            }
            
        }
    }
}
