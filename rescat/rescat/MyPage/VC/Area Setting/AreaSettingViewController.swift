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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setBackBtn()
        setTableView()
    }
    
    //MARK: 테이블 뷰 세팅
    func setTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        
    }
    


}

extension AreaSettingViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AreaSettingTableViewCell.reuseIdentifier) as! AreaSettingTableViewCell
        
        cell.backView.isHidden = true
        
        if indexPath.row == 0 {
            cell.backView.backgroundColor = #colorLiteral(red: 0.948010385, green: 0.566582799, blue: 0.5670218468, alpha: 1)
        } else {
            cell.backView.backgroundColor = #colorLiteral(red: 0.7470303178, green: 0.5998028517, blue: 0.5045881271, alpha: 1)
        }
        cell.areaLabel.text = "서울특별시 동대문구 휘경동"
        
        return cell
    }
    
    //MARK: TableView 재정렬
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
    }
    
    
    
    
}
