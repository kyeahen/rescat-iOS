//
//  Care1ViewController.swift
//  rescat
//
//  Created by 김예은 on 29/12/2018.
//  Copyright © 2018 kyeahen. All rights reserved.
//

import UIKit

class Care1ViewController: UIViewController {

    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var numTextField: UITextField!
    @IBOutlet weak var phoneLineView: UIView!
    @IBOutlet weak var numLineView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setCustomView()
        setEmptyCheck()
    }
    
    //MARK: 뷰 요소 커스텀 세팅
    func setCustomView() {
        
        phoneTextField.tintColor = #colorLiteral(red: 0.9272156358, green: 0.5553016067, blue: 0.5554865003, alpha: 1)
        numTextField.tintColor = #colorLiteral(red: 0.9272156358, green: 0.5553016067, blue: 0.5554865003, alpha: 1)
        nextButton.makeRounded(cornerRadius: 8)
    }
    
    func setEmptyCheck() {
        
        //FIXME: height 변경 확인
        phoneTextField.addTarget(self, action: #selector(emptyPhoneCheck), for: .editingChanged)
        numTextField.addTarget(self, action: #selector(emptyNumCheck), for: .editingChanged)
        
    }
    
    //MARK: 전화번호 공백 체크 함수
    @objc func emptyPhoneCheck() {
        
        if phoneTextField.text == ""{
            phoneLineView.backgroundColor = #colorLiteral(red: 0.7567955852, green: 0.7569058537, blue: 0.7567716241, alpha: 1)
            phoneLineView.snp.makeConstraints {
                (make) in
                make.height.equalTo(1)
            }
        } else {
            phoneLineView.backgroundColor = #colorLiteral(red: 0.4294961989, green: 0.3018877506, blue: 0.2140608728, alpha: 1)
            phoneLineView.snp.makeConstraints {
                (make) in
                make.height.equalTo(3)
            }
        }
    }
    
    //MARK: 인증번호 공백 체크 함수
    @objc func emptyNumCheck() {
        
        if numTextField.text == ""{
            numLineView.backgroundColor = #colorLiteral(red: 0.7567955852, green: 0.7569058537, blue: 0.7567716241, alpha: 1)
            numLineView.snp.makeConstraints {
                (make) in
                make.height.equalTo(1)
            }
        } else {
            numLineView.backgroundColor = #colorLiteral(red: 0.4294961989, green: 0.3018877506, blue: 0.2140608728, alpha: 1)
            numLineView.snp.makeConstraints {
                (make) in
                make.height.equalTo(3)
            }
        }
    }
    
    //MARK: 문자발송 액션
    @IBAction func messageAction(_ sender: UIButton) {
        
    }
    
    //MARK: 다음 액션
    @IBAction func nextAction(_ sender: UIButton) {
        
    }
    
    
}
