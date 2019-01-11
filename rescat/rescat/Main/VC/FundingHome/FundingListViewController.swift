//
//  FundingListViewController.swift
//  rescat
//
//  Created by jigeonho on 27/12/2018.
//  Copyright © 2018 kyeahen. All rights reserved.
//

import Foundation
import UIKit
class FundingListViewController : UIViewController , APIServiceCallback{
    
    @IBOutlet var button1 : UIButton!;
    @IBOutlet var button2 : UIButton!
    @IBOutlet var listTableView : UITableView!
    var fundingList = [FundingModel]()
    var request : FundingRequest!
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        self.tabBarController?.tabBar.isHidden = false
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
//        self.tabBarController?.tabBar.isHidden = false
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setBackBtn()
        self.setNaviTitle(name: "후원할래요")
        let registerBtn = UIBarButtonItem(image: UIImage(named: "iconNewPost"), //백버튼 이미지 파일 이름에 맞게 변경해주세요.
            style: .plain,
            target: self,
            action: #selector(registerFunding))
        
        navigationItem.rightBarButtonItem = registerBtn
        navigationItem.rightBarButtonItem?.tintColor = UIColor(red: 190/255, green: 153/255, blue: 129/255, alpha: 1.0)
        navigationController?.interactivePopGestureRecognizer?.delegate = self as? UIGestureRecognizerDelegate

        listTableView.delegate = self
        listTableView.dataSource = self
        button1.tag = 0; button1.addTarget(self, action: #selector(loadViewAction), for: .touchUpInside)
        button2.tag = 1; button2.addTarget(self, action: #selector(loadViewAction), for: .touchUpInside)
        
        request = FundingRequest(self)
        request.requestList(0)
        
    }
    @objc func registerFunding(){

        
        guard let token = UserDefaults.standard.string(forKey: "token") else { return }
        
        print("register \(token)")
        if ( token == "-1" )
        {
            self.simpleAlert(title: "", message: "케어테이커 유저만 이용할 수 있습니다.")
        } else {
            guard let role = UserDefaults.standard.string(forKey: "role") else { return }
            print("role \(role)")
            if role == "MEMBER" {
                print("~~~member")
                self.simpleAlert(title: "", message: "케어테이커 유저만 이용할 수 있습니다.")
                return
            } else {
                print("~~~caretaker")

                let vc = storyboard?.instantiateViewController(withIdentifier: "FundingRegisterVC") as! FundingRegisterVC
                self.navigationController?.pushViewController(vc, animated: true)
                
            }

            
        }
    }
    @objc func loadViewAction(_ sender: UIButton!){
        if ( sender.tag == 0 ) {
            button2.setTitleColor(UIColor.rescatGray(), for: .normal)
            button1.setTitleColor(UIColor.rescatPink(), for: .normal)
        } else {
            button1.setTitleColor(UIColor.rescatGray(), for: .normal)
            button2.setTitleColor(UIColor.rescatPink(), for: .normal)
        }
        request.requestList(sender.tag)

    }
    
}
extension FundingListViewController : UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fundingList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FundingListTableViewCell", for: indexPath) as! FundingListTableViewCell
        let funding = fundingList[indexPath.row]
        cell.titleLabel.text = gsno(funding.title)
        cell.introductionLabel.text = gsno(funding.introduction)
        cell.goalmoneyLabel.text = "\(gino(funding.goalAmount).getMoney())원"
        let percentage = Float(gino(funding.currentAmount))/Float(gino(funding.goalAmount))
        UIView.animate(withDuration: 1.0) {
            cell.percentageView.setProgress(percentage, animated: true)
        }
//        print("percentage - \(funding.title) - \(percentage)")
        cell.percentageLabel.text = "\(Int(percentage*100))%"
        cell.remaindaysLabel.text = setDday(start: gsno(funding.limitAt))
        
//        print(setDday(start: gsno(funding.limitAt)))
        
        cell.percentageView.drawPercentage(Double(percentage),
                                           UIColor.rescatPer(), UIColor.rescatPink())
        cell.imgView.kf.setImage(with: URL(string: gsno(funding.mainPhoto!.url)))
        cell.bottomView.layer.borderColor = UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1.0).cgColor
        cell.bottomView.layer.borderWidth = 0.3
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = storyboard?.instantiateViewController(withIdentifier: "FundingDetailSegmentController") as! FundingDetailSegmentController
        tableView.deselectRow(at: indexPath, animated: true)
        FundingDetailSegmentController.fundingIdx = gino(fundingList[indexPath.row].idx)
        FundingDetailSegmentController.category = gino(fundingList[indexPath.row].category)

        self.navigationController?.pushViewController(vc, animated: true)

    }
    
    
    
}
extension FundingListViewController {
    func requestCallback(_ datas: Any, _ code: Int) {
        fundingList = datas as! [FundingModel]
        print(fundingList.count)
        listTableView.reloadData()
    }
}
