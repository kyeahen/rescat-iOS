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
    
    @IBOutlet var tempList : UICollectionView!
    @IBOutlet var tempTableList : UITableView!
    
    @IBOutlet var fundingListButton : UIButton!
    @IBOutlet var adoptionListButton : UIButton!

    // ------라이브러리 test 중이라 나중에 코드 정리할 예정------
    @IBOutlet var reviewImage : AACarousel!
    var titleArray = [String]()
    var fundingList = [FundingModel]()
//    var careList = [
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        
        let request = FundingRequest(self)
        request.requestMain()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tempList.delegate = self
        tempList.dataSource = self
        tempTableList.delegate = self
        tempTableList.dataSource = self
        
        adoptionListButton.addTarget(self, action: #selector(viewAdoptList), for: .touchUpInside)
        fundingListButton.addTarget(self, action: #selector(viewFundingList), for: .touchUpInside)
        
        let nib1 = UINib(nibName: "FundingTableCell", bundle: nil)
        tempTableList.register(nib1, forCellReuseIdentifier: "FundingTableCell")
        let nib2 = UINib(nibName: "BannerTableCell", bundle: nil)
        tempTableList.register(nib2, forCellReuseIdentifier: "BannerTableCell")
        
        let pathArray = ["https://imgct2.aeplcdn.com/img/800x600/car-data/big/honda-amaze-image-12749.png",
                         "https://ak.picdn.net/assets/cms/97e1dd3f8a3ecb81356fe754a1a113f31b6dbfd4-stock-photo-photo-of-a-common-kingfisher-alcedo-atthis-adult-male-perched-on-a-lichen-covered-branch-107647640.jpg",
                         "https://imgct2.aeplcdn.com/img/800x600/car-data/big/honda-amaze-image-12749.png",
                          "https://ak.picdn.net/assets/cms/97e1dd3f8a3ecb81356fe754a1a113f31b6dbfd4-stock-photo-photo-of-a-common-kingfisher-alcedo-atthis-adult-male-perched-on-a-lichen-covered-branch-107647640.jpg"]
        titleArray = ["picture 1","picture 2","picture 3","picture 4"]
        reviewImage.delegate = self
        reviewImage.setCarouselData(paths: pathArray,  describedTitle: titleArray, isAutoScroll: true, timer: 5.0, defaultImage: nil)
        //optional methods
        reviewImage.setCarouselOpaque(layer: false, describedTitle: false, pageIndicator: false)
        reviewImage.setCarouselLayout(displayStyle: 0, pageIndicatorPositon: 2, pageIndicatorColor: nil, describedTitleColor: nil, layerColor: nil)
    }

    @objc func viewAdoptList(_ sender: UIButton!){
        print("Adopt")
    }

    @objc func viewFundingList(_ sender: UIButton! ) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "FundingListViewController") as! FundingListViewController
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
//        if indexPath.row != 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "FundingTableCell", for: indexPath) as! FundingTableCell
            cell.titleLabel.text = gsno(fundingList[indexPath.row].title)
            guard let photo = fundingList[indexPath.row].mainPhoto else { return cell }
            cell.backgroundImageView.kf.setImage(with: URL(string: gsno(photo.url)))
            print(photo.url)
            return cell
//        } else {
//            let cell = tableView.dequeueReusableCell(withIdentifier: "BannerTableCell", for: indexPath) as! BannerTableCell
//            return cell
//        }

    }
    
    
}
extension MainViewController {
    func requestCallback(_ datas: Any, _ code: Int) {
        if ( code == APIServiceCode.FUNDING_MAIN ) {
            fundingList = datas as! [FundingModel]
            print("fundingList model size \(fundingList.count)}")
            tempTableList.reloadData()
        } else if ( code == APIServiceCode.FUNDING_MAIN ) {
            
        }
    }
}
