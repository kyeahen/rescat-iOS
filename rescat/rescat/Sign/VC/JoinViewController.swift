//
//  JoinViewController.swift
//  rescat
//
//  Created by 김예은 on 23/12/2018.
//  Copyright © 2018 kyeahen. All rights reserved.
//

import UIKit
import SnapKit

class JoinViewController: UIViewController {
    
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var pwdTextField: UITextField!
    @IBOutlet weak var pwdCheckTextField: UITextField!
    @IBOutlet weak var nickNameTextField: UITextField!
    
    @IBOutlet weak var idLineView: UIView!
    @IBOutlet weak var pwdLineView: UIView!
    @IBOutlet weak var pwdCheckLineView: UIView!
    @IBOutlet weak var nickNameLineView: UIView!
    
    @IBOutlet weak var idCheckButton: UIButton!
    @IBOutlet weak var nickNameButton: UIButton!
    
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var nickNameLabel: UILabel!
    
    @IBOutlet weak var joinButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.barTintColor = UIColor.white
        
        setCustomView()
        setEmptyCheck()
    }
    
    //MARK: 뷰 요소 커스텀 세팅
    func setCustomView() {
        
        idLabel.isHidden = true
        nickNameLabel.isHidden = true
        
        joinButton.makeRounded(cornerRadius: 8)
    }
    
    func setEmptyCheck() {
        
        //FIXME: height 변경 확인
        idTextField.addTarget(self, action: #selector(emptyIdCheck), for: .editingChanged)
        pwdTextField.addTarget(self, action: #selector(emptyPwdCheck), for: .editingChanged)
        pwdCheckTextField.addTarget(self, action: #selector(emptyPwdreCheck), for: .editingChanged)
        nickNameTextField.addTarget(self, action: #selector(emptyNickNameCheck), for: .editingChanged)
        
        idTextField.addTarget(self, action: #selector(emptyAllCheck), for: .editingChanged)
        pwdTextField.addTarget(self, action: #selector(emptyAllCheck), for: .editingChanged)
        pwdCheckTextField.addTarget(self, action: #selector(emptyAllCheck), for: .editingChanged)
        nickNameTextField.addTarget(self, action: #selector(emptyAllCheck), for: .editingChanged)
    }
    
    //MARK: 아이디 공백 체크 함수
    @objc func emptyIdCheck() {
        
        if idTextField.text == ""{
            idLineView.backgroundColor = #colorLiteral(red: 0.7567955852, green: 0.7569058537, blue: 0.7567716241, alpha: 1)
            idLineView.snp.makeConstraints {
                (make) in
                make.height.equalTo(1)
            }
        } else {
            idLineView.backgroundColor = #colorLiteral(red: 0.4294961989, green: 0.3018877506, blue: 0.2140608728, alpha: 1)
            idLineView.snp.makeConstraints {
                (make) in
                make.height.equalTo(3)
            }
        }
    }
    
    //MARK: 비밀번호 공백 체크 함수
    @objc func emptyPwdCheck() {
        
        if pwdTextField.text == ""{
            pwdLineView.backgroundColor = #colorLiteral(red: 0.7567955852, green: 0.7569058537, blue: 0.7567716241, alpha: 1)
            pwdLineView.snp.makeConstraints {
                (make) in
                make.height.equalTo(1)
            }
        } else {
            pwdLineView.backgroundColor = #colorLiteral(red: 0.4294961989, green: 0.3018877506, blue: 0.2140608728, alpha: 1)
            pwdLineView.snp.makeConstraints {
                (make) in
                make.height.equalTo(3)
            }
        }
    }
    
    //MARK: 비밀번호 체크 공백 체크 함수
    @objc func emptyPwdreCheck() {
        
        if pwdCheckTextField.text == ""{
            pwdCheckLineView.backgroundColor = #colorLiteral(red: 0.7567955852, green: 0.7569058537, blue: 0.7567716241, alpha: 1)
            pwdCheckLineView.snp.makeConstraints {
                (make) in
                make.height.equalTo(1)
            }
        } else {
            pwdCheckLineView.backgroundColor = #colorLiteral(red: 0.4294961989, green: 0.3018877506, blue: 0.2140608728, alpha: 1)
            pwdCheckLineView.snp.makeConstraints {
                (make) in
                make.height.equalTo(3)
            }
        }
    }
    
    //MARK: 닉네임 공백 체크 함수
    @objc func emptyNickNameCheck() {
        
        if nickNameTextField.text == ""{
            nickNameLineView.backgroundColor = #colorLiteral(red: 0.7567955852, green: 0.7569058537, blue: 0.7567716241, alpha: 1)
            nickNameLineView.snp.makeConstraints {
                (make) in
                make.height.equalTo(1)
            }
        } else {
            nickNameLineView.backgroundColor = #colorLiteral(red: 0.4294961989, green: 0.3018877506, blue: 0.2140608728, alpha: 1)
            nickNameLineView.snp.makeConstraints {
                (make) in
                make.height.equalTo(3)
            }
        }
    }
    
    //MARK: 모든 항목 공백 체크 함수
    @objc func emptyAllCheck() {
        
        if nickNameTextField.text == "" || idTextField.text == "" || pwdTextField.text == "" || pwdCheckTextField.text == ""{
            joinButton.backgroundColor = #colorLiteral(red: 0.7470303178, green: 0.5998028517, blue: 0.5045881271, alpha: 1)
        } else {
             joinButton.backgroundColor = #colorLiteral(red: 0.4660801291, green: 0.3617350459, blue: 0.2922770977, alpha: 1)
        }
    }
    
    //MARK: 아이디 중복 체크 액션
    //TODO: 통신 후, 라벨로 여부 알림
    @IBAction func idCheckAction(_ sender: UIButton) {
    }
    
    //MARK: 비밀번호 중복 체크 액션
    //TODO: 통신 후, 라벨로 여부 알림
    @IBAction func nickNameCheckAction(_ sender: UIButton) {
    }
    
    //MARK: 회원가입 액션
    @IBAction func joinAction(_ sender: UIButton) {
        
        let welcomeVC = UIStoryboard(name: "Sign", bundle: nil).instantiateViewController(withIdentifier: WelcomeJoinViewController.reuseIdentifier)
        
        self.navigationController?.pushViewController(welcomeVC, animated: true)
        
    }
    
}

//MARK: 서버 통신 Extension
extension JoinViewController {
    
}

