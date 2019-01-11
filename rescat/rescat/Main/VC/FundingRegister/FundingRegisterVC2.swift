//
//  FundingRegisterVC2_2.swift
//  rescat
//
//  Created by jigeonho on 05/01/2019.
//  Copyright © 2019 kyeahen. All rights reserved.
//

import Foundation
import UIKit
class FundingRegisterVC2 : UIViewController , UITextFieldDelegate , UITextViewDelegate , UIPickerViewDelegate, UIPickerViewDataSource,  APIServiceCallback{
   
    @IBOutlet var nameTextField : UITextField!
    @IBOutlet var numberTextField : UITextField!
    @IBOutlet var bankNameTextField : UITextField!
    @IBOutlet var accountTextField : UITextField!
    @IBOutlet var introductionTextView : UITextView!
    @IBOutlet var innerView : UIView!
    @IBOutlet var completeButton : UIButton!
    
    var fundingDetail = FundingRequestModel()
    var bankPickerView : UIPickerView!
    var keyBoardStatus = 0
    var bankNameList = [FundingBankModel]()
    
    var fundingRequest : FundingRequest!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setBackBtn()
        self.setNaviTitle(name: "후원 요청글 작성하기")
    
        print("funding detail model - \(gsno(fundingDetail.title))")
        nameTextField.delegate = self ; nameTextField.tag = 0
        nameTextField.layer.borderWidth = 1.0; nameTextField.roundCorner(10.0)
        nameTextField.layer.borderColor = UIColor.rescatPink().cgColor

