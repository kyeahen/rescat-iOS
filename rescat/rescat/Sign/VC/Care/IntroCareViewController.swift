//
//  IntroCareViewController.swift
//  rescat
//
//  Created by 김예은 on 29/12/2018.
//  Copyright © 2018 kyeahen. All rights reserved.
//

import UIKit

class IntroCareViewController: UIViewController {

    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var imageView1: UIImageView!
    @IBOutlet weak var imageView2: UIImageView!
    @IBOutlet weak var imageView3: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //MARK: 뷰 요소 커스텀 세팅
    func setCustomView() {
        imageView1.circleImageView()
        imageView2.circleImageView()
        imageView3.circleImageView()
        nextButton.makeRounded(cornerRadius: 8)
    }
    
    //MARK: 다음 액션
    @IBAction func nextAction(_ sender: UIButton) {
    }
    
    



}
