//
//  AreaViewController.swift
//  rescat
//
//  Created by 김예은 on 29/12/2018.
//  Copyright © 2018 kyeahen. All rights reserved.
//

import UIKit

class AreaViewController: UIViewController {
    
    @IBOutlet weak var cityTableView: UITableView!
    @IBOutlet weak var guTableView: UITableView!
    @IBOutlet weak var dongTableView: UITableView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var finishButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        setTableView()
        setCustomView()
    }
    
    //MARK: 뷰 요소 커스텀 세팅
    func setCustomView() {
        
        stackView.layer.addBorder(edge: .top, color: #colorLiteral(red: 0.9175666571, green: 0.9176985621, blue: 0.9175377488, alpha: 1), thickness: 1)
        stackView.layer.addBorder(edge: .bottom, color: #colorLiteral(red: 0.9175666571, green: 0.9176985621, blue: 0.9175377488, alpha: 1), thickness: 1)
        cityTableView.layer.addBorder(edge: .right, color: #colorLiteral(red: 0.9175666571, green: 0.9176985621, blue: 0.9175377488, alpha: 1), thickness: 1)
        guTableView.layer.addBorder(edge: .right, color: #colorLiteral(red: 0.9175666571, green: 0.9176985621, blue: 0.9175377488, alpha: 1), thickness: 1)
        
        finishButton.makeRounded(cornerRadius: 8)
    }
    
    //MARK: 테이블 뷰 세팅
    func setTableView() {
        cityTableView.dataSource = self
        cityTableView.delegate = self
        
        guTableView.dataSource = self
        guTableView.delegate = self
        
        dongTableView.dataSource = self
        dongTableView.delegate = self
    }
    

    //MARK: dismiss 액션
    @IBAction func dismissAction(_ sender: UIBarButtonItem) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
}

//MARK: TableView Extension
extension AreaViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == cityTableView {
            return 1
        } else if tableView == guTableView {
            return 2
        } else {
            return 3
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == cityTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: CityTableViewCell.reuseIdentifier, for: indexPath) as! CityTableViewCell
            
            cell.cityLabel.text = "서울"
            cell.cityLabel.makeRounded(cornerRadius: 8)
            cell.cityLabel.backgroundColor = #colorLiteral(red: 0.7965717912, green: 0.009384152479, blue: 0.1060729697, alpha: 1)
            
            return cell
        } else if tableView == guTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: GuTableViewCell.reuseIdentifier, for: indexPath) as! GuTableViewCell
            
            cell.guLabel.text = "동대문구"
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: DongTableViewCell.reuseIdentifier, for: indexPath) as! DongTableViewCell
            
            cell.dongLabel.text = "휘경동"
            
            return cell
        }
        
    }
    
    
}
