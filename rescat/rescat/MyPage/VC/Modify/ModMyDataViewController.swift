//
//  ModMyDataViewController.swift
//  rescat
//
//  Created by 김예은 on 06/01/2019.
//  Copyright © 2019 kyeahen. All rights reserved.
//

import UIKit

class ModMyDataViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var myPages: [String] = [String]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    var nickName: String = ""
    var phone:String = ""
    
    var dataRecieved: String? {
        willSet {
            myPages[2] = newValue as! String

        }
    }
    
    var dataRecieved1: String? {
        willSet {
            myPages[3] = newValue as! String

        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTableView()
        setBackBtn()
        getMyData()
    }
    
    //MARK: 테이블 뷰 세팅
    func setTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.tableFooterView = UIView(frame: .zero)
    }
    
    //MARK: 닉네임 수정 뷰로 이동
    func modNickAction() {
        let nickVC = UIStoryboard(name: "MyPage", bundle: nil).instantiateViewController(withIdentifier: "NickNameNaviVC")
        
        self.present(nickVC, animated: true, completion: nil)
        
        
    }
    
    //MARK: 전화번호 수정 뷰로 이동
    func modPhonekAction() {
        
        let nickVC = UIStoryboard(name: "MyPage", bundle: nil).instantiateViewController(withIdentifier: "PhoneNaviVC")
        
        self.present(nickVC, animated: true, completion: nil)
        
    }
    
    //MARK: UnwindSegue (닉네임 -> 리스트)
    @IBAction func unwindToListNick(sender: UIStoryboardSegue) {
        if let nickVC = sender.source as? NickNameModViewController {
            dataRecieved = nickVC.nickName
        }
    }
    
    //MARK: UnwindSegue (전화번호 -> 리스트)
    @IBAction func unwindToListPhone(sender: UIStoryboardSegue) {
        if let phoneVC = sender.source as? PhoneModViewController {
            dataRecieved1 = phoneVC.phoneNum
        }
    }
    

}

//MARK: TableView Extension
extension ModMyDataViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myPages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ModMyDataTableViewCell.reuseIdentifier) as! ModMyDataTableViewCell
        
        if indexPath.row == 0 {
            cell.modifyButton.isHidden = true
            cell.titleLabel.text = "이름"
        } else if indexPath.row == 1 {
            cell.modifyButton.isHidden = true
            cell.titleLabel.text = "아이디"
        } else if indexPath.row == 2 {
            cell.modifyButton.isHidden = false
            cell.titleLabel.text = "닉네임"
            cell.modHandler = modNickAction
        } else {
            cell.modifyButton.isHidden = false
            cell.titleLabel.text = "전화번호"
            cell.modHandler = modPhonekAction
        }
        
        cell.contentLabel.text = myPages[indexPath.row]
        
        return cell
    }
    
    //회원정보 조회
    func getMyData() {
        GetMyPageDataService.shareInstance.getMyDataInit(completion: {
            (result) in
            
            switch result {
            case .networkSuccess(let data) :
                let myPageData = data as? MyPageData
                
                let role = self.gsno(UserDefaults.standard.string(forKey: "role"))
                if let resResult = myPageData {
                    
                    if role == careMapping.care.rawValue {
                        
                        self.myPages.append(self.gsno(resResult.name))
                        self.myPages.append(self.gsno(resResult.id))
                        self.myPages.append(self.gsno(resResult.nickname))
                        self.myPages.append(self.gsno(resResult.phone))
                    } else {
                        self.myPages.append(self.gsno(resResult.name))
                        self.myPages.append(self.gsno(resResult.id))
                        self.myPages.append(self.gsno(resResult.nickname))

                    }
                    
                }
                break
                
            case .accessDenied :
                self.simpleAlert(title: "", message: "회원가입 후 이용할 수 있습니다.")
                break
                
            case .networkFail :
                self.networkErrorAlert()
                break
                
            default :
                self.simpleAlert(title: "오류", message: "다시 시도해주세요")
                break
            }
            
        })
    }
    
    
}
