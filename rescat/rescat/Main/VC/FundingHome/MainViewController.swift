//
//  MainViewController.swift
//  rescat
//
//  Created by 김예은 on 23/12/2018.
//  Copyright © 2018 kyeahen. All rights reserved.
//

import UIKit
import AACarousel
class MainViewController: UIViewController , AACarouselDelegate , APIServiceCallback{
    
    @IBOutlet var registerFundingButton: UIBarButtonItem!
    @IBOutlet var tempList : UICollectionView!
    @IBOutlet var tempTableList : UITableView!
    
    @IBOutlet var fundingListButton : UIButton!
    @IBOutlet var adoptionListButton : UIButton!

    // ------라이브러리 test 중이라 나중에 코드 정리할 예정------
    @IBOutlet var reviewImage : AACarousel!
    var titleArray = [String]()
    var photoArray = [String]()
    var fundingList = [FundingModel]()
    var fundingBannerList = [FundingBannerModel]()
//    var careList = [
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
        let request = FundingRequest(self)
        request.requestMain()
        fundingBannerList.removeAll(); photoArray.removeAll()
        request.requestFundingBannerList()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tempList.delegate = self
        tempList.dataSource = self
        tempTableList.delegate = self
        tempTableList.dataSource = self
        tempTableList.separatorStyle = .none
        
        adoptionListButton.addTarget(self, action: #selector(viewAdoptList), for: .touchUpInside)
        fundingListButton.addTarget(self, action: #selector(viewFundingList), for: .touchUpInside)
//        registerFundingButton
//        registerFundingButton.addT
        let nib1 = UINib(nibName: "FundingTableCell", bundle: nil)
        tempTableList.register(nib1, forCellReuseIdentifier: "FundingTableCell")
        let nib2 = UINib(nibName: "BannerTableCell", bundle: nil)
        tempTableList.register(nib2, forCellReuseIdentifier: "BannerTableCell")
        
        titleArray = ["picture 1","picture 2","picture 3","picture 4"]
        reviewImage.delegate = self
    }

    @objc func viewAdoptList(_ sender: UIButton!){
        print("Adopt")
    }

    @objc func viewFundingList(_ sender: UIButton! ) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "FundingListViewController") as! FundingListViewController
        self.navigationController?.pushViewController(vc, animated: true)

    }
    
    @IBAction func registerFundingAction(_ sender: Any) {
     
        let vc = storyboard?.instantiateViewController(withIdentifier: "FundingRegisterVC") as! FundingRegisterVC
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
        // Do any additional setup after loading the view.
    func downloadImages(_ url: String, _ index: Int) {
        
        //here is download images area
        let imageView = UIImageView()
        imageView.kf.setImage(with: URL(string: url)!, placeholder: nil, options: [.transition(.fade(0))], progressBlock: nil, completionHandler: { ( downloadImage, error, cacheType, url) in

            guard let image = downloadImage else { return }
            self.reviewImage.images[index] = image
        })
//        })
    }

    

    //optional method (interaction for touch image)
//    func didSelectCarouselView(_ view: AACarousel ,_ index: Int) {
//
//        let alert = UIAlertView.init(title:"Alert" , message: titleArray[index], delegate: self, cancelButtonTitle: "OK")
//        alert.show()
//
//        //startAutoScroll()
//        //stopAutoScroll()
//    }
//
    //optional method (show first image faster during downloading of all images)
    func callBackFirstDisplayView(_ imageView: UIImageView, _ url: [String], _ index: Int) {
        imageView.kf.setImage(with: URL(string: url[index]))
//        imageView.kf.setImage(with: , placeholder: UIImage.?init(named: "lunux"), options: [.transition(.fade(1))], progressBlock: nil, completionHandler: nil)
        
    }
    
    func startAutoScroll() {
        //optional method
        print("start")
        reviewImage.startScrollImageView()
        
    }
    
    func stopAutoScroll() {
        print("stop")
        //optional method
        reviewImage.stopScrollImageView()
    }
    func didSelectCarouselView(_ view: AACarousel, _ index: Int) {
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension MainViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TempCell", for: indexPath) as! TempCell
        cell.outerView.drawShadow(4)

        if ( indexPath.row == 4 ) {
            cell.imageView.isHidden = true; cell.characterLabel.isHidden = true; cell.markImageView.isHidden = true; cell.nameLabel.isHidden = true;
            cell.listButton.isHidden = false
            cell.listButton.addTarget(self, action: #selector(viewAdoptList), for: .touchUpInside)
        }
        return cell
    }
    
}
extension MainViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fundingList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "BannerTableCell", for: indexPath) as! BannerTableCell
            cell.bannerImageView.drawShadow(3)
            return cell
        } else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "FundingTableCell", for: indexPath) as! FundingTableCell
            cell.titleLabel.text = gsno(fundingList[indexPath.row].title)
            guard let photo = fundingList[indexPath.row].mainPhoto else { return cell }
            cell.backgroundImageView.kf.setImage(with: URL(string: gsno(photo.url)))
            cell.backgroundImageView.drawShadow(3)
            return cell
        }

    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 2 {
            return CGFloat(170)
        } else {
            return CGFloat(180)
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 2 {
            return
        } else {
            let vc = storyboard?.instantiateViewController(withIdentifier: "FundingDetailSegmentController") as! FundingDetailSegmentController
            FundingDetailSegmentController.fundingIdx = gino(fundingList[indexPath.row].idx)

            tableView.deselectRow(at: indexPath, animated: true)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
}
extension MainViewController {
    func requestCallback(_ datas: Any, _ code: Int) {
        if ( code == APIServiceCode.FUNDING_MAIN ) {
            fundingList = datas as! [FundingModel]
            print("fundingList model len \(fundingList.count)}")
            tempTableList.reloadData()
        } else if ( code == APIServiceCode.FUNDING_BANNER_LIST ) {
            fundingBannerList = datas as! [FundingBannerModel]
            print("fundingBannerList model len \(fundingBannerList.count)")
            for i in 0..<fundingBannerList.count {
                photoArray.append(gsno(fundingBannerList[i].photoUrl))
            }
            reviewImage.setCarouselData(paths: photoArray,  describedTitle: titleArray, isAutoScroll: true, timer: 5.0, defaultImage: nil)
            //optional methods
            reviewImage.setCarouselOpaque(layer: false, describedTitle: false, pageIndicator: false)
            reviewImage.setCarouselLayout(displayStyle: 0, pageIndicatorPositon: 2, pageIndicatorColor: nil, describedTitleColor: nil, layerColor: nil)

        }
    }
}
