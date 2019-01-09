//
//  CompleteAdoptViewController.swift
//  rescat
//
//  Created by 김예은 on 05/01/2019.
//  Copyright © 2019 kyeahen. All rights reserved.
//

import UIKit

class CompleteAdoptViewController: UIViewController {


    override func viewDidLoad() {
        super.viewDidLoad()

        setRightBarButtonItem()

    }
    
    //MARK: rightBarButtonItem Setting
    func setRightBarButtonItem() {
        let rightButtonItem = UIBarButtonItem.init(
            title: "완료",
            style: .done,
            target: self,
            action: #selector(rightButtonAction(sender:))
        )
        self.navigationItem.rightBarButtonItem = rightButtonItem
        self.navigationItem.rightBarButtonItem?.tintColor =  #colorLiteral(red: 0.9108466506, green: 0.5437278748, blue: 0.5438123941, alpha: 1)
        self.navigationItem.rightBarButtonItem?.setTitleTextAttributes([
            NSAttributedString.Key.font : UIFont(name: AppleSDGothicNeo.Bold.rawValue, size: 16)], for: .normal)
    }
    
    //MARK: 홈으로 이동
    @objc func rightButtonAction(sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: "unwindToTab", sender: self)
    }
    
}
