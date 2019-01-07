//
//  MyWriteAdoptViewController.swift
//  rescat
//
//  Created by 김예은 on 06/01/2019.
//  Copyright © 2019 kyeahen. All rights reserved.
//

import UIKit
import Kingfisher

class MyWriteAdoptViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var myAdopts: [MyPageAdoptData] = [MyPageAdoptData]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setTableView()
        getMyAdoptList()
    }
    
    //MARK: 테이블 뷰 세팅
    func setTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0.0, bottom: 64, right: 0.0)
        tableView.separatorColor = #colorLiteral(red: 0.9136453271, green: 0.9137768745, blue: 0.9136167169, alpha: 1)
    }

}

//MARK: TableView Extension
extension MyWriteAdoptViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myAdopts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MyWriteAdoptTableViewCell.reuseIdentifier) as! MyWriteAdoptTableViewCell
        
        cell.titleLabel.text = myAdopts[indexPath.row].name
        cell.contentLabel.text = myAdopts[indexPath.row].contents
        cell.timeLabel.text = setHours(start: myAdopts[indexPath.row].createdAt)
        cell.countLabel.text = myAdopts[indexPath.row].viewCount.description
        
        if myAdopts[indexPath.row].type == 0 {
            cell.typeLabel.text = "입양"
        } else {
            cell.typeLabel.text = "임시보호"
        }
        
        cell.adoptImageView.kf.setImage(with: URL(string: myAdopts[indexPath.row].photo.url), placeholder: UIImage())
        return cell
    }
    
    //TODO: 디테일 페이지로 이동
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = UIStoryboard(name: "Adoption", bundle: nil).instantiateViewController(withIdentifier: AdoptionViewController.reuseIdentifier) as! AdoptionViewController
        
        detailVC.idx = myAdopts[indexPath.row].idx
        detailVC.tag = myAdopts[indexPath.row].type
        
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    
    
}

//MARK: Networking Extension
extension MyWriteAdoptViewController {
    
    //내가 작성한 입양/임보 글 조회
    func getMyAdoptList() {
        
        MyPageAdoptService.shareInstance.getMyAdoptList(completion: {
            (result) in
            
            switch result {
            case .networkSuccess(let data) :
                let adoptData = data as? [MyPageAdoptData]
                
                if let resResult = adoptData {
                    self.myAdopts = resResult
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
    
}



