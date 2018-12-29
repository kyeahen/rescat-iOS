//
//  WelcomeJoinViewController.swift
//  rescat
//
//  Created by 김예은 on 28/12/2018.
//  Copyright © 2018 kyeahen. All rights reserved.
//

import UIKit

class WelcomeJoinViewController: UIViewController {
    
    @IBOutlet weak var skipButton: UIButton!
    @IBOutlet weak var careButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //FIXME: 투명 네비게이션바 복구
        setNavigationBar()
        setCustomView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setNavigationBar()
    }
    
    //MARK: 뷰 요소 커스텀 세팅
    func setCustomView() {
        skipButton.makeRounded(cornerRadius: 8)
        careButton.makeRounded(cornerRadius: 8)
    }
    
    //MARK: 나중에 할래요 액션
    @IBAction func skipAction(_ sender: UIButton) {
        //메인 뷰로 이동
    }
    
    //MARK: 인증할래요 액션
    @IBAction func careAction(_ sender: UIButton) {
        //케어테이커 뷰로 이동
    }
}

