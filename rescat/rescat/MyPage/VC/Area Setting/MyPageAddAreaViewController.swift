//
//  MyPageAddAreaViewController.swift
//  rescat
//
//  Created by 김예은 on 06/01/2019.
//  Copyright © 2019 kyeahen. All rights reserved.
//

import UIKit
import CoreLocation

class MyPageAddAreaViewController: UIViewController {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var areaLabel: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    
    var locationManager: CLLocationManager!
    var check: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setCustomView()
        
        backView.isHidden = true
        
        loader.hidesWhenStopped = true
        loader.startAnimating()
        setLocation()
    }
    
    //MARK: 뷰 요소 커스텀 세팅
    func setCustomView() {
        backView.makeRounded(cornerRadius: 17.5)
        saveButton.makeRounded(cornerRadius: 8)
    }
    
    //MARK: 새로고침 액션
    @IBAction func reloadAction(_ sender: UIButton) {
        loader.isHidden = false
        loader.startAnimating()
        setLocation()
    }
    
    //MAKR: 창닫기 액션
    @IBAction func dismissAction(_ sender: UIBarButtonItem) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK: 완료 액션(unwind segue)
    @IBAction func saveAction(_ sender: UIButton) {
        if check == 0 {
            self.simpleAlert(title: "", message: "현재 위치 설정을 완료해주세요.")
        } else {
            postAddArea(_address: gsno(areaLabel.text))
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.loader.stopAnimating()
    }
    
    
}

//MARK: Networking Extension
extension MyPageAddAreaViewController {
    
    //지역 추가
    func postAddArea(_address: String) {

        
        AddAreaService.shareInstance.postAddArea(address: _address) {
            (result) in
            
            switch result {
            case .networkSuccess(_ ):

                self.performSegue(withIdentifier: "unwindToArea", sender: self)
                break
                
            case .accessDenied:
                self.simpleAlert(title: "", message: "로그인 후, 이용할 수 있습니다.")
                break
                
            case .duplicated:
                self.simpleAlert(title: "", message: "이미 등록한 지역입니다.")
                break
                
            case .networkFail:
                self.networkErrorAlert()
                break
                
            default:
                self.simpleAlert(title: "오류", message: "다시 시도해주세요.")
                break
            }
            
        }
    }
}

//MARK: Reverse Geocoding Network Extension
extension MyPageAddAreaViewController {
    
    func getAddress(_lat: Double, _lon: Double) {
        
        ReGeocodingService.getAddress(lat: _lat, lon: _lon) {
            (result) in
            switch result {
                
            case .success(let data) :
                self.backView.isHidden = false
                self.loader.stopAnimating()
                if data.resCode == 0 {
                    let addressData = data.resResult as? ReGeocodingData
                    
                    let si = self.gsno(addressData?.results[1].region.area1.name)
                    let gu = self.gsno(addressData?.results[1].region.area2.name)
                    let dong = self.gsno(addressData?.results[1].region.area3.name)
                    
                    let address = "\(si) \(gu) \(dong)"
                    self.areaLabel.text = address
                    self.check = 1
                    
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
extension MyPageAddAreaViewController: CLLocationManagerDelegate {
    
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
  
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("location err")
    }
    
}

