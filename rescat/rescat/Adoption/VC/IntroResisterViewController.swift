//
//  IntroResisterViewController.swift
//  rescat
//
//  Created by 김예은 on 05/01/2019.
//  Copyright © 2019 kyeahen. All rights reserved.
//

import UIKit

class IntroResisterViewController: UIViewController {

    @IBOutlet weak var adoptButton: UIButton!
    @IBOutlet weak var supportButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setBackBtn()
        setCustomView()
    }
    
    //MARK: 뷰 요소 커스텀 세팅
    func setCustomView() {
        adoptButton.makeRounded(cornerRadius: 9)
        supportButton.makeRounded(cornerRadius: 9)
    }

    //MARK: 후원 글작성 액션
    @IBAction func supportAction(_ sender: UIButton) {
        //후원 글작성 뷰로 이동(push)
        let role = gsno(UserDefaults.standard.string(forKey: "role"))
        if role == careMapping.care.rawValue {
            let fundVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: FundingRegisterVC.reuseIdentifier)
            self.navigationController?.pushViewController(fundVC, animated: true)
        } else {
            self.simpleAlert(title: "", message: "케어테이커가 되어야 이용할 수 있습니다.")
        }

    }
    
}
