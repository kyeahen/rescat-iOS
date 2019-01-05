//
//  MyPageAddAreaViewController.swift
//  rescat
//
//  Created by 김예은 on 06/01/2019.
//  Copyright © 2019 kyeahen. All rights reserved.
//

import UIKit

class MyPageAddAreaViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //MAKR: 창닫기 액션
    @IBAction func dismissAction(_ sender: UIBarButtonItem) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK: 완료 액션(unwind segue)
    @IBAction func saveAction(_ sender: UIButton) {
    }
    
}
