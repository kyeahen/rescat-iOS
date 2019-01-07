//
//  PostBoxViewController.swift
//  rescat
//
//  Created by 김예은 on 06/01/2019.
//  Copyright © 2019 kyeahen. All rights reserved.
//

import UIKit

class PostBoxViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var post: [PostBoxListData] = [PostBoxListData]() {
        didSet {
            tableView.reloadData()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBackBtn()
        setTableView()
        getPostBoxInit()

    }
    
    func setTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    

}

//MARK: TableView Extension
extension PostBoxViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return post.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if post[indexPath.row].notification.targetType != "CAREPOST" {
            let cell = tableView.dequeueReusableCell(withIdentifier: PostBoxTableViewCell.reuseIdentifier) as! PostBoxTableViewCell
            
            cell.contentLabel.text = post[indexPath.row].notification.contents
            cell.timeLabel.text = setHours(start: post[indexPath.row].createdAt)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: PostBoxAdoptTableViewCell.reuseIdentifier) as! PostBoxAdoptTableViewCell
            
            cell.contentLabel.text = post[indexPath.row].notification.contents
            cell.timeLabel.text = setHours(start: post[indexPath.row].createdAt)
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if post[indexPath.row].notification.targetType == "CAREPOST" {
            let detailVC = UIStoryboard(name: "MyPage", bundle: nil).instantiateViewController(withIdentifier: PostBoxDetailViewController.reuseIdentifier) as! PostBoxDetailViewController
            detailVC.idx = post[indexPath.row].idx
           
        
            self.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(detailVC, animated: true)
        }
    }
    
}

//MARK: Networking Extension
extension PostBoxViewController {
    
    //우체통 조회
    func getPostBoxInit() {
        
        PostBoxListService.shareInstance.getPostBoxInit(completion: {
            (result) in
            
            switch result {
            case .networkSuccess(let data) :
                let postData = data as? [PostBoxListData]
                
                if let resResult = postData {
                    self.post = resResult
                    
                }
                break
                
            case .accessDenied :
                self.simpleAlert(title: "권한 없음", message: "회원가입 후, 이용해주세요.")
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
