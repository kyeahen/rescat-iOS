//
//  Care3ViewController.swift
//  rescat
//
//  Created by 김예은 on 30/12/2018.
//  Copyright © 2018 kyeahen. All rights reserved.
//

import UIKit
import CoreLocation

class Care3ViewController: UIViewController {

    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nextButton: UIButton!
    
    var parentVC : MainCareViewController?
    let imagePicker : UIImagePickerController = UIImagePickerController()
    
    var locationManager:CLLocationManager!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        setLocation()
        setCustomView()
    }
    
    //MARK: 뷰 요소 커스텀 세팅
    func setCustomView() {
        nextButton.makeRounded(cornerRadius: 8)
    }
    
    //MARK: 카메라 액션
    //TODO: 휴대폰으로 테스트 해보기
    @IBAction func openCamera(_ sender: UITapGestureRecognizer) {
        openCamera()
    }
    
    //MARK: 다음 액션
    @IBAction func nextAction(_ sender: UIButton) {
        
        parentVC?.changeVC(num: 5)
    }
    
    
}

//MARK: 지오 코딩
extension Care3ViewController {
    
//    func getAddressForLatLng(latitude: String, longitude: String) {
//        let url = URL(string: "\(baseUrl)latlng=\(latitude),\(longitude)&key=\(apikey)")
//        let data = NSData(contentsOfURL: url!)
//        let json = try! JSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments) as! NSDictionary
//        if let result = json["results"] as? NSArray {
//            if let address = result[0]["address_components"] as? NSArray {
//                let number = address[0]["short_name"] as! String
//                let street = address[1]["short_name"] as! String
//                let city = address[2]["short_name"] as! String
//                let state = address[4]["short_name"] as! String
//                let zip = address[6]["short_name"] as! String
//                print("\n\(number) \(street), \(city), \(state) \(zip)")
//            }
//        }
//    }
}

//MARK: 현재 위치
extension Care3ViewController: CLLocationManagerDelegate {

    func setLocation() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization() //권한 요청
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //위치가 업데이트될때마다
        if let coor = manager.location?.coordinate{
            print("latitude: " + String(coor.latitude) + " / longitude: " + String(coor.longitude))
        }
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
