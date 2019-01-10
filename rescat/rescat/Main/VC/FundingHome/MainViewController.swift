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

    @IBOutlet weak var mainBannerImageView: UIImageView!
    @IBOutlet var reviewImage : AACarousel!
    var isFirst = false
    var titleArray = [String]()
    var photoArray = [String]()
    var fundingList = [FundingModel]()
    var fundingBannerList = [FundingBannerModel]()
    var mainBannerList = [FundingBannerModel]()
    var carepostList = [CarePostMainModel]()
    var randomBanner : FundingBannerModel!
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
        let request = FundingRequest(self)
        let request2 = CarePostRequest(self)
       
        request2.getCarePostMain()
        request.requestMain()
        request.requestFundingBannerList(0); request.requestFundingBannerList(1);
        request.requestFundingBannerList(2)

        fundingBannerList.removeAll(); photoArray.removeAll()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
//        UserDefaults.standard.set("NOT", forKey: "role")
        
        self.setNaviTitle(name: "Rescat")

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
     
        
        let adoption = UIStoryboard(name: "Adoption", bundle: nil)
        let vc = adoption.instantiateViewController(withIdentifier: IntroResisterViewController.reuseIdentifier) as! IntroResisterViewController
        self.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
        self.hidesBottomBarWhenPushed = false

        
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

    @IBAction func unwindToHomeScreen(segue: UIStoryboardSegue) {
        print("Unwind segue to home screen triggered!")
    }
}
extension MainViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return carepostList.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TempCell", for: indexPath) as! TempCell
        let care = carepostList[indexPath.row]
        if gino(care.type) == 0 {
            cell.markImageView.image = UIImage(named: "cardLableAdoption")
        } else {
            cell.markImageView.image = UIImage(named: "lableCardTemporarily")
        }
        cell.nameLabel.text = gsno(care.name)
        cell.characterLabel.text = gsno(care.contents)
        cell.imageView.roundCorner(36.0)
        cell.imageView.kf.setImage(with: URL(string:gsno(care.photo?.url)))
        cell.outerView.drawShadow(3)
        
        if ( indexPath.row == 4 ) {
            cell.imageView.isHidden = true; cell.characterLabel.isHidden = true; cell.markImageView.isHidden = true; cell.nameLabel.isHidden = true;
            cell.listButton.isHidden = false
            cell.listButton.setImage(UIImage(named:"iconRescatcardMoreRound"), for: .normal)
            cell.listButton.addTarget(self, action: #selector(viewAdoptList), for: .touchUpInside)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let adoption = UIStoryboard(name: "Adoption", bundle: nil)
        let vc = adoption.instantiateViewController(withIdentifier: "AdoptionViewController") as! AdoptionViewController
        vc.tag = gino(carepostList[indexPath.row].type)
        vc.idx = gino(carepostList[indexPath.row].idx)
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
}
extension MainViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fundingList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "BannerTableCell", for: indexPath) as! BannerTableCell
            if ( isFirst) {
                guard let url = randomBanner.photoUrl else { return cell }
//                print("random url \(url)")
                cell.bannerImageView.kf.setImage(with: URL(string: url))
                cell.bannerImageView.drawShadow(5)

            }
            return cell
        } else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "FundingTableCell", for: indexPath) as! FundingTableCell
            cell.titleLabel.text = gsno(fundingList[indexPath.row].title)
            guard let photo = fundingList[indexPath.row].mainPhoto else { return cell }
            cell.backgroundImageView.kf.setImage(with: URL(string: gsno(photo.url)))
//            cell.backgroundImageView.roundCorner(10.0)
            cell.backgroundImageView.drawShadow(5)

//            cell.
            cell.backView.backgroundColor = UIColor.black ; cell.backView.alpha = 0.3
            cell.remainLabel.text = gsno(fundingList[indexPath.row].limitAt)
//            cell.
            
            let percentage = Float(gino(fundingList[indexPath.row].currentAmount)) / Float(gino(fundingList[indexPath.row].goalAmount))
            cell.goalLabel.text = "\(Int(percentage*100))% 달성"
//            cell.stageView.drawPercentage(Double(percentage), UIColor.white, UIColor.recatBrown())
            cell.stageView.drawPercentage(Double(percentage), UIColor.rescatWhite(), UIColor.rescatBrown())
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
            UIApplication.shared.open(URL(string:"www.naver.com")!, options: [:], completionHandler: nil)
            return
        } else {
            let vc = storyboard?.instantiateViewController(withIdentifier: "FundingDetailSegmentController") as! FundingDetailSegmentController
            FundingDetailSegmentController.fundingIdx = gino(fundingList[indexPath.row].idx)
            FundingDetailSegmentController.category = gino(fundingList[indexPath.row].category)

            tableView.deselectRow(at: indexPath, animated: true)
            self.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(vc, animated: true)
            self.hidesBottomBarWhenPushed = false
        }
    }
    
    
}
extension MainViewController {
    func requestCallback(_ datas: Any, _ code: Int) {
        if ( code == APIServiceCode.FUNDING_MAIN ) {
            fundingList = datas as! [FundingModel]
//            print("fundingList model len \(fundingList.count)}")
        } else if ( code == APIServiceCode.FUNDING_BANNER_LIST ) {
            fundingBannerList = datas as! [FundingBannerModel]
//            print("fundingBannerList model len \(fundingBannerList.count)")
            for i in 0..<fundingBannerList.count {
                photoArray.append(gsno(fundingBannerList[i].photoUrl))
            }
            reviewImage.setCarouselData(paths: photoArray,  describedTitle: titleArray, isAutoScroll: true, timer: 5.0, defaultImage: nil)
            //optional methods
            reviewImage.setCarouselOpaque(layer: false, describedTitle: false, pageIndicator: false)
            reviewImage.setCarouselLayout(displayStyle: 0, pageIndicatorPositon: 2, pageIndicatorColor: nil, describedTitleColor: nil, layerColor: nil)

        } else if ( code == APIServiceCode.FUNDING_BOTTOM_BANNER_LIST ) {
            mainBannerList = datas as! [FundingBannerModel]
            let url = URL(string:gsno(mainBannerList[0].photoUrl))
            mainBannerImageView.kf.setImage(with: url)
        } else if ( code == APIServiceCode.FUNDING_RANDOM_BANNER ) {
            randomBanner = datas as! FundingBannerModel
            isFirst = true
        } else if code == APIServiceCode.CARE_POST_MAIN {
            carepostList = datas as! [CarePostMainModel]
            print("care post main")
        }
        tempList.reloadData()
        tempTableList.reloadData()
    }
}
