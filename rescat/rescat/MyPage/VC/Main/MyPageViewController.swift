//
//  MyPageViewController.swift
//  rescat
//
//  Created by 김예은 on 23/12/2018.
//  Copyright © 2018 kyeahen. All rights reserved.
//

import UIKit

class MyPageViewController: UIViewController{
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var viewBottomC: NSLayoutConstraint!
    
    var secondArr = ["내가 참여한 후원글", "내가 작성한 글"]
    var thirdArr = ["정보수정", "비밀번호 변경", "문의하기", "로그아웃"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setTableView()
//        viewBottomC.constant = 0
    }
    
    func setTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }

}

//MARK: TableView Extension
extension MyPageViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerCell = tableView.dequeueReusableCell(withIdentifier: MyPageHeaderTableViewCell.reuseIdentifier) as! MyPageHeaderTableViewCell
        
        if section == 1 {
            headerCell.titleLabel.text = "내 활동"
        } else if section == 2 {
            headerCell.titleLabel.text = "계정 정보"
        } else {
            headerCell.isHidden = true
            headerCell.heightAnchor.constraint(equalToConstant: 0)
        }
        
        return headerCell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 47
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1 {
            return 2
        } else {
            return 4
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: MyAreaTableViewCell.reuseIdentifier) as! MyAreaTableViewCell
            
            cell.collectionView.reloadData()
            
            return cell
            
        }
        else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: MyPageListTableViewCell.reuseIdentifier) as! MyPageListTableViewCell
            
            cell.titleLabel.text = secondArr[indexPath.row]
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: MyPageListTableViewCell.reuseIdentifier) as! MyPageListTableViewCell
            
            cell.titleLabel.text = thirdArr[indexPath.row]
            
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        } else {
            return 47
        }
    }
    
}
