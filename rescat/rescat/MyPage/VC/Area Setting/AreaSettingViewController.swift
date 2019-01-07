//
//  AreaSettingViewController.swift
//  rescat
//
//  Created by 김예은 on 05/01/2019.
//  Copyright © 2019 kyeahen. All rights reserved.
//

import UIKit

class AreaSettingViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var myAreas : [MyPageRegions] = [MyPageRegions]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    var dataRecieved: String? {
        willSet {
//            areaLabel.text = newValue
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setBackBtn()
        setTableView()
        getMyAreaList()
    }
    
    //MARK: 테이블 뷰 세팅
    func setTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        
    }
    
    //MARK: UnwindSegue (MyPageAreaVC -> AreaSettingVC)
    @IBAction func unwindToCare2(sender: UIStoryboardSegue) {
        if let areaVC = sender.source as? MyPageAddAreaViewController {
//            areaView.isHidden = false
//            dataRecieved = areaVC.address
        }
    }

}

extension AreaSettingViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myAreas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AreaSettingTableViewCell.reuseIdentifier) as! AreaSettingTableViewCell
        
//        cell.backView.isHidden = true
        
        if indexPath.row == 0 {
            cell.backView.backgroundColor = #colorLiteral(red: 0.948010385, green: 0.566582799, blue: 0.5670218468, alpha: 1)
        } else {
            cell.backView.backgroundColor = #colorLiteral(red: 0.7470303178, green: 0.5998028517, blue: 0.5045881271, alpha: 1)
        }
        cell.areaLabel.text = myAreas[indexPath.row].name
        
        return cell
    }
    
    //MARK: TableView 재정렬
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
    }
    
}

//MARK: Networking Extension
extension AreaSettingViewController {
    
    //유저 지역 조회
    func getMyAreaList() {
        
        GetMyPageAreaService.shareInstance.getMyAreaInit(completion: {
            (result) in
            
            switch result {
            case .networkSuccess(let data) :
                let areaData = data as? [MyPageRegions]
                
                if let resResult = areaData {
                    self.myAreas = resResult
                }
                break
                
            case .accessDenied :
                self.simpleAlert(title: "권한 없음", message: "회원가입 후, 이용할 수 있습니다.")
                break
                
            case .networkFail :
                self.networkErrorAlert()
                
            default :
                self.simpleAlert(title: "오류", message: "다시 시도해주세요")
                break
            }
        })
    }
    
    //지역 삭제
    func reportContent(idx: Int, c_id: Int) {
        
        DeleteCommentService.shareInstance.deleteComment(idx: idx, c_id: c_id, completion: { (result) in
            
            switch result {
            case .networkSuccess(_):
                self.simpleAlert(title: "성공", message: "해당 지역을 삭제하였습니다.")
                self.getMyAreaList()
                break
                
            case .accessDenied :
                self.simpleAlert(title: "권한 없음", message: "해당 댓글을 삭제할 수 없습니다.")
                
            case .networkFail :
                self.networkErrorAlert()
                
            default :
                self.simpleAlert(title: "오류", message: "다시 시도해주세요")
                break
            }
        })
    }
    
}
