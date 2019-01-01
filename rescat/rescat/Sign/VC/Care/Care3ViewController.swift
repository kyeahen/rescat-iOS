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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
        parentVC?.changeVC(num: 5)
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
        } else if let selectedImage = info[.originalImage] as? UIImage as? UIImage{
            imageView.image = selectedImage
        }
        
        self.dismiss(animated: true) {
            print("이미지 피커 사라짐")
        }
    }
    
}
