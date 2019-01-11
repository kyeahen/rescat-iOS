//
//  FundingSupportViewController.swift
//  rescat
//
//  Created by jigeonho on 07/01/2019.
//  Copyright © 2019 kyeahen. All rights reserved.
//

import Foundation
import UIKit
class FundingSupportViewController : UIViewController, APIServiceCallback {
    @IBOutlet var inputTextField : UITextField!
    @IBOutlet var finalButton : UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setBackBtn()
        if FundingDetailSegmentController.category == 0 {
            self.setNaviTitle(name: "치료비 후원")
        } else {
            self.setNaviTitle(name: "프로젝트 후원")
        }
        inputTextField.layer.borderWidth = 1.0; inputTextField.roundCorner(10.0)
        inputTextField.layer.borderColor = UIColor.rescatPink().cgColor

        inputTextField.keyboardType = .decimalPad
        inputTextField.inputAccessoryView = accessoryView()
        inputTextField.inputAccessoryView?.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 44)
        finalButton.addTarget(self, action: #selector(finalButtonAction(_:)), for: .touchUpInside)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }
    @objc func finalButtonAction( _ sender : UIButton!){
        if gsno(inputTextField.text) == "" || Int(gsno(inputTextField.text)) == 0 {
            self.simpleAlert(title: "", message: "금액을 입력해주세요")
        } else if  Int(gsno(inputTextField.text))! < 2000  {
            
            self.simpleAlert(title: "", message: "2000젤리 이상 후원할 수 있습니다.")
        }else {
            //
            let amount = Int(gsno(inputTextField.text))
            let request = FundingRequest(self)
            request.postFundingMileage(FundingDetailSegmentController.fundingIdx, mileage: gino(amount))
//            let vc = storyboard?.instantiateViewController(withIdentifier: "FundingSupportCompleteViewController") as! FundingSupportCompleteViewController
            let vc = storyboard?.instantiateViewController(withIdentifier: "supportComplete") as! UINavigationController
            self.present(vc, animated: true)
        }
    }
    
    func accessoryView() -> UIView {
        
        
        let view = UIView()
        view.backgroundColor = UIColor.white
        let doneButton = UIButton()
        doneButton.frame = CGRect(x: self.view.frame.width - 80, y: 7, width: 60, height: 30)
        doneButton.setTitle("done", for: .normal)
        doneButton.setTitleColor(UIColor.rescatPink(), for: .normal)
        //        doneButton.backgroundColor = UIColor.rescatPink()
        
        doneButton.addTarget(self, action: #selector(doneAction), for: .touchUpInside)
        view.addSubview(doneButton)
        
        return view
        
    }
    
    @objc func doneAction() {
        inputTextField.resignFirstResponder()
    }
    func requestCallback(_ datas: Any, _ code: Int) {
        if code == APIServiceCode.FUNDING_MIELGE_POST {
            self.simpleAlert(title: "success", message: "후원 성공 - 어디로 돌아가지 ?")
        } else if code == APIServiceCode.EXCEPTION_ERROR1 {
            self.simpleAlert(title: "error", message: "마일리지 부족함")
        }
    }
    
}
