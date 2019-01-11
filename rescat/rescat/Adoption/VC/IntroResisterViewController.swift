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
    
    //MARK: 입양/임보 글작성
    @IBAction func adoptAction(_ sender: UIButton) {
        let adoptVC = UIStoryboard(name: "Adoption", bundle: nil).instantiateViewController(withIdentifier: RegisterAdoptViewController.reuseIdentifier)
        self.navigationController?.pushViewController(adoptVC, animated: true)
        
    }

    //MARK: 후원 글작성 액션
    @IBAction func supportAction(_ sender: UIButton) {
        //후원 글작성 뷰로 이동(push)
        let fundVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: FundingRegisterVC.reuseIdentifier)
        self.navigationController?.pushViewController(fundVC, animated: true)
    }
    
}