        numberTextField.delegate = self ; numberTextField.tag = 1
        numberTextField.layer.borderWidth = 1.0; numberTextField.roundCorner(10.0)
        numberTextField.layer.borderColor = UIColor.rescatPink().cgColor
        numberTextField.keyboardType = .decimalPad
        numberTextField.inputAccessoryView = accessoryView(0)
        numberTextField.inputAccessoryView?.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 44)


        accountTextField.delegate = self ; accountTextField.tag = 2
        accountTextField.layer.borderWidth = 1.0; accountTextField.roundCorner(10.0)
        accountTextField.layer.borderColor = UIColor.rescatPink().cgColor
        accountTextField.keyboardType = .numberPad
        accountTextField.keyboardType = .decimalPad
        accountTextField.inputAccessoryView = accessoryView(1)
        accountTextField.inputAccessoryView?.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 44)

        
        bankNameTextField.delegate = self ; bankNameTextField.tag = 2
        bankNameTextField.layer.borderWidth = 1.0; bankNameTextField.roundCorner(10.0)
        bankNameTextField.layer.borderColor = UIColor.rescatPink().cgColor
        

        introductionTextView.delegate = self ; introductionTextView.tag = 0
        introductionTextView.layer.borderWidth = 1.0; introductionTextView.roundCorner(10.0)
        introductionTextView.layer.borderColor = UIColor.rescatPink().cgColor

        
        introductionTextView.textContainer.maximumNumberOfLines = 1
        introductionTextView.layer.borderWidth = 1.0 ; introductionTextView.roundCorner(10.0)
        introductionTextView.layer.borderColor = UIColor.rescatPink().cgColor


        

        bankPickerView = UIPickerView(frame:CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 162))
        bankPickerView.delegate = self ; bankPickerView.dataSource = self
        bankNameTextField.inputView = bankPickerView

        completeButton.addTarget(self, action: #selector(registerAction(_:)), for: .touchUpInside)
        
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor.rescatPink()
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(selectLocation))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolBar.setItems([spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        bankNameTextField.inputAccessoryView = toolBar

        
        var tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.handleTap))
        self.view.isUserInteractionEnabled = true ; self.innerView.isUserInteractionEnabled = true
        self.view.addGestureRecognizer(tapGesture) ; self.innerView.addGestureRecognizer(tapGesture)

        
        NotificationCenter.default.addObserver(self, selector: #selector(FundingRegisterVC2.keyboardWillShow(notification:)), name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(FundingRegisterVC2.keyboardWillHide(notification:)), name: UIResponder.keyboardDidHideNotification, object: nil)
      
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fundingRequest = FundingRequest(self)
        fundingRequest.getBankList()
//        self.tabBarController?.tabBar.isHidden = true
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return bankNameList.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        bankNameTextField.text = gsno(bankNameList[row].korean)
        completeButton.tag = row
        return gsno(bankNameList[row].korean)
        
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        bankNameTextField.text = gsno(bankNameList[row].korean)
    }
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
       
        textView.resignFirstResponder()
        return true
    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
  
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    
        textField.resignFirstResponder()
        return true
    }
  
    func accessoryView( _ tag : Int) -> UIView {
        
        
        let view = UIView()
        view.backgroundColor = UIColor.white
        let doneButton = UIButton()
        doneButton.frame = CGRect(x: self.view.frame.width - 80, y: 7, width: 60, height: 30)
        doneButton.setTitle("done", for: .normal)
        doneButton.setTitleColor(UIColor.rescatPink(), for: .normal)
        
        doneButton.addTarget(self, action: #selector(doneAction(_:)), for: .touchUpInside)
        view.addSubview(doneButton)
        
        return view
        
    }
    @objc func doneAction( _ sender: UIButton!) {
        self.view.endEditing(true)

        if sender.tag == 0 {
            numberTextField.resignFirstResponder()
        } else {
            accountTextField.resignFirstResponder()
        }
    }

    @objc func selectLocation( _ sender : UIButton!) {
//        bankNameTextField.text =
        bankNameTextField.resignFirstResponder()
        
    }
    @objc func registerAction ( _  sender : UIButton!) {
        
        if ( gsno(nameTextField.text) == "" || gsno(numberTextField.text) == "" || gsno(bankNameTextField.text) == "" || gsno(accountTextField.text) == "" ){
            self.simpleAlert(title: "", message: "모든 항목을 입력해주세요.")
        } else {

            fundingDetail.name = gsno(nameTextField.text)
            fundingDetail.phone = gsno(numberTextField.text)
            fundingDetail.bankName = gsno(bankNameList[sender.tag].english)
            fundingDetail.account = gsno(accountTextField.text)
            
            self.simpleAlertwithCustom(title: "", message: """
                글이 등록된 후에는 수정이 불가합니다.
                다시 한 번 확인해주세요 !
                """, ok: "작성 완료", cancel: "다시 확인") { (action) in
                    self.fundingRequest.postFundingDetail(self.fundingDetail)

            }
            
            
        }
    }
    @objc func handleTap(sender: UITapGestureRecognizer) {
        
        self.view.endEditing(true)
    }
 
    @objc func keyboardWillShow(notification: NSNotification) {
        print("keyboardWillShow")
        
        if let keyboardHeight = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height {
            self.view.frame = CGRect(x: 0, y: -keyboardHeight/4, width: self.view.frame.width, height: self.view.frame.height)
            
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        
        if let keyboardHeight = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height {
            self.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
            
        }
        
    }
    
    func requestCallback(_ datas: Any, _ code: Int) {
        if code == APIServiceCode.FUNDING_BANK_LIST {
//            datas
            bankNameList = datas as! [FundingBankModel]
            
        } else if code == APIServiceCode.FUNDING_DETAIL_POST {
            let vc = storyboard?.instantiateViewController(withIdentifier: "FundingRegisterCompleteVC") as! FundingRegisterCompleteVC
            self.navigationController?.pushViewController(vc, animated: true)

        } else if code == APIServiceCode.SERVER_ERROR {
            self.simpleAlert(title: "error", message: "server error")
        } else if code == APIServiceCode.EXCEPTION_ERROR1 {
            let errors = datas as! [FundingRequestExceptionModel]
            print("funding request error \(errors[0].field)")
            self.simpleAlert(title: "입력형식 오류", message: gsno(errors[0].message))
        }
    }
}
