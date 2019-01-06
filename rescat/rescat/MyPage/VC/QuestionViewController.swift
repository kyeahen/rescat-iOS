//
//  QuestionViewController.swift
//  rescat
//
//  Created by 김예은 on 06/01/2019.
//  Copyright © 2019 kyeahen. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setBackBtn()
    }

    //MARK: 카톡 아이디 복사 액션
    @IBAction func idCopyAction(_ sender: UIButton) {
        let pb: UIPasteboard = UIPasteboard.general
        pb.string = "@rescat"
        self.showToast(message: "복사되었습니다.")
        
        
    }
    
    //MARK: 이메일 복사 액션
    @IBAction func emailCopyAction(_ sender: UIButton) {
        let pb: UIPasteboard = UIPasteboard.general
        pb.string = "iamrescat@gmail.com"
        self.showToast(message: "복사되었습니다.")
    }
    
    
}
