//
//  Care2ViewController.swift
//  rescat
//
//  Created by 김예은 on 29/12/2018.
//  Copyright © 2018 kyeahen. All rights reserved.
//

import UIKit

class Care2ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setCustomView()
    }
    
    //MARK: 뷰 요소 커스텀 세팅
    func setCustomView() {
        imageView.circleImageView()
        nextButton.makeRounded(cornerRadius: 8)
    }
    
    //MARK: 지역 검색 액션
    @IBAction func areaAction(_ sender: UIButton) {
    }
    
    //MARK: 다음 액션
    @IBAction func nextAction(_ sender: UIButton) {
        
    }
    
}
