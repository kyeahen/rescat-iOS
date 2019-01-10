//
//  Register1VC.swift
//  rescat
//
//  Created by jigeonho on 11/01/2019.
//  Copyright © 2019 kyeahen. All rights reserved.
//

import Foundation
import UIKit
class Register1VC : UIViewController, UITextFieldDelegate, UITextViewDelegate{
    @IBOutlet var type1Button : UIButton!
    @IBOutlet var type2Button : UIButton!
    @IBOutlet var typeLabel : UILabel!
    @IBOutlet var representImageView : UIImageView!
    @IBOutlet var nameTextField : UITextField!
    @IBOutlet var propertyTextField : UITextView!
    @IBOutlet weak var nextStepButton: UIButton!
    
    @IBOutlet var scrollView : UIScrollView!
    @IBOutlet var ageTextField : UITextField!
    
    // 라디오버튼을 이따구로 짤줄이야
    var sex = 0 // 0-남, 1-여
    @IBOutlet var sexButton1 : UIButton!
    @IBOutlet var sexButton2 : UIButton!
    @IBOutlet var sexImageView1 : UIImageView!
    @IBOutlet var sexImageView2 : UIImageView!

    var tnr = 0 // 0-해당없음, 1-완료, 2-모름
    @IBOutlet var tnrButton1 : UIButton!
    @IBOutlet var tnrButton2 : UIButton!
    @IBOutlet var tnrButton3 : UIButton!
    @IBOutlet var tnrImageView1 : UIImageView!
    @IBOutlet var tnrImageView2 : UIImageView!
    @IBOutlet var tnrImageView3 : UIImageView!

    var keyboardDismissGesture: UITapGestureRecognizer?
    var check = false
    var curCategory = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        setKeyboardSetting()
        type1Button.tag = 0 ; type1Button.addTarget(self, action: #selector(changeTypeButtonAction(_:)), for: .touchUpInside)
        type1Button.tag = 0 ; type2Button.addTarget(self, action: #selector(changeTypeButtonAction(_:)), for: .touchUpInside)

    }
    @objc func changeTypeButtonAction( _ sender : UIButton!){
        if sender.tag == 0 {
            typeLabel.text = "배식소 이름"
            propertyTextField.text = ""; nameTextField.text = "" ; nameTextField.placeholder = "배식소 이름을 14자 이내로 적어주세요."
            self.scrollView.contentSize = CGSize(width: self.scrollView.frame.width, height: 600)

//            scrollView.
            
        } else {
            typeLabel.text = "고양이 이름"
            //            representImageView.image = UIImage(named: String)
            propertyTextField.text = ""; nameTextField.text = "" ; nameTextField.placeholder = "고양이 이름을 14자 이내로 적어주세요."
            self.scrollView.contentSize = CGSize(width: self.scrollView.frame.width, height: 600)

        }
    }
    @objc func gotoNextStep ( _ sender : UIButton! ) {
        if gsno(nameTextField.text) == "" || gsno(propertyTextField.text) == "" {
            self.simpleAlert(title: "error", message: "정보를 다 입력하세요")
        } else {
            let vc = storyboard?.instantiateViewController(withIdentifier: "RegisterVC3") as! RegisterVC3
            vc.registerMap.name = ""
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    @objc func handleTap(sender: UITapGestureRecognizer) {
       
        self.view.endEditing(true)
    }
    
    
}
extension Register1VC {
    
    func setKeyboardSetting() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        adjustKeyboardDismissGesture(isKeyboardVisible: true)
        
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if check {
//                constraintInitVal = commentBottomC.constant
//                commentBottomC.constant += keyboardSize.height
//                self.view.layoutIfNeeded()
                check = false
            }
            
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        adjustKeyboardDismissGesture(isKeyboardVisible: false)
        
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            
//            commentBottomC.constant = constraintInitVal
//            self.view.layoutIfNeeded()
            check = true
        }
    }
    
    func adjustKeyboardDismissGesture(isKeyboardVisible: Bool) {
        if isKeyboardVisible {
            if keyboardDismissGesture == nil {
                keyboardDismissGesture = UITapGestureRecognizer(target: self, action: #selector(tapBackground))
                view.addGestureRecognizer(keyboardDismissGesture!)
            }
        } else {
            if keyboardDismissGesture != nil {
                view.removeGestureRecognizer(keyboardDismissGesture!)
                keyboardDismissGesture = nil
            }
        }
    }
    
    @objc func tapBackground() {
        self.view.endEditing(true)
    }
}

