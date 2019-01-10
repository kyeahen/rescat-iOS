//
//  NickNameModViewController.swift
//  rescat
//
//  Created by 김예은 on 06/01/2019.
//  Copyright © 2019 kyeahen. All rights reserved.
//

import UIKit

class NickNameModViewController: UIViewController {
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var nickNameTextField: UITextField!
    @IBOutlet weak var nickNameLineView: UIView!
    @IBOutlet weak var checkLabel: UILabel!
    @IBOutlet weak var checkButton: UIButton!
    
    var nickName: String = ""
    var nickCheck: Int = 0
    
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
        checkLabel.isHidden = true
        checkButton.setTitleColor(#colorLiteral(red: 0.7411106229, green: 0.7412187457, blue: 0.7410870194, alpha: 1), for: .normal)
        checkButton.isEnabled = false
        
    }
    
    func setEmptyCheck() {
        
        nickNameTextField.addTarget(self, action: #selector(emptyNickCheck), for: .editingChanged)

    }
    
    //MARK: 닉네임 공백 체크 함수
    @objc func emptyNickCheck() {
        
        if nickNameTextField.text == ""{
            nickNameLineView.backgroundColor = #colorLiteral(red: 0.7450318933, green: 0.7451406121, blue: 0.7450081706, alpha: 1)
            checkButton.setTitleColor(#colorLiteral(red: 0.7411106229, green: 0.7412187457, blue: 0.7410870194, alpha: 1), for: .normal)
            checkButton.isEnabled = false
            checkLabel.isHidden = true
            

        } else {
            nickNameLineView.backgroundColor = #colorLiteral(red: 0.4210352302, green: 0.298186332, blue: 0.2102506161, alpha: 1)
            checkButton.setTitleColor(#colorLiteral(red: 0.741232574, green: 0.6081386209, blue: 0.5216988921, alpha: 1), for: .normal)
            checkButton.isEnabled = true

        }
    }
    
    //MARK: 닉네임 중복확인 액션
    @IBAction func checkAction(_ sender: UIButton) {
        postCheckNickName(_nickName: gsno(nickNameTextField.text))
    }
    
    //MARK: 완료 액션
    @IBAction func saveAction(_ sender: UIBarButtonItem) {
        
        if nickNameTextField.text == "" {
            self.simpleAlert(title: "", message: "수정할 닉네임을 입력해주세요.")
        } else if nickCheck == 0{
            self.simpleAlert(title: "", message: "닉네임 중복확인을 완료해주세요.")
        } else {
            putModNickName(_nickname: gsno(nickNameTextField.text))
        }

    }
    
    //MARK: 창닫기 액션
    @IBAction func dismissAction(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension NickNameModViewController {
    
    //MARK: 닉네임 중복 검사
    func postCheckNickName(_nickName : String) {
        
        DuplicatedNickService.shareInstance.postDuplicatedNick(nickName: _nickName) {(result) in
            
            switch result {
            case .networkSuccess( _):
                self.nickCheck = 1
                self.checkLabel.isHidden = false
                self.checkLabel.text = "사용할 수 있는 닉네임입니다."
                self.checkLabel.textColor = #colorLiteral(red: 0.4895007014, green: 0.8178752065, blue: 0.1274456084, alpha: 1)
                break
                
            case .badRequest :
                self.simpleAlert(title: "", message:
                    """
                닉네임은 특수문자 제외
                2~20자이어야 합니다.
                """)
                break
                
            case .duplicated :
                
                self.checkLabel.isHidden = false
                self.checkLabel.text = "사용할 수 없는 닉네임입니다."
                self.checkLabel.textColor = #colorLiteral(red: 0.7753539681, green: 0.01265258342, blue: 0.1038821563, alpha: 1)
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
    
    //MARK: 닉네임 수정
    func putModNickName(_nickname : String) {
        
        ModifyUserDataService.shareInstance.putModNickNameData(nickname: _nickname, params: [:]) {
            (result) in
            
            switch result {
            case .networkSuccess(_ ):
                self.nickName = self.gsno(self.nickNameTextField.text)
                self.performSegue(withIdentifier: "unwindToListNick", sender: self)
                break
                
                
            case .accessDenied:
                self.simpleAlert(title: "", message: "회원가입 후, 이용할 수 있습니다.")
                break
                
            case .duplicated:
                self.simpleAlert(title: "", message: "이미 사용중인 닉네임 입니다.")
                
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
