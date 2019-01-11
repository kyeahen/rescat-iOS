//
//  FundingRegisterVC.swift
//  rescat
//
//  Created by jigeonho on 04/01/2019.
//  Copyright © 2019 kyeahen. All rights reserved.
//

import Foundation
import UIKit
class FundingRegisterVC : UIViewController , UICollectionViewDelegate, UICollectionViewDataSource, UITextFieldDelegate, UITextViewDelegate{
//    override func
    @IBOutlet var overScrollView : UIScrollView!
    @IBOutlet var type1Button : UIButton!
    @IBOutlet var type2Button : UIButton!
    @IBOutlet var type1ImageView : UIImageView!
    @IBOutlet var type2ImageView : UIImageView!
    @IBOutlet var typeLabel : UILabel!
    @IBOutlet var representCollectionView : UICollectionView!
    @IBOutlet var mainCollectionView : UICollectionView!
    var representImageArray = [UIImageView]()
    var imageNum: Int = 0 ; var imageNum0 : Int = 0
    var curCategory = 0
//    var photoUrls = [String]() ; var certifications = [String]()
    let imagePicker : UIImagePickerController = UIImagePickerController()
    let imagePicker0 : UIImagePickerController = UIImagePickerController()
    var imageArr: [UIImage] = [UIImage(named:"icAddPhotoOn")!] ; var imageArrUrls: [String] = []
    var imageArr0: [UIImage] = [UIImage(named:"icAddPhotoOn")!] ; var imageArr0Urls: [String] = []

    var keyBoardStatus = 0

    @IBOutlet var titleTextField : UITextField!
    @IBOutlet var descriptionTextView : UITextView!

    @IBOutlet var detailDescriptionTextView : UITextView!
    
    @IBOutlet var goalAmountTextField : UITextField!
    
    @IBOutlet var dueDateTextField : UITextField!
    @IBOutlet var locationTextField : UITextField!
    
    @IBOutlet var additionalView : UIView!
    var provementImageArray = [UIImageView]()
    var datePicker = UIDatePicker()
    
    var request : FundingRequest!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        mySetBackBtn()
        self.setNaviTitle(name: "후원 요청글 작성하기")

        self.navigationItem.hidesBackButton = true
//        UIBarButtonItem(

        // 0 - title, 1 - due date, 2 - goal, 3 - location
        titleTextField.delegate = self ; titleTextField.tag = 0 ;
        titleTextField.layer.borderWidth = 1.0; titleTextField.roundCorner(10.0)
        titleTextField.layer.borderColor = UIColor.rescatPink().cgColor
        
        dueDateTextField.delegate = self ; dueDateTextField.tag = 1
        dueDateTextField.layer.borderWidth = 1.0; dueDateTextField.roundCorner(10.0)
        dueDateTextField.layer.borderColor = UIColor.rescatPink().cgColor
        
        goalAmountTextField.delegate = self ; goalAmountTextField.tag = 2
        goalAmountTextField.layer.borderWidth = 1.0; goalAmountTextField.roundCorner(10.0)
        goalAmountTextField.layer.borderColor = UIColor.rescatPink().cgColor
        
