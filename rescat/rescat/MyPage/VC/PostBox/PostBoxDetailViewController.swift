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

    }

    //MARK: 입양 완료 액션
    @IBAction func adoptAction(_ sender: UIButton) {
        
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
 
                    
                }
                break
                
            case .accessDenied :
                self.simpleAlert(title: "", message: "로그인 후, 이용할 수 있습니다.")
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
