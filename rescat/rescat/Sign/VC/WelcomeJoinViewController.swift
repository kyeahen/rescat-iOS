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

        setCustomView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    //MARK: 뷰 요소 커스텀 세팅
    func setCustomView() {
        skipButton.makeRounded(cornerRadius: 8)
        careButton.makeRounded(cornerRadius: 8)
    }
    
    //MARK: 나중에 할래요 액션
    @IBAction func skipAction(_ sender: UIButton) {
        let mainVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: TabBarController.reuseIdentifier)
        
        self.present(mainVC, animated: true, completion: nil)
    }

}

