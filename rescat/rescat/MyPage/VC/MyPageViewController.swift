//
//  MyPageViewController.swift
//  rescat
//
//  Created by 김예은 on 23/12/2018.
//  Copyright © 2018 kyeahen. All rights reserved.
//

import UIKit

class MyPageViewController: UIViewController , APIServiceCallback {

    @IBOutlet var percentage : UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        percentage.drawPercentage(0.6, UIColor.black, UIColor.blue)
        
        let request = NaverMapRequest(self)
        request.requestGeocoder("서울시 서초구 서초동")
        request.requestReverseGeocoder(37.001213, 127.000132)
        print(10000500.getMoney())
        print(123456789.getMoney())
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension MyPageViewController {
    func requestCallback(_ datas: Any, _ code: Int) {
        
        if ( code == 1 ) {
//            let data = datas as! String
            print("geocoder result \(datas)")
        } else {
//            let data = datas as! String
            print("reverse geocoder result \(datas)")

        }
    }
}
