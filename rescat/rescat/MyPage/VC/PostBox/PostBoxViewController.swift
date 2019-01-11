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
        
        UIApplication.shared.applicationIconBadgeNumber = 0

    }
    
    override func viewWillAppear(_ animated: Bool) {
        getPostBoxInit()
    }
    
    //MARK: 테이블 뷰 세팅
    func setTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.separatorColor = #colorLiteral(red: 0.9136453271, green: 0.9137768745, blue: 0.9136167169, alpha: 1)
        
        // 테이블뷰의 스크롤 위에 새로고침이 되는 action을 추가
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(startReloadTableView(_:)), for: .valueChanged)
    }
    
    // refreshControl이 돌아갈 때 일어나는 액션
    @objc func startReloadTableView(_ sender: UIRefreshControl) {
        getPostBoxInit()
        tableView.reloadData()
        sender.endRefreshing()
    }

    

}

//MARK: TableView Extension
extension PostBoxViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return post.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if post[indexPath.row].notification.targetType != "CAREAPPLICATION" {
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
        
        if post[indexPath.row].notification.targetType == "CAREAPPLICATION" { //입양신청서
            let detailVC = UIStoryboard(name: "MyPage", bundle: nil).instantiateViewController(withIdentifier: PostBoxDetailViewController.reuseIdentifier) as! PostBoxDetailViewController
            
            detailVC.idx = post[indexPath.row].notification.idx
            detailVC.applyIdx = gino(post[indexPath.row].notification.targetIdx)
          
            self.navigationController?.pushViewController(detailVC, animated: true)
            
        } else if post[indexPath.row].notification.targetType == "CAREPOST" { //입양 글
            
            let detailVC = UIStoryboard(name: "Adoption", bundle: nil).instantiateViewController(withIdentifier: AdoptionViewController.reuseIdentifier) as! AdoptionViewController
            
            detailVC.idx = gino(post[indexPath.row].notification.targetIdx)//해당 알림에 대한 인덱스
            detailVC.tag = 0
            
            self.navigationController?.pushViewController(detailVC, animated: true)
            
        } else if post[indexPath.row].notification.targetType == "TEMPORALCAREPOST" { //임시보호 글
            let detailVC = UIStoryboard(name: "Adoption", bundle: nil).instantiateViewController(withIdentifier: AdoptionViewController.reuseIdentifier) as! AdoptionViewController
            
            detailVC.idx = gino(post[indexPath.row].notification.targetIdx)
            detailVC.tag = 1
            
            self.navigationController?.pushViewController(detailVC, animated: true)
            
        } else if post[indexPath.row].notification.targetType == "FUNDING"{
            
            let detailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: FundingDetailSegmentController.reuseIdentifier) as! FundingDetailSegmentController
            
            detailVC.idx = gino(post[indexPath.row].notification.targetIdx)
            
            self.navigationController?.pushViewController(detailVC, animated: true)
            
        } else {
            print("targetType: null")
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
}

