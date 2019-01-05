//
//  SearchCatViewController.swift
//  rescat
//
//  Created by 김예은 on 05/01/2019.
//  Copyright © 2019 kyeahen. All rights reserved.
//

import UIKit

class SearchCatViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setTableView()
    }
    
    //MARK: 테이블 뷰 세팅
    func setTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    //MARK: 고양이 검색 액션
    @IBAction func searchAction(_ sender: UIButton) {
    }
    
    
}

//MAKK: TableView Extension
extension SearchCatViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerCell = tableView.dequeueReusableCell(withIdentifier: SearchHeaderTableViewCell.reuseIdentifier) as! SearchHeaderTableViewCell
        
        headerCell.typeLabel.text = "고양이 종"
        
        return headerCell
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchListTableViewCell.reuseIdentifier) as! SearchListTableViewCell
        
        cell.catLabel.text = "말티즈"
        
        return cell
    }
    
    //TODO: 고양이 선택 값 이전 뷰로 전달(unwind)
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let cell = UIStoryboard(name: "Adopt", bundle: nil).instantiateViewController(withIdentifier: RegisterAdoptViewController.reuseIdentifier)
        
        
    }
    
}
