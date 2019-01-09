//
//  MyWriteSupportViewController.swift
//  rescat
//
//  Created by 김예은 on 06/01/2019.
//  Copyright © 2019 kyeahen. All rights reserved.
//

import UIKit

class MyWriteSupportViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var mySupports: [MyPageSupportData] = [MyPageSupportData]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setTableView()
        getMySupportList()
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
        getMySupportList()
        tableView.reloadData()
        sender.endRefreshing()
    }

    
    //MARK: 상단 목록으로 올리기
    @IBAction func topAction(_ sender: UIButton) {
        tableView.setContentOffset(.zero, animated: true)
    }
    
    func progressInit(part: Int, all: Int) -> Float {
        let percent = Int (Double(part)/Double(all) * 100.0)
        let progress = Float(percent) * 0.01
        return progress
    }
    
    func percentInit(part: Int, all: Int) -> Int {
        let percent = Int (Double(part)/Double(all) * 100.0)
        return percent
    }
    
}

//MARK: TableView Extension
extension MyWriteSupportViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mySupports.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MyWriteSupportTableViewCell.reuseIdentifier) as! MyWriteSupportTableViewCell
        
        cell.titleLabel.text = mySupports[indexPath.row].title
        cell.contentLabel.text = mySupports[indexPath.row].introduction
        cell.moneyLabel.text = mySupports[indexPath.row].goalAmount.commaRepresentation
      
        cell.supportImageView.kf.setImage(with: URL(string: mySupports[indexPath.row].mainPhoto.url), placeholder: UIImage())
        
        let current = mySupports[indexPath.row].currentAmount
        let goal = mySupports[indexPath.row].goalAmount
        
        cell.percentLabel.text = percentInit(part: current, all: goal).description
        
        UIView.animate(withDuration: 1.0) {
            cell.progressView.setProgress(self.progressInit(part: current, all: goal), animated: true)
        }
        
        print(self.progressInit(part: mySupports[indexPath.row].currentAmount, all: mySupports[indexPath.row].goalAmount))
        
        return cell
    }
    
    //FIXME: 탭바 문제
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: FundingDetailSegmentController.reuseIdentifier) as! FundingDetailSegmentController
        
        detailVC.idx = mySupports[indexPath.row].idx
        
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
}

//MARK: Networking Extension
extension MyWriteSupportViewController {
    
    //내가 작성한 후원 글 조회
    func getMySupportList() {
        
        MyPageSupportService.shareInstance.getMySupportList(completion: {
            (result) in
            
            switch result {
            case .networkSuccess(let data) :
                let supportData = data as? [MyPageSupportData]
                
                if let resResult = supportData {
                    self.mySupports = resResult
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
