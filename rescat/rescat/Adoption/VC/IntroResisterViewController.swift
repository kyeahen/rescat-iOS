//
//  IntroResisterViewController.swift
//  rescat
//
//  Created by 김예은 on 05/01/2019.
//  Copyright © 2019 kyeahen. All rights reserved.
//

import UIKit

class IntroResisterViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setBackBtn()
        // Do any additional setup after loading the view.
    }

    //MARK: 후원 글작성 액션
    @IBAction func supportAction(_ sender: UIButton) {
        //후원 글작성 뷰로 이동(push)
        let fundVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: FundingRegisterVC.reuseIdentifier)
        self.navigationController?.pushViewController(fundVC, animated: true)
    }
    
}
