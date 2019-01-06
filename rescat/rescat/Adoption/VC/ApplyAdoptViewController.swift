//
//  ApplyAdoptViewController.swift
//  rescat
//
//  Created by 김예은 on 04/01/2019.
//  Copyright © 2019 kyeahen. All rights reserved.
//

import UIKit

class ApplyAdoptViewController: UIViewController,UITextViewDelegate {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var roleTextField: UITextField!
    @IBOutlet weak var mainAddressTextField: UITextField!
    @IBOutlet weak var subAddressTextField: UITextField! {
        didSet {
            contentTextView.tintColor = #colorLiteral(red: 0.948010385, green: 0.566582799, blue: 0.5670218468, alpha: 1)
            contentTextView.reloadInputViews()
        }
    }
    
    @IBOutlet weak var contentTextView: UITextView!
    
    var idx: Int = 0
    var titleName: String = ""
    var tag: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setCustomView()
        
    }
    
    //MARK: 뷰 요소 커스텀 세팅
    func setCustomView() {
        nameTextField.setTextField()
        phoneTextField.setTextField()
        roleTextField.setTextField()
        mainAddressTextField.setTextField()
        subAddressTextField.setTextField()
        contentTextView.setTextView()
        contentTextView.tintColor = #colorLiteral(red: 0.948010385, green: 0.566582799, blue: 0.5670218468, alpha: 1)
        
        self.navigationItem.title = titleName
    }
    
}

//MARK: Networking Extension
extension ApplyAdoptViewController {
    
    func postApplyAdopt(idx: String, type: Int, name: String, phone: String, birth: String, job: String, address: String, houseType: String, ex: Bool, content: String) {
        
        let params : [String : Any] = ["type": type,
                                       "name": name,
                                       "phone": phone,
                                       "birth": birth,
                                       "job": job,
                                       "address": address,
                                       "houseType": houseType,
                                       "companionExperience": ex,
                                       "finalWord": content]
        
        LoginService.shareInstance.postLogin(params: params) {(result) in
            
            switch result {
            case .networkSuccess( _): //200
                self.simpleAlertButton(title: "", message:
                """
                한 생명이 머물 수 있는
                공간을 제공해주셔서 감사합니다.

                신중하게 결정을 내려주세요.
                """, buttonMessage: "신청할래요")
                break
                
            case .networkFail :
                self.networkErrorAlert()
                break
                
            default :
                self.simpleAlert(title: "오류", message: "다시 시도해주세요.")
                break
            }
        }
    }
    
}





