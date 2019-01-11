//
//  PhoneModViewController.swift
//  rescat
//
//  Created by 김예은 on 06/01/2019.
//  Copyright © 2019 kyeahen. All rights reserved.
//

import UIKit

class PhoneModViewController: UIViewController {
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var checkButton: UIButton!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var numTextField: UITextField!
    @IBOutlet weak var phoneLineView: UIView!
    @IBOutlet weak var numLineView: UIView!
    
    var messageCode: Int?
    var phoneNum: String = ""
    
    var phoneCheck: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setCustomView()
        setEmptyCheck()
        hideKeyboardWhenTappedAround()
    }
    
    //MARK: 뷰 요소 커스텀 세팅
    func setCustomView() {
        saveButton.setTitleTextAttributes([
            NSAttributedString.Key.font : UIFont(name: AppleSDGothicNeo.Bold.rawValue, size: 16)], for: .normal)
        checkButton.setTitleColor(#colorLiteral(red: 0.7411106229, green: 0.7412187457, blue: 0.7410870194, alpha: 1), for: .normal)
        checkButton.isEnabled = false
        
    }
    
    func setEmptyCheck() {
        
        phoneTextField.addTarget(self, action: #selector(emptyPhoneCheck), for: .editingChanged)
        numTextField.addTarget(self, action: #selector(emptyNumCheck), for: .editingChanged)
        
    }
    
    //MARK: 전화번호 공백 체크 함수
    @objc func emptyPhoneCheck() {
        
        if phoneTextField.text == ""{
            checkButton.isEnabled = false
            checkButton.setTitleColor(#colorLiteral(red: 0.7411106229, green: 0.7412187457, blue: 0.7410870194, alpha: 1), for: .normal)
            
            phoneLineView.backgroundColor = #colorLiteral(red: 0.7567955852, green: 0.7569058537, blue: 0.7567716241, alpha: 1)

        } else {
            checkButton.isEnabled = true
            checkButton.setTitleColor(#colorLiteral(red: 0.741232574, green: 0.6081386209, blue: 0.5216988921, alpha: 1), for: .normal)
            phoneLineView.backgroundColor = #colorLiteral(red: 0.4294961989, green: 0.3018877506, blue: 0.2140608728, alpha: 1)

        }
    }
    
    //MARK: 인증번호 공백 체크 함수
    @objc func emptyNumCheck() {
        
        if numTextField.text == ""{
            numLineView.backgroundColor = #colorLiteral(red: 0.7567955852, green: 0.7569058537, blue: 0.7567716241, alpha: 1)
 
        } else {
            numLineView.backgroundColor = #colorLiteral(red: 0.4294961989, green: 0.3018877506, blue: 0.2140608728, alpha: 1)

        }
    }
    
    
    
    //MARK: 문자발송 액션
    @IBAction func messageAction(_ sender: UIButton) {
        
        UserDefaults.standard.removeObject(forKey: "phone")
        UserDefaults.standard.set(gsno(phoneTextField.text), forKey: "phone")
        postAuthenticatePhone(_phone: gsno(phoneTextField.text))
    }
    
    //MARK: 완료 액션
    @IBAction func saveAction(_ sender: UIBarButtonItem) {
        
        var phone = UserDefaults.standard.string(forKey: "phone")
        if phoneTextField.text == "" || numTextField.text == "" || phoneCheck == 0 {
            simpleAlert(title: "", message: "휴대폰 인증을 완료해주세요.")
        } else if numTextField.text != messageCode?.description {
            self.simpleAlert(title: "인증 실패", message: "인증 번호가 일치하지 않습니다.")
        } else if phone != phoneTextField.text {
            self.simpleAlert(title: "인증 실패", message:
            """
            입력된 전화번호가 발송된 전화번호와
            일치하지 않습니다.
            """)
        } else {
            putModPhone(_phone: gsno(phoneTextField.text))
            
        }
    }
    
    //MARK: 창닫기 액션
    @IBAction func dismissAction(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
}

//MARK: Networking Extension
extension PhoneModViewController {
    
    //MARK: 휴대폰 인증
    func postAuthenticatePhone(_phone : String) {
        
        AuthenticatePhoneService.shareInstance.postAuthenticatePhone(phone: _phone) {
            (result) in
            
            switch result {
            case .networkSuccess(let codeData):
                let code = codeData as? Int
                self.messageCode = code
                self.phoneCheck = 1
                self.simpleAlert(title: "발송 완료", message: "인증 번호가 발송되었습니다.")
                break
                
            //FIXME: 400 에러 수정
            case .badRequest:
                self.simpleAlert(title: "", message: "핸드폰 번호 형식이 올바르지 않습니다.")
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
    
    //MARK: 번호 수정
    func putModPhone(_phone : String) {
        
        ModifyUserDataService.shareInstance.putModPhoneData(phone: _phone, params: [:]) {
            (result) in
            
            switch result {
            case .networkSuccess(_ ):
                self.phoneNum = self.gsno(self.phoneTextField.text)
                self.performSegue(withIdentifier: "unwindToListPhone", sender: self)
                break
                

            case .accessDenied:
                self.simpleAlert(title: "", message: "회원가입 후, 이용할 수 있습니다.")
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
