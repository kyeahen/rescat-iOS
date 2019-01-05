//
//  FinishCareViewController.swift
//  rescat
//
//  Created by 김예은 on 30/12/2018.
//  Copyright © 2018 kyeahen. All rights reserved.
//

import UIKit

class FinishCareViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var finishButton: UIButton!
    
//    var parentVC : MainCareViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setCustomView()
        
    }
    
    //MARK: 뷰 요소 커스텀 세팅
    func setCustomView() {
        imageView.circleImageView()
        finishButton.makeRounded(cornerRadius: 8)
    }

    //MARK: 완료 액션
    //TODO: 메인 페이지로 이동
    @IBAction func finishAction(_ sender: UIButton) {
        let tabVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: TabBarController.reuseIdentifier) as! TabBarController

        self.present(tabVC, animated: true, completion: nil)
    }
    
}
