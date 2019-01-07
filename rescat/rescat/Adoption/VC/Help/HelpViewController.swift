//
//  HelpViewController.swift
//  rescat
//
//  Created by 김예은 on 02/01/2019.
//  Copyright © 2019 kyeahen. All rights reserved.
//

import UIKit
import Kingfisher

class HelpViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var adoptButton: UIButton!
    @IBOutlet weak var protectButton: UIButton!
    
    var adopts: [AdoptData] = [AdoptData]() {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    var tag: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBackBtn()
        setCustomView()
        setTableView()
        
        getAdoptList(_type: 0)
    }
    
    //MARK: 뷰 요소 커스텀 세팅
    func setCustomView() {
        
        adoptButton.setTitleColor(#colorLiteral(red: 0.948010385, green: 0.566582799, blue: 0.5670218468, alpha: 1), for: .normal)
        protectButton.setTitleColor(#colorLiteral(red: 0.7567955852, green: 0.7569058537, blue: 0.7567716241, alpha: 1), for: .normal)
        
        //rightBarButtonItem 설정
        let rightButtonItem = UIBarButtonItem.init(
            image: UIImage(named: "iconNewPost"),
            style: .done,
            target: self,
            action: #selector(rightButtonAction(sender:))
        )
        
        rightButtonItem.tintColor =  #colorLiteral(red: 0.7228235006, green: 0.5803118348, blue: 0.4894829392, alpha: 1)
        self.navigationItem.rightBarButtonItem = rightButtonItem
        
    }
    
    //MARK: rightBarButtonItem Action
    //TODO: 글작성으로 이동
    @objc func rightButtonAction(sender: UIBarButtonItem) {
        
        let writeVC = UIStoryboard(name: "Adoption", bundle: nil).instantiateViewController(withIdentifier: RegisterAdoptViewController.reuseIdentifier) as! RegisterAdoptViewController
        
        self.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(writeVC, animated: true)
        self.hidesBottomBarWhenPushed = false
    }
    
    //MARK: 테이블뷰 설정
    func setTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.tableFooterView = UIView(frame: .zero)
        
        tableView.separatorColor = #colorLiteral(red: 0.9136453271, green: 0.9137768745, blue: 0.9136167169, alpha: 1)
    }
    
    @IBAction func listAction(_ sender: UIButton) {
        
        tag = sender.tag
        print("컨테이너에서\(tag)")
        if sender.tag == 0 {
            adoptButton.setTitleColor(#colorLiteral(red: 0.948010385, green: 0.566582799, blue: 0.5670218468, alpha: 1), for: .normal)
            protectButton.setTitleColor(#colorLiteral(red: 0.7567955852, green: 0.7569058537, blue: 0.7567716241, alpha: 1), for: .normal)
        }

        else {
            protectButton.setTitleColor(#colorLiteral(red: 0.948010385, green: 0.566582799, blue: 0.5670218468, alpha: 1), for: .normal)
            adoptButton.setTitleColor(#colorLiteral(red: 0.7567955852, green: 0.7569058537, blue: 0.7567716241, alpha: 1), for: .normal)
        }
        
        getAdoptList(_type: sender.tag)
    }
    

}

//MARK: TableView Extension
extension HelpViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return adopts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HelpTableViewCell.reuseIdentifier, for: indexPath) as! HelpTableViewCell
    
        if indexPath.row == 0 {
            cell.layer.addBorder(edge: .top, color:  #colorLiteral(red: 0.9136453271, green: 0.9137768745, blue: 0.9136167169, alpha: 1), thickness: 0.5)
        }
        
        cell.nameLabel.text = adopts[indexPath.row].name
        cell.contentLabel.text = adopts[indexPath.row].contents
        cell.viewLabel.text = adopts[indexPath.row].viewCount.description
        cell.catImageView.kf.setImage(with: URL(string: adopts[indexPath.row].photo.url), placeholder: UIImage())
        cell.timeLabel.text = setHours(start: adopts[indexPath.row].createdAt)
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let adoptVC = UIStoryboard(name: "Adoption", bundle: nil).instantiateViewController(withIdentifier: AdoptionViewController.reuseIdentifier) as! AdoptionViewController
        
        adoptVC.idx = adopts[indexPath.row].idx
        adoptVC.tag = tag
        
        self.navigationController?.pushViewController(adoptVC, animated: true)
    }
    
}

//MARK: Networking Extension
extension HelpViewController {
    
    func getAdoptList(_type: Int) {
        
        AdoptService.shareInstance.getAdoptList(type: _type, completion: {
            (result) in
            
            switch result {
            case .networkSuccess(let data) :
                let adoptData = data as? [AdoptData]
                
                if let resResult = adoptData {
                    self.adopts = resResult
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
