//
//  FundingRegisterVC2_2.swift
//  rescat
//
//  Created by jigeonho on 05/01/2019.
//  Copyright © 2019 kyeahen. All rights reserved.
//

import Foundation
import UIKit
class FundingRegisterVC2 : UIViewController , UITextFieldDelegate , UITextViewDelegate{
    @IBOutlet var nameTextField : UITextField!
    @IBOutlet var numberTextField : UITextField!
    @IBOutlet var accountTextField : UITextField!
    @IBOutlet var introductionTextView : UITextView!
    
    var keyBoardStatus = 0
    
    static var fundingRequest = FundingRequestModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.delegate = self
        numberTextField.delegate = self
        accountTextField.delegate = self
        introductionTextView.delegate = self
        
        introductionTextView.textContainer.maximumNumberOfLines = 7
        numberTextField.keyboardType = .decimalPad
        accountTextField.keyboardType = .numberPad

        
        var tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.handleTap))
        self.view.isUserInteractionEnabled = true
        self.view.addGestureRecognizer(tapGesture)

        print("\(gsno(FundingRegisterVC2.fundingRequest.title))")
        
        
    }
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        textView.resignFirstResponder()
        if keyBoardStatus == 1 {
            keyBoardStatus = 0
            UIView.animate(withDuration: 0.1) {
                self.view.frame.origin.y += 150
            }
        }
        return true
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.becomeFirstResponder()
        if keyBoardStatus == 0 {
            keyBoardStatus = 1
            UIView.animate(withDuration: 0.1) {
                self.view.frame.origin.y -= 150
            }
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if keyBoardStatus == 1 {
            keyBoardStatus = 0
            UIView.animate(withDuration: 0.1) {
                self.view.frame.origin.y += 150
            }
        }
        return true
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.becomeFirstResponder()
        if keyBoardStatus == 0 {
            keyBoardStatus = 1
            UIView.animate(withDuration: 0.1) {
                self.view.frame.origin.y -= 150
            }
        }
        
    }
    @objc func handleTap(sender: UITapGestureRecognizer) {
        
        if ( keyBoardStatus == 1) {
            UIView.animate(withDuration: 0.1) {
                self.view.frame.origin.y += 150
            }
            keyBoardStatus = 0
            
        }
        self.view.endEditing(true)
    }
//    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
//        return true
//    }
}
