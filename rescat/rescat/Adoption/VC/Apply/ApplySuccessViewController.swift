//
//  ApplySuccessViewController.swift
//  rescat
//
//  Created by 김예은 on 10/01/2019.
//  Copyright © 2019 kyeahen. All rights reserved.
//

import UIKit

class ApplySuccessViewController: UIViewController {

    @IBOutlet weak var naviBar: UINavigationBar!
    @IBOutlet weak var okButton: UIBarButtonItem!
    @IBOutlet weak var typeLabel: UILabel!
    
    var type: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setCustomView()
        setContentInit()
    }
    
    func setCustomView() {
        self.naviBar.titleTextAttributes = [NSAttributedString.Key.font : UIFont(name: AppleSDGothicNeo.Bold.rawValue, size: 16)]
        self.naviBar.tintColor = #colorLiteral(red: 0.1372389793, green: 0.1372650564, blue: 0.1372332573, alpha: 1)
        self.naviBar.barTintColor = #colorLiteral(red: 0.999904573, green: 1, blue: 0.9998808503, alpha: 1)
        okButton.setTitleTextAttributes([
            NSAttributedString.Key.font : UIFont(name: AppleSDGothicNeo.Bold.rawValue, size: 16)], for: .normal)
    }
    
    func setContentInit() {
        if type == 0 {
            typeLabel.text = "입양"
            naviBar.topItem?.title = "입양 신청서"
        } else {
            typeLabel.text = "임시보호"
            naviBar.topItem?.title = "임시보호 신청서"
        }
    }
    
    
    @IBAction func homeAction(_ sender: UIBarButtonItem) {
            self.performSegue(withIdentifier: "unwindToTab1", sender: self)
    }
    

}
