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
    
    //슬라이드쇼 테스트 소스
    var imageArr: [InputSource] = [KingfisherSource(urlString: "https://images.pexels.com/photos/67636/rose-blue-flower-rose-blooms-67636.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500")!, KingfisherSource(urlString: "https://images.pexels.com/photos/67636/rose-blue-flower-rose-blooms-67636.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500")!]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTableView()
        setImageSlideShow()
    }
    
    func setTableView() {
        //TODO: 더 나은 방법 생각해보기
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0.0, bottom: 64, right: 0.0)
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
        
        //이미지 넣기
        catImageView.setImageInputs(self.imageArr)
        
    }
    
    //MARK: ImageSlideShow 팝업
    @objc func didTap() {
        let fullScreenController = catImageView.presentFullScreenController(from: self)
        // set the activity indicator for full screen controller (skipping the line will show no activity indicator)
        fullScreenController.slideshow.activityIndicator = DefaultActivityIndicator(style: .white, color: nil)
    }
}
