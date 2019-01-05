//
//  AdoptionDetailViewController.swift
//  rescat
//
//  Created by 김예은 on 02/01/2019.
//  Copyright © 2019 kyeahen. All rights reserved.
//

import UIKit
import ImageSlideshow
import Kingfisher

class AdoptionDetailViewController: UIViewController {

    //MARK: ImageSlideShow Method
    open override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var catImageView: ImageSlideshow!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var sexLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var tnrLabel: UILabel!
    @IBOutlet weak var protectLabel: UILabel!
    @IBOutlet weak var etcLabel: UILabel!

    
    var details: AdoptDetailData?
    var idx: Int = 0
    var tag: Int = 0
    var adoptButton = UIButton()
    var imageArr: [InputSource] = [InputSource]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTableView()
        setImageSlideShow()
        setCustomView()
        getAdoptDetail(_idx: idx)
        setFooterButton()
    }
    
    //MARK: 뷰 요소 커스텀 세팅
    func setCustomView() {
//        if tag == 0 {
//            adoptButton.setTitle("입양할래요", for: .normal)
//        } else {
//            adoptButton.setTitle("임보할래요", for: .normal)
//        }
    }
    
    func setTableView() {
        //TODO: 더 나은 방법 생각해보기
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0.0, bottom: 64, right: 0.0)
        
    }
    
    //MARK: 하단 버튼 세팅
    func setFooterButton() {
        
        if tag == 0 {
            adoptButton.setTitle("입양할래요", for: .normal)
        } else {
            adoptButton.setTitle("임보할래요", for: .normal)
        }
        
        adoptButton.backgroundColor = #colorLiteral(red: 0.9108809829, green: 0.5436502695, blue: 0.5482131243, alpha: 1)
        adoptButton.titleLabel?.textAlignment = .center
        adoptButton.titleLabel?.textColor = UIColor.white
        adoptButton.titleLabel?.font = UIFont(name: AppleSDGothicNeo.SemiBold.rawValue, size: 20)
        
        self.adoptButton.addTarget(self, action: #selector(adoptAction(sender:)), for: UIControl.Event.touchUpInside)
        view.addSubview(adoptButton)
        
    }
    
    override func viewWillLayoutSubviews() {
        
        adoptButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
           adoptButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0),
            adoptButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -64),
            adoptButton.widthAnchor.constraint(equalToConstant: self.view.frame.width),
            adoptButton.heightAnchor.constraint(equalToConstant: 49)
        ])
    }
    
    //MARK: 입양할래요/임보할래요 액션 - idx
    @objc func adoptAction(sender: UIButton) {
        self.simpleAlert(title: "넹", message: "넹")
    }

}

//MARK: Networking Extension
extension AdoptionDetailViewController {
    
    func getAdoptDetail(_idx: Int) {
        
        AdoptDetailService.shareInstance.getAdoptDetail(idx: _idx, completion: {
            (result) in
            
            switch result {
            case .networkSuccess(let data) :
                let detailData = data as? AdoptDetailData
                
                if let resResult = detailData {
                    self.details = resResult
                    
                    self.getData()
                    self.getImageData()
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
    
    func getData() {
        self.nameLabel.text = details?.name
        self.ageLabel.text = details?.age
        self.typeLabel.text = details?.breed
        self.protectLabel.text = details?.vaccination ?? "모름"
        self.etcLabel.text = details?.contents
        
        if details?.sex == 0 {
            self.sexLabel.text = sexMapping.male.rawValue
        } else {
            self.sexLabel.text = sexMapping.female.rawValue
        }
        
        if details?.tnr == 0 {
            self.tnrLabel.text = TNRMapping.none.rawValue
        } else {
            self.tnrLabel.text = TNRMapping.yes.rawValue
        }
    }
    
    func getImageData() {
        
        guard let cnt = details?.photos.count else {return}
        
        for i in 0..<cnt {
            if let url = details?.photos[i].url {
                self.imageArr.append(KingfisherSource(urlString: url)!)
            }
        }
        
        self.catImageView.setImageInputs(self.imageArr)
    }
    
}


//MARK: ImageSlideShow Setting
extension AdoptionDetailViewController {
    
    func setImageSlideShow() {
        
        catImageView.slideshowInterval = 3.0
        catImageView.pageIndicatorPosition = .init(horizontal: .center, vertical: .under)
        catImageView.contentScaleMode = UIView.ContentMode.scaleToFill
        
        //PageControl Setting
        let pageControl = UIPageControl()
        pageControl.currentPageIndicatorTintColor = #colorLiteral(red: 0.9108466506, green: 0.5437278748, blue: 0.5438123941, alpha: 1)
        pageControl.pageIndicatorTintColor = UIColor.white
        catImageView.pageIndicator = pageControl
        catImageView.pageIndicatorPosition = PageIndicatorPosition(horizontal: .center, vertical: .bottom)
        
        //Pop Up Setting
        catImageView.activityIndicator = DefaultActivityIndicator()
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(AdoptionDetailViewController.didTap))
        catImageView.addGestureRecognizer(recognizer)
        
    }
    
    //MARK: ImageSlideShow 팝업
    @objc func didTap() {
        let fullScreenController = catImageView.presentFullScreenController(from: self)
        // set the activity indicator for full screen controller (skipping the line will show no activity indicator)
        fullScreenController.slideshow.activityIndicator = DefaultActivityIndicator(style: .white, color: nil)
    }
}
