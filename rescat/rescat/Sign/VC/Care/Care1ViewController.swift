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
    @IBOutlet weak var messageButton: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    
    var parentVC : MainCareViewController?
    var messageCode: Int?
    var check: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(check)
        
        setCustomView()
        setEmptyCheck()
        
        //테이블 뷰 키보드 대응
        NotificationCenter.default.addObserver(self, selector: #selector(Care1ViewController.keyboardWillShow(notification:)), name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(Care1ViewController.keyboardWillHide(notification:)), name: UIResponder.keyboardDidHideNotification, object: nil)
        

    }
    
    //MARK: 키보드 대응 method
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    //MARK: 뷰 요소 커스텀 세팅
    func setCustomView() {
        
        messageButton.isEnabled = false

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
            messageButton.isEnabled = false
            messageButton.setTitleColor(#colorLiteral(red: 0.7411106229, green: 0.7412187457, blue: 0.7410870194, alpha: 1), for: .normal)
            
            phoneLineView.backgroundColor = #colorLiteral(red: 0.7567955852, green: 0.7569058537, blue: 0.7567716241, alpha: 1)
            phoneLineView.snp.makeConstraints ({
                (make) in
                make.height.equalTo(1)
            })
        } else {
            messageButton.isEnabled = true
            messageButton.setTitleColor(#colorLiteral(red: 0.9108466506, green: 0.5437278748, blue: 0.5438123941, alpha: 1), for: .normal)
            phoneLineView.backgroundColor = #colorLiteral(red: 0.4294961989, green: 0.3018877506, blue: 0.2140608728, alpha: 1)
            phoneLineView.snp.makeConstraints ({
                (make) in
                make.height.equalTo(3)
            })
        }
    }
    
    //MARK: 인증번호 공백 체크 함수
    @objc func emptyNumCheck() {
        
        if numTextField.text == ""{
            numLineView.backgroundColor = #colorLiteral(red: 0.7567955852, green: 0.7569058537, blue: 0.7567716241, alpha: 1)
            numLineView.snp.makeConstraints ({
                (make) in
                make.height.equalTo(1)
            })
        } else {
            numLineView.backgroundColor = #colorLiteral(red: 0.4294961989, green: 0.3018877506, blue: 0.2140608728, alpha: 1)
            numLineView.snp.makeConstraints ({
                (make) in
                make.height.equalTo(3)
            })
        }
    }
    
    //MARK: 문자발송 액션
    @IBAction func messageAction(_ sender: UIButton) {
        
        check = !check
//        postAuthenticatePhone(_phone: gsno(phoneTextField.text))
        print(check)
        
    }
    
    //MARK: 다음 액션
    @IBAction func nextAction(_ sender: UIButton) {
        if phoneTextField.text == "" || numTextField.text == ""  || check == false {
            simpleAlert(title: "", message: "휴대폰 인증을 완료해주세요.")
        } else if numTextField.text != messageCode?.description {
            self.simpleAlert(title: "인증 실패", message: "인증 번호가 일치하지 않습니다.")
        } else {
            parentVC?.changeVC(num: 3)
        }

    }
}

//MARK: Networking Extension
extension Care1ViewController {
    
    //MARK: 휴대폰 인증
    func postAuthenticatePhone(_phone : String) {
        
        AuthenticatePhoneService.shareInstance.postAuthenticatePhone(phone: _phone) {
            (result) in
            
            switch result {
            case .networkSuccess(let codeData):
                let code = codeData as? Int
                self.messageCode = code
                self.simpleAlert(title: "발송 완료", message: "인증 번호가 발송되었습니다.")
                break
                
            //FIXME: 400 에러 수정
            case .badRequest:
                self.simpleAlert(title: "인증 실패", message: "핸드폰 번호 형식이 올바르지 않습니다.")
                break
                
            case .requestFail:
                self.simpleAlert(title: "발송 실패", message:
                """
                문자 발송이 실패하였습니다.
                다시 시도해주세요.
                """)
                break
                
            case .networkFail:
                self.networkErrorAlert()
                break
                
            default:
                self.simpleAlert(title: "오류", message: "다시 시도해주세요.")
                break
            }
            
        }
    }

}

//MARK: TableView Keyboard Setting Extension
extension Care1ViewController {
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardHeight = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height {
            tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardHeight, right: 0)
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        UIView.animate(withDuration: 0.2, animations: {
            // For some reason adding inset in keyboardWillShow is animated by itself but removing is not, that's why we have to use animateWithDuration here
            self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        })
    }
}


