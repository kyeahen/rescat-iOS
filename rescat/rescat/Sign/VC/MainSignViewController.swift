//
//  MainSignViewController.swift
//  rescat
//
//  Created by 김예은 on 23/12/2018.
//  Copyright © 2018 kyeahen. All rights reserved.
//

import UIKit

class MainSignViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func loginAction(_ sender: UIButton) {
        
        let id = "test101"
        let pwd = "test"
        
        let params : [String : Any] = ["email_id" : id,
                                       "password" : pwd]
        
        LoginService.shareInstance.postLogin(params: params) {(result) in

            switch result {
                case .networkSuccess(let loginData):
                    let userData = loginData as? LoginData
                    
                    print("메인에서\(UserDefaultService.getUserDefault(key: "token"))")
                    self.simpleAlert(title: "성공", message: "환영합니다.")
                break
                
                case .networkFail :
                    self.networkErrorAlert()
                break
                
                default :
                self.simpleAlert(title: "오류", message: "다시 시도해주세요")
                break
            }
        }
        
    }
    


}
