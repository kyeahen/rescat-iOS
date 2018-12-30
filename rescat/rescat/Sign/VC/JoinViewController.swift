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
    
    @IBOutlet weak var infoButton: UIButton!
    @IBOutlet weak var joinButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.barTintColor = UIColor.white
        
        setCustomView()
        setEmptyCheck()
        
        let label = UILabel()
        label.text = "Title Label"
//        label.textAlignment = .left
        label.font = UIFont(name: AppleSDGothicNeo.Bold.rawValue, size: 16)
        self.navigationItem.titleView = label
        
        label.snp.makeConstraints {
            (make) in
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(100)
        }

    }
    
    override func viewWillAppear(_ animated: Bool) {

        idLabel.isHidden = true
        nickNameLabel.isHidden = true
    }
    
    //MARK: 뷰 요소 커스텀 세팅
    func setCustomView() {
        
        idLabel.isHidden = true
        nickNameLabel.isHidden = true
        
        idCheckButton.isEnabled = false
        nickNameButton.isEnabled = false
        idCheckButton.setTitleColor(#colorLiteral(red: 0.7411106229, green: 0.7412187457, blue: 0.7410870194, alpha: 1), for: .disabled)
        nickNameButton.setTitleColor(#colorLiteral(red: 0.7411106229, green: 0.7412187457, blue: 0.7410870194, alpha: 1), for: .disabled)
        
        idTextField.tintColor = #colorLiteral(red: 0.9272156358, green: 0.5553016067, blue: 0.5554865003, alpha: 1)
        pwdTextField.tintColor = #colorLiteral(red: 0.9272156358, green: 0.5553016067, blue: 0.5554865003, alpha: 1)
        pwdCheckTextField.tintColor = #colorLiteral(red: 0.9272156358, green: 0.5553016067, blue: 0.5554865003, alpha: 1)
        nickNameTextField.tintColor = #colorLiteral(red: 0.9272156358, green: 0.5553016067, blue: 0.5554865003, alpha: 1)
        
        infoButton.underline()
        joinButton.makeRounded(cornerRadius: 8)
    }
    
    func setEmptyCheck() {
        
        //FIXME: height 변경 확인
        idTextField.addTarget(self, action: #selector(emptyIdCheck), for: .editingChanged)
        pwdTextField.addTarget(self, action: #selector(emptyPwdCheck), for: .editingChanged)
        pwdCheckTextField.addTarget(self, action: #selector(emptyPwdreCheck), for: .editingChanged)
        nickNameTextField.addTarget(self, action: #selector(emptyNickNameCheck), for: .editingChanged)
        
    }
    
    //MARK: 아이디 공백 체크 함수
    @objc func emptyIdCheck() {
        
        if idTextField.text == ""{
            idCheckButton.isEnabled = false
            idCheckButton.setTitleColor(#colorLiteral(red: 0.7411106229, green: 0.7412187457, blue: 0.7410870194, alpha: 1), for: .normal)
            
            idLineView.backgroundColor = #colorLiteral(red: 0.7567955852, green: 0.7569058537, blue: 0.7567716241, alpha: 1)
            idLineView.snp.makeConstraints {
                (make) in
                make.height.equalTo(1)
            }
        } else {
            idCheckButton.isEnabled = true
            idCheckButton.setTitleColor(#colorLiteral(red: 0.9108466506, green: 0.5437278748, blue: 0.5438123941, alpha: 1), for: .normal)

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
            nickNameButton.isEnabled = false
            nickNameButton.setTitleColor(#colorLiteral(red: 0.7411106229, green: 0.7412187457, blue: 0.7410870194, alpha: 1), for: .normal)
            
            nickNameLineView.backgroundColor = #colorLiteral(red: 0.7567955852, green: 0.7569058537, blue: 0.7567716241, alpha: 1)
            nickNameLineView.snp.makeConstraints {
                (make) in
                make.height.equalTo(1)
            }
        } else {
            nickNameButton.isEnabled = true
            nickNameButton.setTitleColor(#colorLiteral(red: 0.9108466506, green: 0.5437278748, blue: 0.5438123941, alpha: 1), for: .normal)
            
            nickNameLineView.backgroundColor = #colorLiteral(red: 0.4294961989, green: 0.3018877506, blue: 0.2140608728, alpha: 1)
            nickNameLineView.snp.makeConstraints {
                (make) in
                make.height.equalTo(3)
            }
        }
    }
    
    //MARK: 아이디 중복 체크 액션
    //TODO: 통신 후, 라벨로 여부 알림
    @IBAction func idCheckAction(_ sender: UIButton) {
        postCheckID(_id: gsno(idTextField.text))
    }
    
    //MARK: 비밀번호 중복 체크 액션
    //TODO: 통신 후, 라벨로 여부 알림
    @IBAction func nickNameCheckAction(_ sender: UIButton) {
        postCheckNickName(_nickName: gsno(nickNameTextField.text))
    }
    
    //MARK: 회원약관 액션
    @IBAction func infoAction(_ sender: UIButton) {
        //회원 약관 페이지로 이동
    }
    
    
    //MARK: 회원가입 액션
    @IBAction func joinAction(_ sender: UIButton) {
        
        if idTextField.text == "" || pwdTextField.text == "" || pwdCheckTextField.text == "" || nickNameTextField.text == "" {
            self.simpleAlert(title: "회원가입 실패", message: "모든 항목을 입력해주세요.")
        } else if pwdTextField.text != pwdCheckTextField.text {
            self.simpleAlert(title: "회원가입 실패", message: "비밀번호가 일치하지 않습니다.")
        } else {
            postJoin(id: gsno(idTextField.text), pwd: gsno(pwdTextField.text), rePwd: gsno(pwdCheckTextField.text), nickName: gsno(nickNameTextField.text))
        }
        
    }
    
}

//MARK: 서버 통신 Extension
extension JoinViewController {
    
    //MARK: 회원가입
    func postJoin(id: String, pwd: String, rePwd: String, nickName: String) {
        
        
        let params : [String : Any] = ["id" : id,
                                       "password" : pwd,
                                       "rePassword": rePwd,
                                       "nickname": nickName]
        
        JoinService.shareInstance.postJoin(params: params) {(result) in
            
            switch result {
            case .networkSuccess( _): //201
                
                let welcomeVC = UIStoryboard(name: "Sign", bundle: nil).instantiateViewController(withIdentifier: "WelcomVCNavi")
                
                self.present(welcomeVC, animated: true, completion: nil)
                break
                
            case .badRequest: //400
                self.simpleAlert(title: "회원가입 실패", message: "아이디나 비밀번호 형식이 올바르지 않습니다.")
                break
                
            case .duplicated: //409

                self.simpleAlert(title: "회원가입 실패", message: "아이디 또는 닉네임이 중복되었습니다.")
                break
                
            case .networkFail:
                self.networkErrorAlert()
                break
                
            default:
                self.simpleAlert(title: "오류", message: "다시 시도해주세요")
                break
            }
        }
    }
    
    //MARK: 아이디 중복 검사
    func postCheckID(_id : String) {
 
        DuplicatedIDService.shareInstance.postDuplicatedID(id: _id) {(result) in
            
            switch result {
            case .networkSuccess( _):
                
                self.idLabel.isHidden = false
                self.idLabel.text = "사용할 수 있는 아이디입니다."
                self.idLabel.textColor = #colorLiteral(red: 0.4895007014, green: 0.8178752065, blue: 0.1274456084, alpha: 1)
                break
                
            case .duplicated :
                
                self.idLabel.isHidden = false
                self.idLabel.text = "사용할 수 없는 아이디입니다."
                self.idLabel.textColor = #colorLiteral(red: 0.7753539681, green: 0.01265258342, blue: 0.1038821563, alpha: 1)
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
    
    
    //MARK: 닉네임 중복 검사
    func postCheckNickName(_nickName : String) {
        
        DuplicatedNickService.shareInstance.postDuplicatedNick(nickName: _nickName) {(result) in
            
            switch result {
            case .networkSuccess( _):
                
                self.nickNameLabel.isHidden = false
                self.nickNameLabel.text = "사용할 수 있는 닉네임입니다."
                self.nickNameLabel.textColor = #colorLiteral(red: 0.4895007014, green: 0.8178752065, blue: 0.1274456084, alpha: 1)
                break
                
            case .duplicated :
                
                self.nickNameLabel.isHidden = false
                self.nickNameLabel.text = "사용할 수 없는 닉네임입니다."
                self.nickNameLabel.textColor = #colorLiteral(red: 0.7753539681, green: 0.01265258342, blue: 0.1038821563, alpha: 1)
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