        goalAmountTextField.inputAccessoryView = accessoryView()
        goalAmountTextField.inputAccessoryView?.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 44)

        
        locationTextField.delegate = self ; locationTextField.tag = 3
        locationTextField.layer.borderWidth = 1.0; locationTextField.roundCorner(10.0)
        locationTextField.layer.borderColor = UIColor.rescatPink().cgColor
        
        
        goalAmountTextField.keyboardType = .decimalPad
        showDatePicker()

        descriptionTextView.delegate = self ; descriptionTextView.tag = 0
        descriptionTextView.layer.borderWidth = 1.0 ; descriptionTextView.roundCorner(10.0)
        descriptionTextView.layer.borderColor = UIColor.rescatPink().cgColor
        
        detailDescriptionTextView.delegate = self ; detailDescriptionTextView.tag = 1
        detailDescriptionTextView.layer.borderWidth = 1.0 ; detailDescriptionTextView.roundCorner(10.0)
        detailDescriptionTextView.layer.borderColor = UIColor.rescatPink().cgColor

        
        type1Button.tag = 0; type1Button.addTarget(self, action: #selector(changeType(_:)), for: .touchUpInside)
        type2Button.tag = 1; type2Button.addTarget(self, action: #selector(changeType(_:)), for: .touchUpInside)


        representCollectionView.delegate = self; representCollectionView.dataSource = self
        mainCollectionView.delegate = self ; mainCollectionView.dataSource = self
//        provementImageArray.append(provementImageView1)
//        provementImageArray.append(provementImageView2)
//        provementImageArray.append(provementImageView3)
//        provementImageArray.append(provementImageView4)
        
        descriptionTextView.textContainer.maximumNumberOfLines = 3
        detailDescriptionTextView.textContainer.maximumNumberOfLines = 10
//
        NotificationCenter.default.addObserver(self, selector: #selector(FundingRegisterVC.keyboardWillShow(notification:)), name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(FundingRegisterVC.keyboardWillHide(notification:)), name: UIResponder.keyboardDidHideNotification, object: nil)
        


    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    func mySetBackBtn(){
        
        let backBTN = UIBarButtonItem(image: UIImage(named: "icBack"), //백버튼 이미지 파일 이름에 맞게 변경해주세요.
            style: .plain,
            target: self,
            action: #selector(back(_:)))
        
        navigationItem.leftBarButtonItem = backBTN
        navigationItem.leftBarButtonItem?.tintColor = #colorLiteral(red: 0.4294961989, green: 0.3018877506, blue: 0.2140608728, alpha: 1)
        navigationController?.interactivePopGestureRecognizer?.delegate = self as? UIGestureRecognizerDelegate
    }

    @objc func back( _ sender: UIBarButtonItem!) {
        // Perform your custom actions
        // ...
        // Go back to the previous ViewController
        imageArrUrls.forEach { (element) in
            PhotoRequest.deletePhoto(element)
        }
        imageArr0Urls.forEach { (element) in
            PhotoRequest.deletePhoto(element)
        }
        self.navigationController?.popViewController(animated: true)
    }
    @objc func handleTap(sender: UITapGestureRecognizer) {

        self.view.endEditing(true)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        self.tabBarController?.tabBar.isHidden = true
    }

    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        self.view.endEditing(true)

        textView.resignFirstResponder()
        return true
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
  
        textField.resignFirstResponder()
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == representCollectionView {
            return imageArr.count
        } else {
            return imageArr0.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == representCollectionView {
            if ( imageNum < 3 && indexPath.row == imageArr.count - 1 ) {
                openGallery(1)
            }
        } else {
            if ( imageNum0 < 3 && indexPath.row == imageArr0.count - 1 ) {
                openGallery(0)
            }
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == representCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FundingRegisterCollectionView", for: indexPath) as! FundingRegisterCollectionView
            
            if indexPath.row == 3 {
                cell.deleteButton.isHidden = true
                return cell
            }
        
         
            cell.imageView.image = imageArr[indexPath.row]
            
            cell.deleteButton.tag = indexPath.row
            cell.deleteButton.setImage(UIImage(named:"icRemove"), for: .normal)
            cell.deleteButton.addTarget(self, action: #selector(deleteImageFromButton1(button:)), for: .touchUpInside)
            
            if imageArr.count == 1 && indexPath.row == 0 {
                cell.deleteButton.isHidden = true
            } else if indexPath.row == imageArr.count - 1 {
                cell.deleteButton.isHidden = true
            } else {
                cell.deleteButton.isHidden = false
            }
            return cell
            
        } else {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FundingRegisterCollectionView", for: indexPath) as! FundingRegisterCollectionView
           
            if indexPath.row == 3 {
                cell.deleteButton.isHidden = true
                return cell
            }
            
            cell.imageView.image = imageArr0[indexPath.row]
            
            cell.deleteButton.tag = indexPath.row
            cell.deleteButton.setImage(UIImage(named:"icRemove"), for: .normal)
            cell.deleteButton.addTarget(self, action: #selector(deleteImageFromButton0(button:)), for: .touchUpInside)
            
            if imageArr0.count == 1 && indexPath.row == 0 {
                cell.deleteButton.isHidden = true
            } else if indexPath.row == imageArr0.count - 1 {
                cell.deleteButton.isHidden = true
            } else {
                cell.deleteButton.isHidden = false
            }
            
            return cell
            
        }
        
    }
    
    

    @IBAction func nextAction( _ sender : UIButton!){
        if ( curCategory == 0 && (imageArrUrls.count == 0 || imageArr0Urls.count == 0)) {
            self.simpleAlert(title: "", message: "최소 한장이상의 사진이 필요합니다.")
            
        } else if ( curCategory == 1 && imageArr0Urls.count == 0){
            self.simpleAlert(title: "", message: "최소 한장이상의 사진이 필요합니다.")
            
        }
        else if ( gsno(titleTextField.text) == "" || gsno(dueDateTextField.text) == "" || gsno(goalAmountTextField.text) == "" || gsno(locationTextField.text) == "" ) {
            self.simpleAlert(title: "", message: "모든 항목을 입력해주세요")
            
        } else if ( Int(gsno(goalAmountTextField.text))! < 10000 ) {
            self.simpleAlert(title: "", message:  "최소 금액은 10000원 이상입니다.")
        } else {
        
            print("gotonext")
            let vc = storyboard?.instantiateViewController(withIdentifier: "FundingRegisterVC2") as! FundingRegisterVC2
            vc.fundingDetail.title = gsno(titleTextField.text)
            //        vc.fundingDetail.category = gino(
            vc.fundingDetail.introduction = gsno(descriptionTextView.text)
            vc.fundingDetail.contents = gsno(detailDescriptionTextView.text)
            vc.fundingDetail.goalAmount = Int(gsno(goalAmountTextField.text))
            vc.fundingDetail.mainRegion = gsno(locationTextField.text)
            vc.fundingDetail.category = curCategory
            
           
            vc.fundingDetail.limitAt = "\(gsno(dueDateTextField.text))T23:59:59"
            vc.fundingDetail.certificationUrls = imageArrUrls
            vc.fundingDetail.photoUrls = imageArr0Urls

            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    @objc func changeType ( _ sender : UIButton!) {
        
        if ( sender.tag == 0 || curCategory == 1) {
            
            type1ImageView.image = UIImage(named: "buttonRadioOn")
            type2ImageView.image = UIImage(named: "buttonRadioOff")
            typeLabel.text = "후원정보"
            additionalView.isHidden = false
            overScrollView.contentSize = CGSize(width: self.overScrollView.frame.width, height: 1295)
            curCategory = 0
            
            
//            imageArr = [UIImage(named:"icAddPhoto")!]
            representCollectionView.reloadData()
            imageArrUrls.forEach { (element) in
                PhotoRequest.deletePhoto(element)
            }
            imageArrUrls.removeAll()
            
            titleTextField.text = ""
            descriptionTextView.text = ""
            detailDescriptionTextView.text = ""
            goalAmountTextField.text = ""
            dueDateTextField.text = ""
            locationTextField.text = ""
            

        } else if ( sender.tag == 1 || curCategory == 0) {
            type1ImageView.image = UIImage(named: "buttonRadioOff")
            type2ImageView.image = UIImage(named: "buttonRadioOn")
            typeLabel.text = "프로젝트 정보"
            additionalView.isHidden = true
            overScrollView.contentSize = CGSize(width: self.overScrollView.frame.width, height: 1115) // You can set height, whatever you want.
            curCategory = 1
            
//            imageArr0 = [UIImage(named:"icAddPhoto")!]
            mainCollectionView.reloadData()
            imageArr0Urls.forEach { (element) in
                PhotoRequest.deletePhoto(element)
            }
            imageArr0Urls.removeAll()
            
            titleTextField.text = ""
            descriptionTextView.text = ""
            detailDescriptionTextView.text = ""
            goalAmountTextField.text = ""
            dueDateTextField.text = ""
            locationTextField.text = ""
        }
    }
  
    func showDatePicker(){
        //Formate Date
        datePicker.datePickerMode = .date
        
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker));
        doneButton.tintColor = UIColor.rescatPink()
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
        cancelButton.tintColor = UIColor.rescatPink()
        toolbar.tintColor = UIColor.rescatWhite()
        
        toolbar.setItems([cancelButton,spaceButton,doneButton], animated: false)
        
        dueDateTextField.inputAccessoryView = toolbar
        dueDateTextField.inputView = datePicker
        
    }
    func accessoryView() -> UIView {
        
        let view = UIView()
        view.backgroundColor = UIColor.white
        let doneButton = UIButton()
        doneButton.frame = CGRect(x: self.view.frame.width - 80, y: 7, width: 60, height: 30)
        doneButton.setTitle("done", for: .normal)
        doneButton.setTitleColor(UIColor.rescatPink(), for: .normal)
        
        doneButton.addTarget(self, action: #selector(goalAmountDoneAction), for: .touchUpInside)
        view.addSubview(doneButton)
        
        return view
        
    }
    
    @objc func donedatePicker(){
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        dueDateTextField.text = formatter.string(from: datePicker.date)
//        keyboardHide()
        self.view.endEditing(true)
    }
    
    @objc func cancelDatePicker(){
//        keyboardHide()
        self.view.endEditing(true)
    }
    @objc func deleteImageFromButton1(button: UIButton) {
//        if ( imageArr.count == 4) {
//            self.imageArr.remove(at: 3)
//            self.imageArr.insert(UIImage(named:"icAddPhotoOn")!, at: 3)
//        }
        imageArr.remove(at: button.tag)
        imageNum -= 1
        PhotoRequest.deletePhoto(imageArrUrls[button.tag])
        imageArrUrls.remove(at: button.tag)
        representCollectionView.reloadData()
    }
    @objc func deleteImageFromButton0(button: UIButton) {
//        if ( imageArr0.count == 4) {
//            self.imageArr0.remove(at: 3)
//            self.imageArr0.insert(UIImage(named:"icAddPhotoOn")!, at: 3)
//        }
        imageArr0.remove(at: button.tag)
        imageNum0 -= 1
        PhotoRequest.deletePhoto(imageArr0Urls[button.tag])
        imageArr0Urls.remove(at: button.tag)
        mainCollectionView.reloadData()
    }
    @objc func goalAmountDoneAction() {
        if ( Int(gsno(goalAmountTextField.text)) == 0 ) {
            self.simpleAlert(title: "", message: "0원 이상 금액만 입력할 수 있습니다.")
        }
        goalAmountTextField.resignFirstResponder()
    }
    @objc func keyboardWillShow(notification: NSNotification) {
        print("keyboardWillShow")

        if let keyboardHeight = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height {
            UIView.animate(withDuration: 0.1) {
                self.overScrollView.frame = CGRect(x: 0, y: -keyboardHeight, width: self.view.frame.width, height: self.view.frame.height)
            }

        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        
        if let keyboardHeight = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height {
            UIView.animate(withDuration: 0.1) {
                self.overScrollView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)

            }

        }

    }
   
}
extension FundingRegisterVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // Method
    @objc func openGallery( _ idx : Int) {
        // 0 위에, 1 아래
        if idx == 0 {
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                self.imagePicker0.sourceType = .photoLibrary
                self.imagePicker0.delegate = self
                self.imagePicker0.allowsEditing = true
                self.present(self.imagePicker0, animated: true, completion: { print("이미지 피커 나옴") })
            }
        } else{
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                self.imagePicker.sourceType = .photoLibrary
                self.imagePicker.delegate = self
                self.imagePicker.allowsEditing = true
                self.present(self.imagePicker, animated: true, completion: { print("이미지 피커 나옴") })
            }
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
       
    
        if picker == imagePicker {
            if let editedImage: UIImage = info[.editedImage] as? UIImage {
                imageArr.insert(editedImage, at: 0)
                imageNum += 1
            } else if let originalImage: UIImage = info[.originalImage]  as? UIImage{
                imageArr.insert(originalImage, at: 0)
                imageNum += 1
            }
            guard let  data = imageArr[0].jpegData(compressionQuality: 1.0) else { return }
            imageArrUrls.append(PhotoRequest.uploadPhotos(data))
            
            
            self.dismiss(animated: true) {
                print("이미지 피커 사라짐")
//                if self.imageArr.count == 4 {
//                    self.imageArr.remove(at: 3)
//                    self.imageArr.insert(UIImage(named:"icAddPhotoOff")!, at: 3)
//                }
                self.representCollectionView.reloadData()
            }

        } else {
            if let editedImage: UIImage = info[.editedImage] as? UIImage {
                imageArr0.insert(editedImage, at: 0)
                imageNum0 += 1
            } else if let originalImage: UIImage = info[.originalImage]  as? UIImage{
                imageArr0.insert(originalImage, at: 0)
                imageNum0 += 1
            }
            guard let  data = imageArr0[0].jpegData(compressionQuality: 1.0) else { return }
            imageArr0Urls.append(PhotoRequest.uploadPhotos(data))
            
            self.dismiss(animated: true) {
                print("이미지 피커 사라짐")
//                if self.imageArr0.count == 4 {
//                    self.imageArr0.remove(at: 3)
//                    self.imageArr0.insert(UIImage(named:"icAddPhotoOff")!, at: 3)
//                }
                self.mainCollectionView.reloadData()
            }
        }
        
    }
}
