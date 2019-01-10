//
//  MyPageViewController.swift
//  rescat
//
//  Created by 김예은 on 23/12/2018.
//  Copyright © 2018 kyeahen. All rights reserved.
//

import UIKit

class MyPageViewController: UIViewController{
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var viewBottomC: NSLayoutConstraint!
    @IBOutlet weak var backImageView: UIImageView!
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var joinButton: UIButton!
    @IBOutlet weak var careImageView: UIImageView!
    
    var secondArr = ["내가 참여한 후원글", "내가 작성한 글"]
    var thirdArr = ["정보수정", "비밀번호 변경", "문의하기", "로그아웃"]
    
    var regions : [MyPageRegions] = [MyPageRegions]() {
        didSet {
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        getMyPage()
        setTableView()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        getMyPage()
    }

    //MARK: 테이블 뷰 요소 세팅
    func setTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    //MARK: rightBarButtonItem Setting
    func setRightBarButtonItem() {
        let rightButtonItem = UIBarButtonItem.init(
            image: UIImage(named: "icMessage"),
            style: .done,
            target: self,
            action: #selector(rightButtonAction(sender:))
        )
        self.navigationItem.rightBarButtonItem = rightButtonItem
        self.navigationItem.rightBarButtonItem?.tintColor =  #colorLiteral(red: 0.9108466506, green: 0.5437278748, blue: 0.5438123941, alpha: 1)
    }
    
    //MARK: rightBarButtonItem Action
    @objc func rightButtonAction(sender: UIBarButtonItem) {
        let postVC = UIStoryboard(name: "MyPage", bundle: nil).instantiateViewController(withIdentifier: PostBoxViewController.reuseIdentifier)
        
        self.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(postVC, animated: true)
        self.hidesBottomBarWhenPushed = false
    }
    
    //MARK: 케어테이커 || 회원가입 액션
    @IBAction func buttonAction(_ sender: UIButton) {
        
        guard let role = UserDefaults.standard.string(forKey: "role") else {return}
        let finished = UserDefaults.standard.bool(forKey: "isFinished") 
        
        if role == careMapping.member.rawValue { //케어테이커 인증하기로 이동 - 멤버
            
            if finished == true {
                let careVC = UIStoryboard(name: "Care", bundle: nil).instantiateViewController(withIdentifier: MainCareViewController.reuseIdentifier)
                
                self.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(careVC, animated: true)
                self.hidesBottomBarWhenPushed = false
            } else {
                self.simpleAlert(title: "", message: "케어테이커 신청 대기 상태입니다")
            }

        } else { //회원가입로 이동 - 게스트
            let joinVC = UIStoryboard(name: "Sign", bundle: nil).instantiateViewController(withIdentifier: JoinViewController.reuseIdentifier)
           
            self.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(joinVC, animated: true)
            self.hidesBottomBarWhenPushed = false
        }
    }
    
    //MARK: 활동 지역 설정 액션
    @IBAction func areaAction(_ sender: UIButton) {
        let areaVC = UIStoryboard(name: "MyPage", bundle: nil).instantiateViewController(withIdentifier: AreaSettingViewController.reuseIdentifier)
        
        self.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(areaVC, animated: true)
        self.hidesBottomBarWhenPushed = false
    }
    
    //MARK: UnwindSegue (지역수정VC -> 마이페이지)
    @IBAction func unwindToMyPage(sender: UIStoryboardSegue) {
        if let updateVC = sender.source as? AreaSettingViewController {

            tableView.reloadData()
        }
    }
    

}

//MARK: TableView Extension
extension MyPageViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerCell = tableView.dequeueReusableCell(withIdentifier: MyPageHeaderTableViewCell.reuseIdentifier) as! MyPageHeaderTableViewCell
        
        if section == 1 {
            headerCell.titleLabel.text = "내 활동"
        } else if section == 2 {
            headerCell.titleLabel.text = "계정 정보"
        }
        
        return headerCell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 47
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1 {
            return 2
        } else {
            return 4
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: MyAreaTableViewCell.reuseIdentifier) as! MyAreaTableViewCell
            
            cell.regions = regions
            cell.collectionView.reloadData()
            
