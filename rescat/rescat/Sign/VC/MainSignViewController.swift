//
//  MainSignViewController.swift
//  rescat
//
//  Created by 김예은 on 23/12/2018.
//  Copyright © 2018 kyeahen. All rights reserved.
//

import UIKit

class MainSignViewController: UIViewController {
    
    @IBOutlet weak var skipButton: UIButton!
    @IBOutlet weak var joinButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setCustomView()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        navigationController?.setNavigationBarHidden(true, animated: true)
        loginButton.setTitleColor(UIColor.white, for: .normal)
        
    }
    
    //MARK: 뷰 요소 커스텀 세팅
    func setCustomView() {
        
        skipButton.makeRounded(cornerRadius: 8)
        
    }
    
    //MARK: 로그인 없이 시작하기
    @IBAction func SkipAction(_ sender: UIButton) {
        
        UserDefaults.standard.removeObject(forKey: "token")
        UserDefaults.standard.set("-1", forKey: "token")
        let mainVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: TabBarController.reuseIdentifier) 
        
        self.present(mainVC, animated: true, completion: nil)
    }
    
}
