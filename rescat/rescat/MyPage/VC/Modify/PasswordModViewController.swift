//
//  PasswordModViewController.swift
//  rescat
//
//  Created by 김예은 on 06/01/2019.
//  Copyright © 2019 kyeahen. All rights reserved.
//

import UIKit

class PasswordModViewController: UIViewController {

    @IBOutlet weak var pwdTextField: UITextField!
    @IBOutlet weak var newTextField: UITextField!
    @IBOutlet weak var rePwdTextField: UITextField!
    
    @IBOutlet weak var pwdLineView: UIView!
    @IBOutlet weak var newLineView: UIView!
    @IBOutlet weak var reLineView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setCustomView()
        setEmptyCheck()
    }
    
    //MARK: 뷰 요소 커스텀 세팅
    func setCustomView() {
        setBackBtn()
        setRightBarButtonItem()
        self.navigationItem.title = "비밀번호 변경"
    }
    
    func setEmptyCheck() {
        
        //FIXME: height 변경 확인
        pwdTextField.addTarget(self, action: #selector(emptyPwdCheck), for: .editingChanged)
        newTextField.addTarget(self, action: #selector(emptyNewCheck), for: .editingChanged)
        rePwdTextField.addTarget(self, action: #selector(emptyReCheck), for: .editingChanged)
        
    }
    
    //MARK: 비밀번호 공백 체크 함수
    @objc func emptyPwdCheck() {
        
        if pwdTextField.text == ""{
            pwdLineView.backgroundColor = #colorLiteral(red: 0.7450318933, green: 0.7451406121, blue: 0.7450081706, alpha: 1)
            pwdLineView.snp.makeConstraints ({
                (make) in
                make.height.equalTo(1)
            })
        } else {
            pwdLineView.backgroundColor = #colorLiteral(red: 0.4210352302, green: 0.298186332, blue: 0.2102506161, alpha: 1)
            pwdLineView.snp.makeConstraints ({
                (make) in
                make.height.equalTo(10)
            })
        }
    }
    
    //MARK: 새 비밀번호 공백 체크 함수
    @objc func emptyNewCheck() {
        
        if newTextField.text == ""{
            newLineView.backgroundColor = #colorLiteral(red: 0.7450318933, green: 0.7451406121, blue: 0.7450081706, alpha: 1)
            newLineView.snp.makeConstraints ({
                (make) in
                make.height.equalTo(1)
            })
        } else {
            newLineView.backgroundColor = #colorLiteral(red: 0.4210352302, green: 0.298186332, blue: 0.2102506161, alpha: 1)
            newLineView.snp.makeConstraints ({
                (make) in
                make.height.equalTo(10)
            })
        }
    }
    
    //MARK: 비밀번호 확인 공백 체크 함수
    @objc func emptyReCheck() {
        
        if rePwdTextField.text == ""{
            reLineView.backgroundColor = #colorLiteral(red: 0.7450318933, green: 0.7451406121, blue: 0.7450081706, alpha: 1)
            reLineView.snp.makeConstraints ({
                (make) in
                make.height.equalTo(1)
            })
        } else {
            reLineView.backgroundColor = #colorLiteral(red: 0.4210352302, green: 0.298186332, blue: 0.2102506161, alpha: 1)
            reLineView.snp.makeConstraints ({
                (make) in
                make.height.equalTo(10)
            })
        }
    }
    
    //MARK: rightBarButtonItem Setting
    func setRightBarButtonItem() {
        let rightButtonItem = UIBarButtonItem.init(
            title: "완료",
            style: .done,
            target: self,
            action: #selector(rightButtonAction(sender:))
        )
        self.navigationItem.rightBarButtonItem = rightButtonItem
        self.navigationItem.rightBarButtonItem?.tintColor =  #colorLiteral(red: 0.9108466506, green: 0.5437278748, blue: 0.5438123941, alpha: 1)
        self.navigationItem.rightBarButtonItem?.setTitleTextAttributes([
            NSAttributedString.Key.font : UIFont(name: AppleSDGothicNeo.Bold.rawValue, size: 16)], for: .normal)
    }
    
    //MARK: rightBarButtonItem Action
    @objc func rightButtonAction(sender: UIBarButtonItem) {
        if pwdTextField.text == "" || rePwdTextField.text == "" || newTextField.text == "" {
            self.simpleAlert(title: "", message: "모든 항목을 입력해주세요.")
        } else if newTextField.text != rePwdTextField.text {
          self.simpleAlert(title: "변경 실패", message: "새 비밀번호가 일치하지 않습니다")
        } else {
            putModPwd(pwd: gsno(pwdTextField.text), newPwd: gsno(rePwdTextField.text), reNewPwd: gsno(newTextField.text))
        }
    }

}

//MARK: Networking Extension
extension PasswordModViewController {
    
    func putModPwd(pwd: String, newPwd: String, reNewPwd: String) {

        let params : [String : Any] = ["password": pwd,
                                       "newPassword": newPwd,
                                       "reNewPassword": reNewPwd]
        
        ModifyPwdService.shareInstance.putModPwd(params: params, completion: {
            (result) in
            switch result {
            case .networkSuccess(_ ) : //200
                
                self.navigationController?.popViewController(animated: true)
                break
                
            case .badRequest : //400
                self.simpleAlert(title: "변경 실패", message: "비밀번호 형식이 알맞지 않거나 틀렸습니다.")
                break
                
            case .accessDenied : //401
                self.simpleAlert(title: "권한 없음", message: "회원가입 후, 이용 가능합니다.")
                break
                
            case .networkFail :
                self.networkErrorAlert()
                break
                
            default :
                self.simpleAlert(title: "오류", message: "다시 시도해주세요.")
                break
            }
        })
    }
}