            return cell
            
        }
        else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: MyPageListTableViewCell.reuseIdentifier) as! MyPageListTableViewCell
            
            cell.titleLabel.text = secondArr[indexPath.row]
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: MyPageListTableViewCell.reuseIdentifier) as! MyPageListTableViewCell
            
            cell.titleLabel.text = thirdArr[indexPath.row]
            
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        let role = gsno(UserDefaults.standard.string(forKey: "role"))
        
        if section == 0 {
            return 0
        } else if role == careMapping.care.rawValue || role == careMapping.member.rawValue {
            return 47
        } else {
            return 0
        }
        

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let role = gsno(UserDefaults.standard.string(forKey: "role"))

        if indexPath.section == 0 { //지역 설정 - 케어테이커만
            if role == careMapping.care.rawValue {
                return 115
            } else {
                return 0
            }
        } else if indexPath.section == 1 {
            if role == careMapping.care.rawValue || role == careMapping.member.rawValue {

                return 44
            } else {
                return 0
            }
        } else {
            if role == careMapping.care.rawValue || role == careMapping.member.rawValue {
                
                return 44
            } else {
                return 0
            }
        }

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            
            if indexPath.row == 0 { //내가 참여한 후원글
                let applyFundVC = UIStoryboard(name: "MyPage", bundle: nil).instantiateViewController(withIdentifier: SupportingViewController.reuseIdentifier)
                self.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(applyFundVC, animated: true)
                self.hidesBottomBarWhenPushed = false
            } else { //내가 작성한 글
                let myWriteVC = UIStoryboard(name: "MyPage", bundle: nil).instantiateViewController(withIdentifier: MyWriteViewController.reuseIdentifier)
                self.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(myWriteVC, animated: true)
                self.hidesBottomBarWhenPushed = false
            }
        } else if indexPath.section == 2 {
            
            if indexPath.row == 0 { //정보수정
                let modDataVC = UIStoryboard(name: "MyPage", bundle: nil).instantiateViewController(withIdentifier: ModMyDataViewController.reuseIdentifier)
                self.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(modDataVC, animated: true)
                self.hidesBottomBarWhenPushed = false
            } else if indexPath.row == 1 { //비밀번호 변경
                let pwdVC = UIStoryboard(name: "MyPage", bundle: nil).instantiateViewController(withIdentifier: PasswordModViewController.reuseIdentifier)
                self.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(pwdVC, animated: true)
                self.hidesBottomBarWhenPushed = false
            } else if indexPath.row == 2 { //문의하기
                let qesVC = UIStoryboard(name: "MyPage", bundle: nil).instantiateViewController(withIdentifier: QuestionViewController.reuseIdentifier)
                self.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(qesVC, animated: true)
                self.hidesBottomBarWhenPushed = false
            } else {
                self.simpleAlertwithHandler(title: "로그아웃", message: "로그아웃을 하시겠습니까?", okHandler: { (action) in
                    UserDefaults.standard.removeObject(forKey: "token")
                    UserDefaults.standard.set("-1", forKey: "token")
                    self.performSegue(withIdentifier: "unwindToHome", sender: nil)
                    })
            }
        }
    }
    
}

//MARK: Networking Extension
extension MyPageViewController {
    
    //마이페이지 조회
    func getMyPage() {
        MyPageService.shareInstance.getMypageInit(completion: {
            (result) in
            
            switch result {
            case .networkSuccess(let data) :
                let myPageData = data as? MyPageData
                
                
                if let resResult = myPageData {
                    
                    let regionData = resResult.regions as? [MyPageRegions]
                    if let areaResult = regionData {
                        self.regions = areaResult
                    }
                    
                    UserDefaults.standard.set(resResult.role, forKey: "role")
                    print("나의 역할은 \(self.gsno(UserDefaults.standard.string(forKey: "role")))")
                    UserDefaults.standard.set(resResult.isFinished, forKey: "isFinished")
                    
                    if resResult.role == careMapping.care.rawValue {
                        self.viewBottomC.constant = 0
                        self.joinButton.isHidden = true
                        self.careImageView.isHidden = false
                        self.backImageView.image = UIImage(named: "mypageCaretaker")
                    } else {
                        self.viewBottomC.constant = 79
                        self.joinButton.isHidden = false
                        self.careImageView.isHidden = true
                        self.backImageView.image = UIImage(named: "mypageNormal")
                    }
                    
                    if resResult.role == careMapping.care.rawValue || resResult.role == careMapping.member.rawValue {
                        self.setRightBarButtonItem()
                    } 
                    
                    self.nickNameLabel.text = resResult.nickname
                    self.idLabel.isHidden = false
                    self.idLabel.text = resResult.id
                    
                }
                self.joinButton.setImage(UIImage(named: "buttonMypageCaretaker"), for: .normal)
                self.tableView.reloadData()
                break
                
            case .accessDenied :
                self.nickNameLabel.text = "회원가입이 필요해요!"
                self.idLabel.isHidden = true
                self.joinButton.setImage(UIImage(named: "buttonMypageJoin"), for: .normal) 
                
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
