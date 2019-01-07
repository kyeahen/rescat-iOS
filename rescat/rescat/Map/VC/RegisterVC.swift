//
//  RegisterVC.swift
//  rescat
//
//  Created by jigeonho on 26/12/2018.
//  Copyright © 2018 kyeahen. All rights reserved.
//

import Foundation
import UIKit
class RegisterVC : UIViewController, UITextFieldDelegate, UITextViewDelegate{
    @IBOutlet var type1Button : UIButton!
    @IBOutlet var type2Button : UIButton!
    @IBOutlet var typeLabel : UILabel!
    @IBOutlet var representImageView : UIImageView!
    @IBOutlet var nameTextField : UITextField!
    @IBOutlet var propertyTextField : UITextView!

    @IBOutlet weak var nextStepButton: UIButton!
    var keyboardStatus = 0
    var registerMap : MapRequestModel!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.delegate = self
        propertyTextField.delegate = self
        propertyTextField.textContainer.maximumNumberOfLines = 4
        type1Button.tag = 0; type1Button.addTarget(self, action: #selector(changeTypeButtonAction(_:)), for: .touchUpInside)
        type2Button.tag = 1; type2Button.addTarget(self, action: #selector(changeTypeButtonAction(_:)), for: .touchUpInside)
//        print(Bundle.main.pa)
        nextStepButton.addTarget(self, action: #selector(gotoNextStep(_:)), for: .touchUpInside)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.handleTap))
        self.view.isUserInteractionEnabled = true
        self.view.addGestureRecognizer(tapGesture)

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
   
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if ( keyboardStatus == 0 ) {
            keyboardStatus = 1
            UIView.animate(withDuration: 0.1) {
                self.view.frame.origin.y -= 150
            }
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("return")
//        UIView.animate(withDuration: 0.5) {
//            self.view.frame.origin.y += +150
//        }
        if ( keyboardStatus == 1 ) {
            keyboardStatus = 0
            UIView.animate(withDuration: 0.1) {
                self.view.frame.origin.y += 150
            }
        }

        textField.resignFirstResponder()
        return true
    }
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
    
        if ( keyboardStatus == 1 ) {
            keyboardStatus = 0
            UIView.animate(withDuration: 0.1) {
                self.view.frame.origin.y += 150
            }
        }
        textView.resignFirstResponder()
        return true
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        if ( keyboardStatus == 0 ) {
            keyboardStatus = 1
            UIView.animate(withDuration: 0.1) {
                self.view.frame.origin.y -= 150
            }
        }
    }
    @objc func handleTap(sender: UITapGestureRecognizer) {
        
        if ( keyboardStatus == 1) {
            UIView.animate(withDuration: 0.1) {
                self.view.frame.origin.y += 150
            }
            keyboardStatus = 0
            
        }
        self.view.endEditing(true)
    }
    
    @objc func changeTypeButtonAction( _ sender : UIButton!){
        if sender.tag == 0 {
            typeLabel.text = "배식소 이름"
            propertyTextField.text = ""; nameTextField.text = "" ; nameTextField.placeholder = "배식소 이름을 14자 이내로 적어주세요."

        } else {
            typeLabel.text = "고양이 이름"
//            representImageView.image = UIImage(named: String)
            propertyTextField.text = ""; nameTextField.text = "" ; nameTextField.placeholder = "고양이 이름을 14자 이내로 적어주세요."

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
    

}
