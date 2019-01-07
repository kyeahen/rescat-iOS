//
//  FinishCareViewController.swift
//  rescat
//
//  Created by 김예은 on 30/12/2018.
//  Copyright © 2018 kyeahen. All rights reserved.
//

import UIKit

class FinishCareViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var finishButton: UIButton!
    
//    var parentVC : MainCareViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setCustomView()
        
    }
    
    //MARK: 뷰 요소 커스텀 세팅
    func setCustomView() {
        imageView.circleImageView()
        finishButton.makeRounded(cornerRadius: 8)
    }

    //MARK: 완료 액션
    //TODO: 메인 페이지로 이동
    @IBAction func finishAction(_ sender: UIButton) {
        postCaretaker()
    }
    
}

//MARK: Networking Extension
extension FinishCareViewController {
    
    //MARK: 케어테이커 인증
    func postCaretaker() {
        
        let name = gsno(UserDefaults.standard.string(forKey: "caretakerName"))
        let phone = gsno(UserDefaults.standard.string(forKey: "caretakerPhone"))
        let area = gsno(UserDefaults.standard.string(forKey: "caretakerArea"))
        let photo = gsno(UserDefaults.standard.string(forKey: "caretakerPhoto"))
        
        let params : [String : Any] = ["authenticationPhotoUrl": photo,
                                       "phone": phone,
                                       "regionFullName": area,
                                       "type": 0,
                                       "name": name]
        
        CaretaketService.shareInstance.postCaretaker(params: params) {(result) in
            
            switch result {
            case .networkSuccess( _): //201
                
                let tabVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: TabBarController.reuseIdentifier) as! TabBarController
                
                self.present(tabVC, animated: true, completion: nil)
                UserDefaults.standard.removeObject(forKey: "caretakerName")
                UserDefaults.standard.removeObject(forKey: "caretakerPhone")
                UserDefaults.standard.removeObject(forKey: "caretakerArea")
                UserDefaults.standard.removeObject(forKey: "caretakerPhoto")
                break
                
            case .badRequest: //400
                print("4000")
                break
                
            case .duplicated: //401
                
                self.simpleAlert(title: "", message: "권한 없음")
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
    
}
