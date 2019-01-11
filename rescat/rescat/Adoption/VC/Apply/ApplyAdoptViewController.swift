//
//  ApplyAdoptViewController.swift
//  rescat
//
//  Created by 김예은 on 04/01/2019.
//  Copyright © 2019 kyeahen. All rights reserved.
//

import UIKit

class ApplyAdoptViewController: UIViewController,UITextViewDelegate, UITextFieldDelegate {
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var roleTextField: UITextField!
    @IBOutlet weak var mainAddressTextField: UITextField!
    @IBOutlet weak var subAddressTextField: UITextField!
    @IBOutlet weak var contentTextView: UITextView!
    
    @IBOutlet var houseButtons: [UIButton]!
    @IBOutlet var statusButtons: [UIButton]!
    var houseCheck: Int = 1
    var statusCheck: Int = 1
    var houseTag: Int = 0
    var statusTag: Int = 0
    
    var idx: Int = 0
    var titleName: String = ""
    var tag: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setCustomView()
        setBackBtn()
        setTextView()
        setTextField()
        setFirstButton()
        
        hideKeyboardWhenTappedAround()
        
        //테이블 뷰 키보드 대응
        NotificationCenter.default.addObserver(self, selector: #selector(Care1ViewController.keyboardWillShow(notification:)), name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(Care1ViewController.keyboardWillHide(notification:)), name: UIResponder.keyboardDidHideNotification, object: nil)
        
    }
    
    func setFirstButton() {
        houseButtons[0].setImage(UIImage(named: "buttonRadioOn"), for: .normal)
        houseButtons[1].setImage(UIImage(named: "buttonRadioOff"), for: .normal)
        houseButtons[2].setImage(UIImage(named: "buttonRadioOff"), for: .normal)
        houseButtons[3].setImage(UIImage(named: "buttonRadioOff"), for: .normal)

        statusButtons[0].setImage(UIImage(named: "buttonRadioOn"), for: .normal)
        statusButtons[1].setImage(UIImage(named: "buttonRadioOff"), for: .normal)
    }


    
    func setTextField() {
        nameTextField.delegate = self
        phoneTextField.delegate = self
        roleTextField.delegate = self
        mainAddressTextField.delegate = self
        subAddressTextField.delegate = self
    }
    
    func setTextView() {
        contentTextView.delegate = self
    }
    
    //MARK: 키보드 대응 method
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
    //MARK: 뷰 요소 커스텀 세팅
    func setCustomView() {
        nameTextField.setTextField()
        phoneTextField.setTextField()
        roleTextField.setTextField()
        mainAddressTextField.setTextField()
        subAddressTextField.setTextField()
        contentTextView.setTextView()
        contentTextView.tintColor = #colorLiteral(red: 0.948010385, green: 0.566582799, blue: 0.5670218468, alpha: 1)
        
        self.navigationItem.title = titleName
    }
    
    @IBAction func unwindTOPost(_ sender: UIStoryboardSegue) {
        print(#function)
    }
    
    //MARK: 자택형태 액션
    @IBAction func houseAction(_ sender: UIButton) {
        
        houseCheck = 1
        for  aButton: UIButton in houseButtons! {
            
            houseTag = sender.tag
            if sender.tag == aButton.tag{
                aButton.isSelected = true;
                aButton.setImage(UIImage(named: "buttonRadioOn"), for: .normal)
            }else{
                aButton.isSelected = false;
                aButton.setImage(UIImage(named: "buttonRadioOff"), for: .normal)
            }
        }
    }
    
    //MARK: 반려경험 액션
    @IBAction func statusAction(_ sender: UIButton) {
        
        statusCheck = 1
        for  aButton: UIButton in statusButtons! {
            
            statusTag = sender.tag
            if sender.tag == aButton.tag{
                aButton.isSelected = true;
                aButton.setImage(UIImage(named: "buttonRadioOn"), for: .normal)
            }else{
                aButton.isSelected = false;
                aButton.setImage(UIImage(named: "buttonRadioOff"), for: .normal)
            }
        }
    }
    
    //MARK: 신청할래요 액션
    @IBAction func applyButton(_ sender: UIButton) {
        if nameTextField.text == "" || phoneTextField.text == "" || roleTextField.text == "" || mainAddressTextField.text == "" || subAddressTextField.text == "" || contentTextView.text == "" || houseCheck == 0 || statusCheck == 0 {

            self.simpleAlert(title: "", message: "모든 항목을 입력해주세요.")

        } else {

            self.simpleAlertwithCustom(title: "", message: """
                한 생명이 머물 수 있는
                공간을 제공해주셔서 감사합니다.

                신중하게 결정을 내려주세요.
                """, ok: "신청할래요", cancel: "취소") { (action) in
                    self.postApplyAdopt(idx: self.idx)
            }

        }
        
    }
    
    
    
}

//MARK: Networking Extension
extension ApplyAdoptViewController {
    
    //입양,임보 신청
    func postApplyAdopt(idx: Int) {
        
        let name = gsno(nameTextField.text)
        let phone = gsno(phoneTextField.text)
        let job = gsno(roleTextField.text)
        let address = "\(gsno(mainAddressTextField.text)) \(gsno(subAddressTextField.text))"
        let etc = gsno(contentTextView.text)
        
        var status: Bool = true
        if statusTag == 0 {
            status = true
        } else {
            status = false
        }
        
        var house: String = ""
        switch houseTag {
        case 0:
            house = houseMapping.apart.rawValue
            break
            
        case 1:
            house = houseMapping.house.rawValue
            break
        case 2:
            house = houseMapping.many.rawValue
            break
        case 3:
            house = houseMapping.one.rawValue
            break
        default:
            break
        }
        
        let params : [String : Any] = ["type": tag,
                                       "name": name,
                                       "phone": phone,
                                       "job": job,
                                       "address": address,
                                       "houseType": house,
                                       "companionExperience": status,
                                       "finalWord": etc,
                                       "birth": "2018-01-01"]
        
        ApplyAdoptService.shareInstance.postApplyAdopt(idx: self.idx, params: params) {(result) in
            
            switch result {
            case .networkSuccess( _): //200
                let comVC = UIStoryboard(name: "Adoption", bundle: nil).instantiateViewController(withIdentifier:
                    ApplySuccessViewController.reuseIdentifier) as! ApplySuccessViewController
                
                comVC.type = self.tag
                
                self.present(comVC, animated: true, completion: nil)
                break
                
            case .duplicated: //409
                self.simpleAlert(title: "", message: "이미 신청한 글입니다.")
                self.navigationController?.popViewController(animated: true)
                break
                
            case .badRequest: //400
                self.simpleAlert(title: "", message: "신청이 완료된 글입니다.")
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

//MARK: TableView Keyboard Setting Extension
extension ApplyAdoptViewController {
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardHeight = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height {
            tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardHeight - 49, right: 0)
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        UIView.animate(withDuration: 0.2, animations: {
            // For some reason adding inset in keyboardWillShow is animated by itself but removing is not, that's why we have to use animateWithDuration here
            self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        })
    }
}





