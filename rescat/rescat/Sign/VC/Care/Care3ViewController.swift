//
//  Care3ViewController.swift
//  rescat
//
//  Created by 김예은 on 30/12/2018.
//  Copyright © 2018 kyeahen. All rights reserved.
//

import UIKit

class Care3ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nextButton: UIButton!
    
    var parentVC : MainCareViewController?
    let imagePicker : UIImagePickerController = UIImagePickerController()
    
    var imgUrl : String?
    var check:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        check = 0
        setCustomView()
    }
    
    //MARK: 뷰 요소 커스텀 세팅
    func setCustomView() {
        nextButton.makeRounded(cornerRadius: 8)
        imageView.makeRounded(cornerRadius: 5)
    }
    
    //MARK: 카메라 액션
    @IBAction func openCamera(_ sender: UITapGestureRecognizer) {
        openCamera()
    }
    
    //MARK: 다음 액션
    @IBAction func nextAction(_ sender: UIButton) {
        if check == 0 {
            self.simpleAlert(title: "", message: "실시간 사진 인증을 완료해주세요.")
        } else {
            parentVC?.changeVC(num: 5)
            UserDefaults.standard.set(imgUrl, forKey: "caretakerPhoto")
        }
    }
    
    
}

//MARK: Networking Extension
extension Care3ViewController {
    
    func addImage(image : Data?){
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
                    self.imageView.kf.setImage(with: URL(string: img), placeholder: UIImage())
                    self.imgUrl = img
                    self.check = 1
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

//MARK: 이미지 첨부
extension Care3ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //Method
    @objc func openGallery() {
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
        //        defer {
        //            self.dismiss(animated: true) {
        //                print("이미지 피커 사라짐")
        //            }
        //        }
        
        if let editedImage = info[.editedImage] as? UIImage {
            imageView.image = editedImage
            let photo = editedImage.jpegData(compressionQuality: 0.3)
            addImage(image: photo) //이미지 추가
        } else if let selectedImage = info[.originalImage] as? UIImage as? UIImage{
            imageView.image = selectedImage
            let photo = selectedImage.jpegData(compressionQuality: 0.3)
            addImage(image: photo)
        }
        
        self.dismiss(animated: true) {
            print("이미지 피커 사라짐")
        }
    }
    
}
