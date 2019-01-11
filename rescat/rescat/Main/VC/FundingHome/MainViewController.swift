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
 
        let request = FundingRequest(self)
        let request2 = CarePostRequest(self)
//       self.tabBarController?.tabBar.isHidden = false
//        guard let token = UserDefaults.standard.string(forKey: "token") else { return }
//        if ( token == "-1" ){
//            print("테스트---비로그인")
//        } else {
//            guard let role = UserDefaults.standard.string(forKey: "role") else { return }
//            if ( role == "CARETAKER") {
//                print("테스트---케어테이커")
//            } else {
//                print("테스트---멤버")
//            }
//        }
        request2.getCarePostMain()
        request.requestMain()
        request.requestFundingBannerList(0); request.requestFundingBannerList(1);
        request.requestFundingBannerList(2)

        titleArray.removeAll()
        fundingBannerList.removeAll(); photoArray.removeAll()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let mileage = UserDefaults.standard.string(forKey: "mileage") else { return}
        print("마일리지 - \(mileage)")
        
        guard let token = UserDefaults.standard.string(forKey: "token") else { return }
        if token != "-1" {
            let registerBtn = UIBarButtonItem(image: UIImage(named: "iconNewPost"),
                                              style: .plain,
                                              target: self,
                                              action: #selector(registerFundingAction(_:)))
            
            navigationItem.rightBarButtonItem = registerBtn
            navigationItem.rightBarButtonItem?.tintColor = UIColor(red: 190/255, green: 153/255, blue: 129/255, alpha: 1.0)
            navigationController?.interactivePopGestureRecognizer?.delegate = self as? UIGestureRecognizerDelegate

        }
        

        
     
        self.setNaviTitle(name: "안녕, 길냥이")

        tempList.delegate = self
        tempList.dataSource = self
        tempTableList.delegate = self
        tempTableList.dataSource = self
        tempTableList.separatorStyle = .none
        
//        adoptionListButton.addTarget(self, action: #selector(viewAdoptList), for: .touchUpInside)
        fundingListButton.addTarget(self, action: #selector(viewFundingList), for: .touchUpInside)
//        registerFundingButton
//        registerFundingButton.addT
        let nib1 = UINib(nibName: "FundingTableCell", bundle: nil)
        tempTableList.register(nib1, forCellReuseIdentifier: "FundingTableCell")
        let nib2 = UINib(nibName: "BannerTableCell", bundle: nil)
        tempTableList.register(nib2, forCellReuseIdentifier: "BannerTableCell")
        
//        titleArray = ["picture 1","picture 2","picture 3","picture 4"]
        reviewImage.delegate = self
    }
    

    @objc func viewAdoptList(_ sender: UIButton!){
        
        let Adopt = UIStoryboard(name: "Adoption", bundle: nil)
        let vc = Adopt.instantiateViewController(withIdentifier: "HelpViewController") as! HelpViewController
        self.navigationController?.pushViewController(vc, animated: true)

    }

    @objc func viewFundingList(_ sender: UIButton! ) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "FundingListViewController") as! FundingListViewController
        self.navigationController?.pushViewController(vc, animated: true)

    }
    
    @objc func registerFundingAction(_ sender: UIButton!) {
     
        
        let adoption = UIStoryboard(name: "Adoption", bundle: nil)
        let vc = adoption.instantiateViewController(withIdentifier: IntroResisterViewController.reuseIdentifier) as! IntroResisterViewController

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
        
//        if ( indexPath.row == 4 ) {
//            cell.imageView.isHidden = true; cell.characterLabel.isHidden = true; cell.markImageView.isHidden = true; cell.nameLabel.isHidden = true;
//            cell.listButton.isHidden = false
//            cell.listButton.setImage(UIImage(named:"iconRescatcardMoreRound"), for: .normal)
//            cell.listButton.addTarget(self, action: #selector(viewAdoptList), for: .touchUpInside)
//        }
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
            if gino(fundingList[indexPath.row].category) == 0 {
                cell.labelImageView.image = UIImage(named:"cardLableSupport")
            } else {
                cell.labelImageView.image = UIImage(named:"cardLableProject")
            }
            cell.titleLabel.text = gsno(fundingList[indexPath.row].title)
            guard let photo = fundingList[indexPath.row].mainPhoto else { return cell }
            cell.backgroundImageView.kf.setImage(with: URL(string: gsno(photo.url)))
//            cell.backgroundImageView.roundCorner(10.0)
            cell.backgroundImageView.drawShadow(5)
            
//            cell.
            cell.backView.backgroundColor = UIColor.black ; cell.backView.alpha = 0.3
            cell.remainLabel.text = setDday(start:gsno(fundingList[indexPath.row].limitAt) ?? "")
//            cell.
            cell.contentsLabel.text = gsno(fundingList[indexPath.row].introduction)
            
            let percentage = Float(gino(fundingList[indexPath.row].currentAmount)) / Float(gino(fundingList[indexPath.row].goalAmount))
            cell.goalLabel.text = "\(Int(percentage*100))% 달성"
//            cell.stageView.drawPercentage(Double(percentage), UIColor.white, UIColor.recatBrown())
            cell.stageView.drawPercentage(Double(percentage), UIColor.rescatWhite(), UIColor(red: 110/255, green: 77/255, blue: 55/255, alpha: 1.0))
            return cell
        }

    }
    func didSelectCarouselView(_ view: AACarousel ,_ index: Int) {
        
        guard let url = URL(string: titleArray[index]) else { return }
        UIApplication.shared.open(url)

        //startAutoScroll()
        //stopAutoScroll()
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
            tableView.deselectRow(at: indexPath, animated: true)
//            UIApplication.shared.open(URL(string:"www.naver.com")!, options: [:], completionHandler: nil)
            return
        } else {
            let vc = storyboard?.instantiateViewController(withIdentifier: "FundingDetailSegmentController") as! FundingDetailSegmentController
            FundingDetailSegmentController.fundingIdx = gino(fundingList[indexPath.row].idx)
            FundingDetailSegmentController.category = gino(fundingList[indexPath.row].category)

            tableView.deselectRow(at: indexPath, animated: true)

            self.navigationController?.pushViewController(vc, animated: true)

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
                titleArray.append(gsno(fundingBannerList[i].link))
            }

            reviewImage.setCarouselData(paths: photoArray,  describedTitle: [], isAutoScroll: true, timer: 5.0, defaultImage: "https://rescat.s3.ap-northeast-2.amazonaws.com/static/1547213699228_banner.png")
            //optional methods
            reviewImage.setCarouselOpaque(layer: false, describedTitle: false, pageIndicator: false)
            reviewImage.setCarouselLayout(displayStyle: 0, pageIndicatorPositon: 2, pageIndicatorColor: UIColor(red: 242/255, green: 145/255, blue: 145/255, alpha: 1.0), describedTitleColor: nil, layerColor: nil)

        } else if ( code == APIServiceCode.FUNDING_BOTTOM_BANNER_LIST ) {
            guard let banner = datas as? [FundingBannerModel] else { return }
            mainBannerList = banner
            if ( mainBannerList.count > 0){
                let url = URL(string:gsno(mainBannerList[0].photoUrl))
                mainBannerImageView.kf.setImage(with: url)
            }
        } else if ( code == APIServiceCode.FUNDING_RANDOM_BANNER ) {
            guard let random = datas as? FundingBannerModel else { return }

            randomBanner = random
            isFirst = true
        } else if code == APIServiceCode.CARE_POST_MAIN {
            carepostList = datas as! [CarePostMainModel]
            print("care post main")
        } else if code == APIServiceCode.SERVER_ERROR {
            self.simpleAlert(title: "", message: "네트워크오류")
        }
        tempList.reloadData()
        tempTableList.reloadData()
    }
}

