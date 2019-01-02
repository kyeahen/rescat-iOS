//
//  AdoptionCommentViewController.swift
//  rescat
//
//  Created by 김예은 on 02/01/2019.
//  Copyright © 2019 kyeahen. All rights reserved.
//

import UIKit

class AdoptionCommentViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var adoptButton: UIButton!
    
    var comments: [AdoptCommentData] = [AdoptCommentData]() {
        didSet {
            self.tableView.reloadData()
        }
    }
    var idx: Int = 0
    var tag: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setTableView()
        getAdoptComment(_idx: idx)
        
    }
    
    //MARK: 뷰 요소 커스텀 세팅
    func setCustomView() {
        if tag == 0 {
            adoptButton.setTitle("입양할래요", for: .normal)
        } else {
            adoptButton.setTitle("임보할래요", for: .normal)
        }
    }
    
    //MARK: 테이블 뷰 세팅
    func setTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.tableFooterView = UIView(frame: .zero)
        
        //TODO: 더 나은 방법 생각해보기
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0.0, bottom: 64, right: 0.0)
    }
        
        
    
}

//MARK: TableView Extension
extension AdoptionCommentViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    
    //TODO: 케어테이커이면 이미지 첨부 예외처리, 디데이 계산
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CommentTableViewCell.reuseIdentifier, for: indexPath) as! CommentTableViewCell
        
        let role = comments[indexPath.row].userRole
        if role == careMapping.care.rawValue {
            cell.iconImageView.isHidden = false
            cell.iconImageView.image = UIImage(named: "icMapCat")
        } else {
            cell.iconImageView.isHidden = true
        }
        
        cell.nickNameLabel.text = comments[indexPath.row].nickname
        cell.timeLabel.text = setDate(createdAt: comments[indexPath.row].createdAt, format: "MM/dd   HH:mm")
        cell.contentLabel.text = comments[indexPath.row].contents
        
        return cell
    }

    
}

//MARK: Networking Extension
extension AdoptionCommentViewController {
    
    func getAdoptComment(_idx: Int) {
        
        AdoptCommentService.shareInstance.getAdoptComment(idx: _idx, completion: {
            (result) in
            
            switch result {
            case .networkSuccess(let data) :
                let commentData = data as? [AdoptCommentData]
                
                if let resResult = commentData {
                    self.comments = resResult
                    self.tableView.reloadData()
                }
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
