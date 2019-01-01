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
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        listTableView.delegate = self
        listTableView.dataSource = self
        button1.tag = 0; button1.addTarget(self, action: #selector(loadViewAction), for: .touchUpInside)
        button2.tag = 1; button2.addTarget(self, action: #selector(loadViewAction), for: .touchUpInside)
        
        request = FundingRequest(self)
        request.requestList(0)
        
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
        let percentage : Int = gino(funding.currentAmount)/gino(funding.goalAmount)
        cell.percentageLabel.text = "\(percentage)%"
        cell.remaindaysLabel.text = gsno(funding.limitAt)
        cell.percentageView.drawPercentage(Double(percentage), UIColor.rescatPink(), UIColor.rescatPer())
        cell.imgView.kf.setImage(with: URL(string: gsno(funding.mainPhoto!.url)))
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "FundingDetailViewController") as! FundingDetailViewController
        tableView.deselectRow(at: indexPath, animated: true)
        FundingDetailViewController.fundingIdx = gino(fundingList[indexPath.row].idx)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
}
extension FundingListViewController {
    func requestCallback(_ datas: Any, _ code: Int) {
        fundingList = datas as! [FundingModel]
        listTableView.reloadData()
    }
}
