//
//  FundingRegisterVC.swift
//  rescat
//
//  Created by jigeonho on 04/01/2019.
//  Copyright © 2019 kyeahen. All rights reserved.
//

import Foundation
import UIKit
class FundingRegisterVC : UIViewController , UITextFieldDelegate , UITextViewDelegate{
//    override func
    
    @IBOutlet var type1Button : UIButton!
    @IBOutlet var type2Button : UIButton!
    @IBOutlet var type1ImageView : UIImageView!
    @IBOutlet var type2ImageView : UIImageView!
    @IBOutlet var typeLabel : UILabel!
    @IBOutlet var representImageView1 : UIImageView!
    @IBOutlet var representImageView2 : UIImageView!
    @IBOutlet var representImageView3 : UIImageView!
    @IBOutlet var representImageView4 : UIImageView!
    var representImageArray = [UIImageView]()
    var keyboardStatus = 0

    @IBOutlet var titleTextField : UITextField!
    @IBOutlet var descriptionTextView : UITextView!

    @IBOutlet var detailDescriptionTextView : UITextView!
    
    @IBOutlet var goalAmountTextField : UITextField!
    @IBOutlet var dueDateTextField : UITextField!
    @IBOutlet var locationTextField : UITextField!
    
    @IBOutlet var provementImageView1 : UIImageView!
    @IBOutlet var provementImageView2 : UIImageView!
    @IBOutlet var provementImageView3 : UIImageView!
    @IBOutlet var provementImageView4 : UIImageView!
    
    var provementImageArray = [UIImageView]()
    var datePicker = UIDatePicker()

    override func viewDidLoad() {
        super.viewDidLoad()
        // 0 - title, 1 - due date, 2 - goal, 3 - location
        titleTextField.delegate = self ; titleTextField.tag = 0
        dueDateTextField.delegate = self ; dueDateTextField.tag = 1
        goalAmountTextField.delegate = self ; goalAmountTextField.tag = 2
        locationTextField.delegate = self ; locationTextField.tag = 3
        
        goalAmountTextField.keyboardType = .decimalPad
        showDatePicker()

        descriptionTextView.delegate = self ; descriptionTextView.tag = 0
        detailDescriptionTextView.delegate = self ; descriptionTextView.tag = 1
        
        type1Button.tag = 0; type1Button.addTarget(self, action: #selector(changeType(_:)), for: .touchUpInside)
        type2Button.tag = 1; type2Button.addTarget(self, action: #selector(changeType(_:)), for: .touchUpInside)

        representImageArray.append(representImageView1)
        representImageArray.append(representImageView2)
        representImageArray.append(representImageView3)
        representImageArray.append(representImageView4)

        for (index, element) in representImageArray.enumerated() {
            element.tag = index
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(representImageSelect(sender:)))
            element.addGestureRecognizer(tapGesture)
            element.isUserInteractionEnabled = true

        }
        
        provementImageArray.append(provementImageView1)
        provementImageArray.append(provementImageView2)
        provementImageArray.append(provementImageView3)
        provementImageArray.append(provementImageView4)
        
        descriptionTextView.textContainer.maximumNumberOfLines = 3
        detailDescriptionTextView.textContainer.maximumNumberOfLines = 10
        for (index, element) in provementImageArray.enumerated() {
            element.tag = index
            
        }
        var tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.handleTap))
        self.view.isUserInteractionEnabled = true
        self.view.addGestureRecognizer(tapGesture)


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
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.becomeFirstResponder()
//        if ( keyboardStatus == 0 ){
//            UIView.animate(withDuration: 0.1) {
//                self.view.frame.origin.y -= 150
//            }
//            keyboardStatus = 1
//        }

    }
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        textView.resignFirstResponder()
//        if ( keyboardStatus == 1 ){
//            UIView.animate(withDuration: 0.1) {
//                self.view.frame.origin.y += 150
//            }
//            keyboardStatus = 0
//        }
        return true
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("begin")
        
        if ( keyboardStatus == 0 ){
            UIView.animate(withDuration: 0.1) {
                self.view.frame.origin.y -= 150
            }
            keyboardStatus = 1
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // 0 - title, 1 - due date, 2 - goal, 3 - location

        print("return")
        if ( keyboardStatus == 1 ){
            UIView.animate(withDuration: 0.1) {
                self.view.frame.origin.y += 150
            }
            keyboardStatus = 0
        }
        textField.resignFirstResponder()

        if ( textField.tag == 0 ) {
            FundingRegisterVC2.fundingRequest.title = gsno(textField.text)
        } else if ( textField.tag == 1 ) {
            FundingRegisterVC2.fundingRequest.limitAt = gsno(textField.text)
        } else if ( textField.tag == 2 ) {
            FundingRegisterVC2.fundingRequest.goalAmount = Int(gsno(textField.text))
        } else {
            FundingRegisterVC2.fundingRequest.mainRegion = gsno(textField.text)
        }

        return true
    }

    @IBAction func nextAction( _ sender : UIButton!){
        if ( gsno(titleTextField.text) == "" || gsno(dueDateTextField.text) == "" || gsno(goalAmountTextField.text) == "" || gsno(locationTextField.text) == "" ) {
            self.simpleAlert(title: "error", message: "정보를 입력하세요")
            return
        }
        let vc = storyboard?.instantiateViewController(withIdentifier: "FundingRegisterVC2") as! FundingRegisterVC2
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @objc func changeType ( _ sender : UIButton!) {
        if ( sender.tag == 0 ) {
            type1ImageView.image = UIImage(named: "buttonRadioOn")
            type2ImageView.image = UIImage(named: "buttonRadioOff")
            typeLabel.text = "후원정보"
        } else {
            type1ImageView.image = UIImage(named: "buttonRadioOff")
            type2ImageView.image = UIImage(named: "buttonRadioOn")
            typeLabel.text = "프로젝트 정보"
        }
    }
    @objc func representImageSelect(sender: UITapGestureRecognizer) {
        print("tap")
     
//        print(sender.)
    }
    func showDatePicker(){
        //Formate Date
        datePicker.datePickerMode = .date
        
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
        
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        
        dueDateTextField.inputAccessoryView = toolbar
        dueDateTextField.inputView = datePicker
        
    }
    
    @objc func donedatePicker(){
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        dueDateTextField.text = formatter.string(from: datePicker.date)
        if ( keyboardStatus == 1 ) {
            UIView.animate(withDuration: 0.1) {
                self.view.frame.origin.y += 150
            }
            keyboardStatus = 0
        }
        self.view.endEditing(true)
    }
    
    @objc func cancelDatePicker(){
        if ( keyboardStatus == 1 ) {
            UIView.animate(withDuration: 0.1) {
                self.view.frame.origin.y += 150
            }
            keyboardStatus = 0
        }
        self.view.endEditing(true)
    }
}
