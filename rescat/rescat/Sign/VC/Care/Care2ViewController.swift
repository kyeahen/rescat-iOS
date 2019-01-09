//
//  Care2ViewController.swift
//  rescat
//
//  Created by 김예은 on 29/12/2018.
//  Copyright © 2018 kyeahen. All rights reserved.
//

import UIKit
import CoreLocation

class Care2ViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nextButton: UIButton!
    
    @IBOutlet weak var addAreaButton: UIButton!
    @IBOutlet weak var areaView: UIView!
    @IBOutlet weak var areaLabel: UILabel!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    
    var parentVC : MainCareViewController?
    var locationManager: CLLocationManager!
    var check: Int = 0
    
//    var dataRecieved: String? {
//        willSet {
//            areaLabel.text = newValue
//        }
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setCustomView()
        
        loader.isHidden = true
        loader.hidesWhenStopped = true
        
    }
    
    //MARK: 뷰 요소 커스텀 세팅
    func setCustomView() {
        imageView.circleImageView()
        nextButton.makeRounded(cornerRadius: 8)
        
        areaView.isHidden = true
        areaView.makeRounded(cornerRadius: 18.5)
    }
    
    //MARK: 현재 주소 얻기 액션
    @IBAction func getAddressAction(_ sender: UIButton) {
        loader.isHidden = false
        loader.startAnimating()
        setLocation()
    }
    
    //MARK: 새로고침 액션
    @IBAction func reloadAction(_ sender: UIButton) {
        loader.isHidden = false
        loader.startAnimating()
        setLocation()
    }
    
    //MARK: 다음 액션
    //TODO: 사용자 위치가 설정되어있어야 가능
    @IBAction func nextAction(_ sender: UIButton) {
        if check == 0 {
            self.simpleAlert(title: "", message: "지역 설정을 완료해주세요.")
        } else {
            UserDefaults.standard.set(areaLabel.text, forKey: "caretakerArea")
            parentVC?.changeVC(num: 4)
        }
    }
    
//    //MARK: UnwindSegue (areaVC -> care2VC)
//    @IBAction func unwindToCare2(sender: UIStoryboardSegue) {
//        if let areaVC = sender.source as? AreaViewController {
//            areaView.isHidden = false
//            dataRecieved = areaVC.address
//        }
//    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.loader.stopAnimating()
    }
    
}

//MARK: Reverse Geocoding Network Extension
extension Care2ViewController {
    
    func getAddress(_lat: Double, _lon: Double) {
        
        ReGeocodingService.getAddress(lat: _lat, lon: _lon) {
            (result) in
            switch result {
                
            case .success(let data) :
                self.loader.stopAnimating()
                if data.resCode == 0 {
                    let addressData = data.resResult as? ReGeocodingData
                    
                    let si = self.gsno(addressData?.results[1].region.area1.name)
                    let gu = self.gsno(addressData?.results[1].region.area2.name)
                    let dong = self.gsno(addressData?.results[1].region.area3.name)
                    
                    let address = "\(si) \(gu) \(dong)"
                    self.areaLabel.text = address
                    self.check = 1
                    self.addAreaButton.isHidden = true
                    self.areaView.isHidden = false
                    
                } else if data.resCode == 3 {
                    self.simpleAlert(title: "실패", message: "현재 위치를 찾을 수 없습니다.")
                } else {
                    self.networkErrorAlert()
                }
                
            case .error(_):
                self.networkErrorAlert()
                break
                
            case .failure(_):
                self.networkErrorAlert()
                break
            }
            
        }
        
    }
}

//MARK: 현재 위치 얻기
extension Care2ViewController: CLLocationManagerDelegate {
    
    func setLocation() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization() //권한 요청
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestLocation()
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //위치가 업데이트될때마다
        if let coor = manager.location?.coordinate {
            //            print("latitude: " + String(coor.latitude) + " / longitude: " + String(coor.longitude))
            getAddress(_lat: coor.latitude, _lon: coor.longitude)
            print("위치")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("location err")
    }
    
}
