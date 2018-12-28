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
        
    }
    
    //MARK: 뷰 요소 커스텀 세팅
    func setCustomView() {
        
        skipButton.makeRounded(cornerRadius: 8)
        joinButton.makeRounded(cornerRadius: 8)
        joinButton.layer.addBorder(edge: .top, color: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), thickness: 2)
        joinButton.layer.addBorder(edge: .bottom, color: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), thickness: 2)
        joinButton.layer.addBorder(edge: .left, color: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), thickness: 2)
        joinButton.layer.addBorder(edge: .right, color: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), thickness: 2)
        
    }
}
