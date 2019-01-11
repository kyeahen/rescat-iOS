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
    @IBOutlet weak var introLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var sexLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var tnrLabel: UILabel!
    @IBOutlet weak var protectLabel: UILabel!
    @IBOutlet weak var etcLabel: UILabel!
    @IBOutlet weak var adoptButton: UIButton!
    @IBOutlet weak var bottomC: NSLayoutConstraint!
    
    var details: AdoptDetailData?
    var idx: Int = 0
    var tag: Int = 0
    var imageArr: [InputSource] = [InputSource]()
    
    var apply: Bool?
    var finish: Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setImageSlideShow()
        setFooterButton()
        getAdoptDetail(_idx: idx)
        adoptButton.isHidden = true
 
    }
    

    
    //MARK: 하단 버튼 세팅
    func setFooterButton() {
        
        if tag == 0 {
            adoptButton.setTitle("입양할래요", for: .normal)
        } else {
            adoptButton.setTitle("임보할래요", for: .normal)
        }
        
    }
    
    //MARK: 입양할래요/임보할래요 액션 - idx
    @IBAction func adoptAction(_ sender: UIButton) {
        
        let token = UserDefaults.standard.string(forKey: "token")
    
        
        if token != "-1" {
            
            if apply == true {
                self.simpleAlert(title: "", message: "이미 신청한 글입니다.")
            } else if finish == true {
                self.simpleAlert(title: "", message: "마감된 글 입니다.")
            } else {
                let applyVC = UIStoryboard(name: "Adoption", bundle: nil).instantiateViewController(withIdentifier: ApplyAdoptViewController.reuseIdentifier) as! ApplyAdoptViewController
                
                applyVC.idx = idx
                applyVC.tag = tag
                
                if tag == 0 {
                    applyVC.titleName = "입양 신청서"
                } else {
                    applyVC.titleName = "임시보호 신청서"
                }
                
                self.navigationController?.pushViewController(applyVC, animated: true)
            }
            
        } else {
            self.simpleAlert(title: "로그인이 필요해요!", message:
            """
            입양 및 임보를 진행하기 위해서는
            로그인을 진행해주세요.
            """)
        }

        
    }
    

  

}

//MARK: Networking Extension
extension AdoptionDetailViewController {
    
    //입양, 임보 리스트 조회
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
        
        //글작성자 확인 여부
        if details?.isWriter == true {
            self.adoptButton.isHidden = true
            self.bottomC.constant = 64
        } else {
            self.adoptButton.isHidden = false
            self.bottomC.constant = 113
        }
        
        self.apply = details?.isSubmitted //신청자 확인 여부
        self.finish = details?.isFinished //마감 확인 여부
        self.nameLabel.text = details?.name
        self.ageLabel.text = details?.age
        self.typeLabel.text = details?.breed
        self.etcLabel.text = details?.etc
        self.introLabel.text = details?.contents
        
        //값 맵핑
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
        
        switch details?.vaccination {
        case vacMapping.know.rawValue:
            self.protectLabel.text = vacMappingKo.know.rawValue
            break
        case vacMapping.none.rawValue:
            self.protectLabel.text = vacMappingKo.none.rawValue
            break
        case vacMapping.one.rawValue:
            self.protectLabel.text = vacMappingKo.one.rawValue
            break
        case vacMapping.two.rawValue:
            self.protectLabel.text = vacMappingKo.two.rawValue
            break
        case vacMapping.three.rawValue:
            self.protectLabel.text = vacMappingKo.three.rawValue
            break
        default:
            break
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
        catImageView.contentScaleMode = UIView.ContentMode.scaleAspectFill
        
        //PageControl Setting
        let pageControl = UIPageControl()
        pageControl.currentPageIndicatorTintColor = #colorLiteral(red: 0.9108466506, green: 0.5437278748, blue: 0.5438123941, alpha: 1)
        pageControl.pageIndicatorTintColor = UIColor.white
        catImageView.pageIndicator = pageControl
        catImageView.pageIndicatorPosition = PageIndicatorPosition(horizontal: .center, vertical: .bottom)
        
//        //Pop Up Setting
//        catImageView.activityIndicator = DefaultActivityIndicator()
//        let recognizer = UITapGestureRecognizer(target: self, action: #selector(AdoptionDetailViewController.didTap))
//        catImageView.addGestureRecognizer(recognizer)
        
    }
    
//    //MARK: ImageSlideShow 팝업
//    @objc func didTap() {
//        let fullScreenController = catImageView.presentFullScreenController(from: self)
//        // set the activity indicator for full screen controller (skipping the line will show no activity indicator)
//        fullScreenController.slideshow.activityIndicator = DefaultActivityIndicator(style: .white, color: nil)
//    }
}
