//
//  SplashViewController.swift
//  rescat
//
//  Created by 김예은 on 10/01/2019.
//  Copyright © 2019 kyeahen. All rights reserved.
//

import UIKit
import SwiftGifOrigin

class SplashViewController: UIViewController {
    
    @IBOutlet var splashGifImg: UIImageView!
    
    let delayInSeconds = 3.0
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        splashGifImg.image = UIImage.gif(name: "splahIos@3x.gif")
//        
//        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delayInSeconds){
//   
//            guard let token = UserDefaults.standard.string(forKey: "token") else {return}
//            
//            if token == "-1" {
//                let signVC = UIStoryboard(name: "Sign", bundle: nil).instantiateViewController(withIdentifier: "MainSignNaviVC")
//                self.present(signVC, animated: true, completion: nil)
//                
//            } else {
//                    let tabVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: TabBarController.reuseIdentifier)
//                    self.present(tabVC, animated: true)
//            }
//        }

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
