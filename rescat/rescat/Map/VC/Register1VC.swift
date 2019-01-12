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
    @IBOutlet var nextStepButton2 : UIButton!
    
    @IBOutlet weak var imageDeleteButton: UIButton!
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

    @IBOutlet var hiddenView : UIView!
    var keyboardDismissGesture: UITapGestureRecognizer?
    var check = false
    var curCategory = 0
    var isPhoto = false
    var imageUrl : [String] = []
    var image : UIImage = UIImage() {
        didSet{
            self.representImageView.image = image
        }
    }

    
    let imagePicker : UIImagePickerController = UIImagePickerController()

    override func viewDidLoad() {
        super.viewDidLoad()
        setKeyboardSetting()
        

        setBackBtn()

        let brown = UIColor(red: 190/255, green: 153/255, blue: 129/255, alpha: 1.0)
        
        type2Button.setTitleColor(brown, for: .normal) ; type1Button.setTitleColor(UIColor.white, for: .normal)
        type2Button.backgroundColor = UIColor.white; type1Button.backgroundColor = brown

        type1Button.tag = 0 ; type1Button.addTarget(self, action: #selector(changeTypeButtonAction(_:)), for: .touchUpInside)
        type1Button.tag = 0 ; type2Button.addTarget(self, action: #selector(changeTypeButtonAction(_:)), for: .touchUpInside)
        type1Button.layer.borderColor = brown.cgColor ; type2Button.layer.borderColor = brown.cgColor
        type1Button.roundCorner(10.0) ; type2Button.roundCorner(10.0)
        type2Button.layer.borderWidth = 1.0 ; type1Button.layer.borderWidth = 1.0
        
        
        nameTextField.delegate = self ; ageTextField.delegate = self ; propertyTextField.delegate = self

        type1Button.tag = 0 ; type2Button.tag = 1
        
        ageTextField.layer.borderWidth = 1.0; ageTextField.roundCorner(10.0)
        ageTextField.layer.borderColor = UIColor.rescatPink().cgColor

        nameTextField.layer.borderWidth = 1.0; nameTextField.roundCorner(10.0)
        nameTextField.layer.borderColor = UIColor.rescatPink().cgColor

        propertyTextField.layer.borderWidth = 1.0; propertyTextField.roundCorner(10.0)
        propertyTextField.layer.borderColor = UIColor.rescatPink().cgColor

        imageDeleteButton.addTarget(self, action: #selector(deleteImageAction(_:)), for: .touchUpInside)
//        imagePicker.delegate = self
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tappedView(_:)))
        representImageView.isUserInteractionEnabled = true
        representImageView.addGestureRecognizer(gestureRecognizer)
        
        sexButton1.tag = 0 ; sexButton2.tag = 1
        sexButton1.addTarget(self, action: #selector(choiceGender(_:)), for: .touchUpInside)
        sexButton2.addTarget(self, action: #selector(choiceGender(_:)), for: .touchUpInside)


        tnrButton1.tag = 0 ; tnrButton2.tag = 1; tnrButton3.tag = 2
        tnrButton1.addTarget(self, action: #selector(choiceTnr(_:)), for: .touchUpInside)
        tnrButton2.addTarget(self, action: #selector(choiceTnr(_:)), for: .touchUpInside)
        tnrButton3.addTarget(self, action: #selector(choiceTnr(_:)), for: .touchUpInside)
        
        nextStepButton.addTarget(self, action: #selector(gotoNextStep(_:)), for: .touchUpInside)
        nextStepButton2.addTarget(self, action: #selector(gotoNextStep(_:)), for: .touchUpInside)

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        self.tabBarController?.tabBar.isHidden = true
    }
    @objc func choiceGender ( _ sender : UIButton! ){
        sex = sender.tag
        if sender.tag == 0 {
            sexImageView1.image = UIImage(named: "buttonRadioOn")
            sexImageView2.image = UIImage(named: "buttonRadioOff")
        } else if sender.tag == 1 {
            sexImageView2.image = UIImage(named: "buttonRadioOn")
            sexImageView1.image = UIImage(named: "buttonRadioOff")

        }
    }
    @objc func choiceTnr ( _ sender : UIButton!) {
        tnr = sender.tag

        if sender.tag == 0 {
            tnrImageView1.image = UIImage(named: "buttonRadioOn")
            tnrImageView2.image = UIImage(named: "buttonRadioOff")
            tnrImageView3.image = UIImage(named: "buttonRadioOff")

        } else if sender.tag == 1 {
            tnrImageView2.image = UIImage(named: "buttonRadioOn")
            tnrImageView1.image = UIImage(named: "buttonRadioOff")
            tnrImageView3.image = UIImage(named: "buttonRadioOff")

        } else {
            tnrImageView3.image = UIImage(named: "buttonRadioOn")
            tnrImageView1.image = UIImage(named: "buttonRadioOff")
            tnrImageView2.image = UIImage(named: "buttonRadioOff")

        }
    }
    @objc func tappedView( _ recognizer:UIPanGestureRecognizer){
        openGallery()
    }
    @objc func changeTypeButtonAction( _ sender : UIButton!){
        let brown = UIColor(red: 190/255, green: 153/255, blue: 129/255, alpha: 1.0)
        if sender.tag == 1 && curCategory == 0 {
            typeLabel.text = "배식소 이름" ; curCategory = 1
            
            type1Button.setTitleColor(brown, for: .normal) ; type2Button.setTitleColor(UIColor.white, for: .normal)
            type1Button.backgroundColor = UIColor.white; type2Button.backgroundColor = brown
            hiddenView.isHidden = true ;
//            scrollView.isScrollEnabled = false
            propertyTextField.text = ""; nameTextField.text = "" ; nameTextField.placeholder = "배식소 이름을 14자 이내로 적어주세요."
            
            scrollView.contentSize = CGSize(width: self.view.frame.width, height: 607)

            self.view.layoutIfNeeded()
//            self.scrollView.contentSize = CGSize(width: self.scrollView.frame.width, height: self.scrollView.frame.height)
//
//            scrollView.
            
        } else if sender.tag == 0 && curCategory == 1{
            
            type2Button.setTitleColor(brown, for: .normal) ; type1Button.setTitleColor(UIColor.white, for: .normal)
            type2Button.backgroundColor = UIColor.white; type1Button.backgroundColor = brown
            typeLabel.text = "고양이 이름" ; curCategory = 0
            hiddenView.isHidden = false ; scrollView.isScrollEnabled = true
        
            //            representImageView.image = UIImage(named: String)
            propertyTextField.text = ""; nameTextField.text = "" ; nameTextField.placeholder = "고양이 이름을 14자 이내로 적어주세요."
            scrollView.contentSize = CGSize(width: self.view.frame.width, height: 847)

//            self.scrollView.contentSize = CGSize(width: self.scrollView.frame.width, height: self.scrollView.frame.height - 250)

        }
        //
        
        
    }
    @objc func deleteImageAction ( _ sedner : UIButton! ) {
        if isPhoto {
            PhotoRequest.deletePhoto(imageUrl[0]) ; imageUrl.removeAll()
            isPhoto = false
            imageDeleteButton.isHidden = false
            image = UIImage(named:"buttonAddPhotoDash")!
            imageDeleteButton.isHidden = true
        }
    }
    @objc func gotoNextStep ( _ sender : UIButton! ) {
        print("사진\(imageUrl)")
        if ( curCategory == 0 ) {
            // 고양이
            if ( gsno(nameTextField.text) == "" || gsno(propertyTextField.text) == "" || gsno(ageTextField.text) == "" ) {
                self.simpleAlert(title: "", message: "모든 정보를 다 입력해주세요")
            } else if ( !isPhoto ) {
                self.simpleAlert(title: "", message: "한장이상의 사진을 등록해주세요.")
            } else {
                
                let vc = storyboard?.instantiateViewController(withIdentifier: "RegisterVC3") as! RegisterVC3
                vc.registerMap.requestType = 0
                vc.registerMap.registerType = 1
                vc.registerMap.name = gsno(nameTextField.text)
                vc.registerMap.sex = sex
                vc.registerMap.tnr = tnr
                vc.registerMap.etc = gsno(propertyTextField.text)
                vc.registerMap.photoUrl = imageUrl[0]
                self.navigationController?.pushViewController(vc, animated: true)

            }
        } else {
            // 배식소
            if gsno(nameTextField.text) == "" || gsno(propertyTextField.text) == "" {
                self.simpleAlert(title: "", message: "모든 정보를 다 입력해주세요")
            } else if ( !isPhoto ) {
                self.simpleAlert(title: "", message: "한장이상의 사진을 등록해주세요.")
            }
            else {
                let vc = storyboard?.instantiateViewController(withIdentifier: "RegisterVC3") as! RegisterVC3
                vc.registerMap.requestType = 0
                vc.registerMap.registerType = 0
                vc.registerMap.name = gsno(nameTextField.text)
                vc.registerMap.photoUrl = imageUrl[0]
                vc.registerMap.etc = gsno(propertyTextField.text)

                self.navigationController?.pushViewController(vc, animated: true)
            }

        }
    }
    @objc func handleTap(sender: UITapGestureRecognizer) {
       
        self.view.endEditing(true)
    }
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        textView.resignFirstResponder()
        return true
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            propertyTextField.resignFirstResponder()
            return false
        }
        return true
    }
    
    
}
extension Register1VC {
    
    func setKeyboardSetting() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        adjustKeyboardDismissGesture(isKeyboardVisible: true)
        
        if let keyboardHeight = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height {
            
            UIView.animate(withDuration: 0.1) {
                self.view.frame = CGRect(x: 0, y: -keyboardHeight, width: self.view.frame.width, height: self.view.frame.height+49)
                
            }
            self.view.layoutIfNeeded()
        }

    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        adjustKeyboardDismissGesture(isKeyboardVisible: false)
        
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            
            UIView.animate(withDuration: 0.1) {
                self.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)

            }
            self.view.layoutIfNeeded()
            check = false
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

extension Register1VC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // Method
    @objc func openGallery() {
        // 0 위에, 1 아래
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            self.imagePicker.sourceType = .photoLibrary
            self.imagePicker.delegate = self
            self.imagePicker.allowsEditing = true
            self.present(self.imagePicker, animated: true, completion: { print("이미지 피커 나옴") })
        }
        
    }
    
    func openCamera() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            self.imagePicker.sourceType = .camera
            self.imagePicker.delegate = self
            self.present(self.imagePicker, animated: true, completion: { print("이미지 피커 나옴") })
        }
    }
    
    // imagePickerDelegate
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("사용자가 취소함")
        self.dismiss(animated: true) {
            print("이미지 피커 사라짐")
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
       
        if let editedImage: UIImage = info[.editedImage] as? UIImage {
            image = editedImage
        } else if let originalImage: UIImage = info[.originalImage]  as? UIImage{
            image = originalImage
        }
        
        guard let  data = image.jpegData(compressionQuality: 1.0) else { return }
        addImage(image: data)
        imageDeleteButton.isHidden = false
    
        
        self.dismiss(animated: true)
    }
    func addImage(image : Data?) {
        let params : [String : Any] = [:]
        var images : [String : Data]?
        
        if let image_ = image {
            images = [
                "data" : image_
            ]
        }
        
        PostImageService.shareInstance.addPhoto(params: params, image: images, completion: { [weak self] (result) in
            
            guard let `self` = self else { return }
            switch result {
                
            case .networkSuccess(let data):
                let data = data as? PhotoData
                if let img = data?.photoUrl {
                    self.imageUrl.append(img)
                    
                    self.isPhoto = true
                }
                break
                
            case .large :
                self.simpleAlert(title: "업로드 실패", message: "업로드 가능한 이미지 최대 크기는 10MB입니다.")
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
