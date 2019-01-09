//
//  CompleteAdoptViewController.swift
//  rescat
//
//  Created by 김예은 on 05/01/2019.
//  Copyright © 2019 kyeahen. All rights reserved.
//

import UIKit

class CompleteAdoptViewController: UIViewController {


    @IBOutlet weak var naviBar: UINavigationBar!
    @IBOutlet weak var okButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        setRightBarButtonItem()
        
        self.naviBar.titleTextAttributes = [NSAttributedString.Key.font : UIFont(name: AppleSDGothicNeo.Bold.rawValue, size: 16)]
        self.naviBar.tintColor = #colorLiteral(red: 0.1372389793, green: 0.1372650564, blue: 0.1372332573, alpha: 1)
        self.naviBar.barTintColor = #colorLiteral(red: 0.999904573, green: 1, blue: 0.9998808503, alpha: 1)
        okButton.setTitleTextAttributes([
            NSAttributedString.Key.font : UIFont(name: AppleSDGothicNeo.Bold.rawValue, size: 16)], for: .normal)

    }
    
//    //MARK: rightBarButtonItem Setting
//    func setRightBarButtonItem() {
//        let rightButtonItem = UIBarButtonItem.init(
//            title: "완료",
//            style: .done,
//            target: self,
//            action: #selector(rightButtonAction(sender:))
//        )
//        self.navigationItem.rightBarButtonItem = rightButtonItem
//        self.navigationItem.rightBarButtonItem?.tintColor =  #colorLiteral(red: 0.9108466506, green: 0.5437278748, blue: 0.5438123941, alpha: 1)
//        self.navigationItem.rightBarButtonItem?.setTitleTextAttributes([
//            NSAttributedString.Key.font : UIFont(name: AppleSDGothicNeo.Bold.rawValue, size: 16)], for: .normal)
//    }
    
    @IBAction func homeAction(_ sender: UIBarButtonItem) {
                self.performSegue(withIdentifier: "unwindToTab", sender: self)
    }
    
    
//    //MARK: 홈으로 이동
//    @objc func rightButtonAction(sender: UIBarButtonItem) {
//        self.performSegue(withIdentifier: "unwindToTab", sender: self)
//    }
    
}
