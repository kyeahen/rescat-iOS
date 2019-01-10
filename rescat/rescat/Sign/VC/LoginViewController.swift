//
//  LoginViewController.swift
//  rescat
//
//  Created by 김예은 on 28/12/2018.
//  Copyright © 2018 kyeahen. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var pwdTextField: UITextField!
    
    @IBOutlet weak var idLineView: UIView!
    @IBOutlet weak var pwdLineView: UIView!
    
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.setNavigationBarHidden(false, animated: true)
        hideKeyboardWhenTappedAround()
        
        setBackBtn()
        setCustomView()
        setEmptyCheck()
    

    }
    
    //MARK: 뷰 요소 커스텀 세팅
    func setCustomView() {
        
        idTextField.tintColor = #colorLiteral(red: 0.9272156358, green: 0.5553016067, blue: 0.5554865003, alpha: 1)
        pwdTextField.tintColor = #colorLiteral(red: 0.9272156358, green: 0.5553016067, blue: 0.5554865003, alpha: 1)
        
        loginButton.makeRounded(cornerRadius: 8)
    }
    
    func setEmptyCheck() {
        
        //FIXME: height 변경 확인
        idTextField.addTarget(self, action: #selector(emptyIdCheck), for: .editingChanged)
        pwdTextField.addTarget(self, action: #selector(emptyPwdCheck), for: .editingChanged)
        
    }
    
    //MARK: 아이디 공백 체크 함수
    @objc func emptyIdCheck() {
        
        if idTextField.text == ""{
            idLineView.backgroundColor = #colorLiteral(red: 0.7567955852, green: 0.7569058537, blue: 0.7567716241, alpha: 1)
            idLineView.snp.makeConstraints ({
                (make) in
                make.height.equalTo(1)
            })
        } else {
            idLineView.backgroundColor = #colorLiteral(red: 0.4294961989, green: 0.3018877506, blue: 0.2140608728, alpha: 1)
            idLineView.snp.makeConstraints ({
                (make) in
                make.height.equalTo(10)
            })
        }
    }
    
    //MARK: 비밀번호 공백 체크 함수
    @objc func emptyPwdCheck() {
        
        if pwdTextField.text == ""{
            pwdLineView.backgroundColor = #colorLiteral(red: 0.7567955852, green: 0.7569058537, blue: 0.7567716241, alpha: 1)
            pwdLineView.snp.makeConstraints ({
                (make) in
                make.height.equalTo(1)
            })
        } else {
            pwdLineView.backgroundColor = #colorLiteral(red: 0.4294961989, green: 0.3018877506, blue: 0.2140608728, alpha: 1)
            pwdLineView.snp.makeConstraints ({
                (make) in
                make.height.equalTo(3)
            })
        }
    }
    
    //MARK: 로그인 액션
    @IBAction func loginAction(_ sender: UIButton) {
        
        //TODO: 팝업으로 띄울건지 비활성화 시킬건지 물어보기
        if idTextField.text == "" || pwdTextField.text == "" {
            self.simpleAlert(title: "실패", message: "모든 항목을 입력해주세요.")
        } else {
            postLogin(id: gsno(idTextField.text), pwd: gsno(pwdTextField.text))
        }
    }
    
}


//MARK: Networking Extension
extension LoginViewController {
    
    func postLogin(id: String, pwd: String) {
        
        guard let fcmToken = UserDefaults.standard.string(forKey: "fcmToken") else {return}
        
        let params : [String : Any] = ["id" : id,
                                       "password" : pwd,
                                       "instanceToken": fcmToken]
        
        LoginService.shareInstance.postLogin(params: params) {(result) in
            
            switch result {
            case .networkSuccess( _): //200
                let tabVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: TabBarController.reuseIdentifier)
                self.present(tabVC, animated: true, completion: nil)
                break
            
            case .accessDenied, .badRequest: //401(없는 사용자), 400(비번 불일치)
                self.simpleAlert(title: "로그인 실패", message: "아이디나 비밀번호가 일치하지 않습니다.")
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
