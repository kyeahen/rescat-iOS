//
//  MapViewController.swift
//  rescat
//
//  Created by 김예은 on 23/12/2018.
//  Copyright © 2018 kyeahen. All rights reserved.
//

import UIKit
import GoogleMaps
import SnapKit
class MapViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource ,UITextFieldDelegate, GMSMapViewDelegate, APIServiceCallback {
    
    @IBOutlet weak var startLabel: UILabel!
    @IBOutlet var startButton : UIButton!
    @IBOutlet weak var alertView: UIView!
    var pickerView : UIPickerView!
    var locationButton : UITextField!
    var currentRegion = ""
//    var pick
    @IBOutlet var mapView : GMSMapView!
    
    @IBOutlet var button1 : UIButton!
    @IBOutlet var button2 : UIButton!
    @IBOutlet var button3 : UIButton!
    @IBOutlet var button4 : UIButton!
    @IBOutlet var locationButtonView : UIView!
    
    var buttons = [UIButton]()

//    var detailViewHeight = 140   // temp value
    var detailViewCreated = false
    var detailView : UIView!; var detailImageView : UIImageView!; var detailNameView : UILabel!
    var detailBirthView : UILabel!; var detailPropertyView : UILabel!; var detailTextView : UILabel!
    @IBOutlet var coverView : UIView!
    
//    var initData : [TestModel] = []
//    var filterdData : [TestModel] = []
    var markerList : [MarkerModel] = []
    var filteredMarkerList : [MarkerModel] = []
    var mapRequest : MapRequest!
    var myEmdCodes : [Int] = [1123051]
    var myRegions : [String] = ["서울특별시 강남구 신사동"]
    
//    var detailView0 : DetailView!
//    var detailView1 : DetailView2!
//    var detailView2 : DetailView3!
    var focusMap : MarkerModel!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.setNaviTitle(name: "우리동네 길냥이")
        guard let token = UserDefaults.standard.string(forKey: "token") else { return }

        if ( token == "-1" ) {
            
            print("비회원")
            alertView.isHidden = false
            startLabel.text = UserInfo.memberMessage
            startButton.setTitle("회원가입하기", for: .normal)
            startButton.tag = 1 ; startButton.addTarget(self, action: #selector(gotoAction(_:)), for: .touchUpInside)
            startButton.roundCorner(10.0)

        } else {
            
            guard let role = UserDefaults.standard.string(forKey: "role") else { return }

            if ( role == "CARETAKER") {
                // 케어테이커
                mapRequest = MapRequest(self)
                guard let regions = UserDefaults.standard.array(forKey: "regions") as? [String] else { return }
                guard let emdCodes = UserDefaults.standard.array(forKey: "emdCodes") as? [Int] else { return }
                myEmdCodes = emdCodes ; myRegions = regions
                
                mapRequest.getMapList(emdCodes[0])
                
                alertView.isHidden = true
                let backBTN = UIBarButtonItem(image: UIImage(named: "iconNewPost"), //백버튼 이미지 파일 이름에 맞게 변경해주세요.
                    style: .plain,
                    target: self,
                    action: #selector(registerButtonAction(_:)))
                
                let backBTN2 = UIBarButtonItem(image: UIImage(named: "icSearch"), //백버튼 이미지 파일 이름에 맞게 변경해주세요.
                    style: .plain,
                    target: self,
                    action: #selector(searchButtonAction(_:)))
                backBTN.tintColor = UIColor(red: 190/255, green: 153/255, blue: 129/255, alpha: 1.0)
                backBTN2.tintColor = UIColor(red: 190/255, green: 153/255, blue: 129/255, alpha: 1.0)
            
                
                navigationItem.rightBarButtonItems = [backBTN,backBTN2]
                navigationController?.interactivePopGestureRecognizer?.delegate = self as? UIGestureRecognizerDelegate
                
                
//                for (index, element) in UserInfo.getLocation().enumerated(){
//                    myLocation.append(gsno(element.keys.first))
//                }
                buttons.append(button1); buttons.append(button2); buttons.append(button3); buttons.append(button4);
                for (index, element) in buttons.enumerated() {
                    element.addTarget(self, action: #selector(filterButton), for: .touchUpInside)
                    element.tag = index
                    element.layer.shadowColor = UIColor.black.cgColor; element.layer.shadowOpacity = 0.5
                    element.layer.shadowOffset = CGSize.zero; element.layer.shadowRadius = 3
                    if ( element.tag == 0 ) {
                        element.backgroundColor = UIColor.rescatPink()
                        element.setTitleColor(UIColor.white, for: .normal)
                    } else {
                        element.backgroundColor = UIColor.white
                        element.setTitleColor(UIColor.rescatBlack(), for: .normal)
                        
                    }
                }
                locationButtonView.drawShadow(15)
                locationButtonView.roundCorner(15)
                locationButtonView.backgroundColor = UIColor.white
                locationButton = UITextField()
                locationButton.delegate = self
                
                locationButton.text = myRegions[0]
                locationButton.textColor = UIColor.rescatBlack();
                locationButton.font = .systemFont(ofSize: 14)
                locationButtonView.addSubview(locationButton)
                locationButton.snp.makeConstraints { (make) in
                    make.centerX.equalTo(locationButtonView)
                    make.centerY.equalTo(locationButtonView)
                }
                pickerView = UIPickerView(frame:CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 162))
                pickerView.delegate = self
                pickerView.dataSource = self
                
                locationButton.inputView = pickerView
                
                let toolBar = UIToolbar()
                toolBar.barStyle = .default
                toolBar.isTranslucent = true
                toolBar.tintColor = UIColor.rescatPink()
                toolBar.sizeToFit()
                
                let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(selectLocation))
                let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
                let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelClick))
                
                toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
                toolBar.isUserInteractionEnabled = true
                locationButton.inputAccessoryView = toolBar
                
                //  내 도시로 focus
                let naverRequest = NaverMapRequest(self)
                self.mapView.delegate = self
                self.mapView.settings.rotateGestures = false
//                self.mapView.setMinZoom(15.0, maxZoom: 20.0)
                naverRequest.requestGeocoder(myRegions[0])
                
            } else {
                
                alertView.isHidden = false
                startLabel.text = UserInfo.notMessage
                startButton.setTitle("케어테이커 인증하기", for: .normal)
                startButton.tag = 0 ; startButton.addTarget(self, action: #selector(gotoAction(_:)), for: .touchUpInside)
                startButton.roundCorner(10.0)
            }
        }
        
    }
  
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        self.tabBarController?.tabBar.isHidden = false
        
        if focusMap != nil {
            loadMapView(latitude: gdno(focusMap.lat), longitude: gdno(focusMap.lng), zoom: 16.0)
            makeMarkerView(markerList)
        }

      
    }
    @objc func gotoAction( _ sender : UIButton! ) {
        if sender.tag == 1 {
            //회원가입
            let join = UIStoryboard(name: "Sign", bundle: nil)
            let vc = join.instantiateViewController(withIdentifier: "JoinViewController") as! JoinViewController
            

            self.navigationController?.pushViewController(vc, animated: true)


        } else {
            // 케어테이커
//            let storyboard = storyboard.
            
            if MyPageViewController.careCheck == 0 {
                let care = UIStoryboard(name: "Care", bundle: nil)

                let vc = care.instantiateViewController(withIdentifier: "MainCareViewController") as! MainCareViewController
    //            self.present(vc, animated:  true)

                self.navigationController?.pushViewController(vc, animated: true)
            } else {
                self.simpleAlert(title: "", message: "케어테이커 신청 대기 상태입니다.")
            }


        }
    }
    
    // hide detailView && appear floating button
    func detailViewHidden(_ isHidden : Bool){
        if ( isHidden ) {
            UIView.animate(withDuration: 0.15, animations: {
                if (self.detailViewCreated) { self.detailView.alpha = 0.0 }
            }) { (_) in UIView.animate(withDuration: 0.15, animations: {
                self.locationButtonView.alpha = 1.0
            })}
            
        } else {
            UIView.animate(withDuration: 0.15, animations: {
                self.locationButtonView.alpha = 0.0
            }) { (_) in UIView.animate(withDuration: 0.15, animations: {
                self.detailView.alpha = 1.0
            })}
        }
    }
    @objc func viewActionSheet( _ sender : UIButton!){
        let actionSheet = UIAlertController(title: nil,
                                            message: nil,
                                            preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "수정", style: .default, handler: { result in
            //doSomething
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "modifyVC") as! UINavigationController
            self.simpleAlert(title: "", message: "권한이 없습니다.")
//            self.present(vc, animated: true)
        }))
        actionSheet.addAction(UIAlertAction(title: "신고",
                                            style: .default, handler: { result in
            //doSomething
            self.simpleAlert(title: "", message: "해당글을 신고하였습니다.")
        }))
        actionSheet.addAction(UIAlertAction(title: "cancel", style: .cancel, handler: nil))
        self.present(actionSheet, animated: true, completion: nil)
        
    }
    @objc func selectLocation(_ sender : UIButton!){

        let map = NaverMapRequest(self)
        map.requestGeocoder(gsno(locationButton.text))
        
//        let move = CLLocationCoordinate2D(latitude: CLLocationDegrees(36.899999), longitude: CLLocationDegrees(127.03111111))
//        self.mapView.animate(toLocation: move)
        locationButton.resignFirstResponder()

    }
    @objc func cancelClick(_ sender : UIButton!){
        locationButton.resignFirstResponder()
    }
    @objc func modifyRequestAction(_ sender : UIButton!) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "ModifyViewController") as! ModifyViewController
        self.present(vc, animated: true, completion: nil)
    }
    @objc func registerButtonAction(_ sender : UIBarButtonItem!) {
        print("register")
//        let view = DetailView(frame: self.view.frame)
//        self.view.addSubview(view)
        let mapstoryboard = UIStoryboard(name: "Map", bundle: nil)
        let vc = mapstoryboard.instantiateViewController(withIdentifier: "Register1VC") as!
        Register1VC
        self.navigationController?.pushViewController(vc, animated: true)
//        self.present(vc, animated: true, completion: nil)

    }
    @objc func searchButtonAction(_ sender : UIBarButtonItem!){
        print("search")
        let vc = storyboard?.instantiateViewController(withIdentifier: "SearchViewController") as! SearchViewController
        vc.mapDatas = markerList
        self.navigationController?.pushViewController(vc, animated: true)
//        self.searchButton.isHidden = false
//        self.searchbar.resignFirstResponder()
    }

    @objc func filterButton(_ sender : UIButton!){
        
        locationButton.resignFirstResponder()
        buttons.forEach { (button) in
            button.backgroundColor = UIColor.white
            button.setTitleColor(UIColor.rescatBlack(), for: .normal)
        }
        sender.backgroundColor = UIColor.rescatPink()
        sender.setTitleColor(UIColor.white, for: .normal)

        detailViewHidden(true)
        
        if ( sender.tag == 0 ){ makeMarkerView(markerList) }
        else {
            filteredMarkerList = markerList.filter { (element) -> Bool in
                return gino(element.category)+1 == sender.tag
            }
            makeMarkerView(filteredMarkerList)
        }
    }
    func loadMapView(latitude : Double, longitude : Double, zoom : Float){
        let camera = GMSCameraPosition.camera(withLatitude: latitude, longitude: longitude, zoom: zoom)
        self.mapView.camera = camera
        let move = CLLocationCoordinate2D(latitude: CLLocationDegrees(latitude), longitude: CLLocationDegrees(longitude))
        self.mapView.animate(toLocation: move)
    
    }
    func focusMarkerView(){
        
    }
    
    func makeMarkerView(_ data : [MarkerModel]) {
        
        mapView.clear()
        // make marker objects
        for i in 0..<data.count{
            let marker = GMSMarker()
            let position = CLLocationCoordinate2D(latitude: CLLocationDegrees(gdno(data[i].lat)), longitude: CLLocationDegrees(gdno(data[i].lng)))

            if gdno(data[i].lat) >= 40.0
            {
                continue
            }
            marker.userData = data[i]
            switch gino(data[i].category) {
            case 0:
                marker.icon = UIImage(named: "icMapFood"); break

            case 1:
                marker.icon = UIImage(named: "icMapHospital");

            case 2:
                marker.icon = UIImage(named: "icMapCat");
                let circleCenter = position
                let circ = GMSCircle(position: circleCenter, radius: 100)
                circ.fillColor = UIColor(red: 242/255, green: 145/255, blue: 145/255, alpha: 0.2)
                circ.strokeColor = .none
                circ.map = mapView
                

                break
            default:
                marker.icon = UIImage(named: "icMapHospital"); break

            }

            marker.position = position
            marker.snippet = gsno(data[i].name)
            marker.map = mapView
            

        }
       
    }
    //  -----------------------------  UITextFieldDelegate function ----------------------------
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("text field start")
        coverView.isHidden = false
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("text field end")
        coverView.isHidden = true
    }
   
    //  -----------------------------  UIPickerViewDelage, DataSource function ----------------------------

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return myRegions.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return myRegions[row]
        
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        locationButton.text = myRegions[row]
    }
    //  -----------------------------  GMSMapViewDelegate function ----------------------------
    func mapView(_ mapView: GMSMapView, didCloseInfoWindowOf marker: GMSMarker) {
        print("end")
        detailViewHidden(true)
    }
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        
        let data = marker.userData as! MarkerModel
        let category = gino(data.category)
        print("category --\(category)")
        
        if ( !detailViewCreated ) {
            print("creaeted")
            detailViewCreated = true
            detailView = UIView()
            detailView.layer.borderColor = UIColor.gray.cgColor
            detailView.layer.borderWidth = 0.2
            detailView.backgroundColor = UIColor.black
            self.view.addSubview(detailView)
            detailView.snp.makeConstraints { (make) in
                make.left.equalTo(self.view.snp.left).offset(15)
                make.right.equalTo(self.view.snp.right).offset(-15)
                make.height.equalTo(140)
                make.bottom.equalTo(self.view.snp.bottom).offset(-57)
            }
            if ( category == 0 ) {
                // 배식소
            
                let detailContents = DetailView2(frame: detailView.frame)
                detailContents.drawShadow(10.0)
                detailContents.modifyButton.addTarget(self, action: #selector(viewActionSheet), for: .touchUpInside)
                if let url = data.photoUrl {
                    detailContents.imageView.kf.setImage(with: URL(string:url))
                } else {
                    detailContents.imageView.image = UIImage(named: "markerdefault")
                }
                detailContents.nameLabel.text = gsno(data.name)
                detailContents.propertyLabel.text = gsno(data.etc)
                
                self.detailView.addSubview(detailContents)
                detailContents.snp.makeConstraints { (make) in
                    make.left.equalTo(self.detailView.snp.left)
                    make.right.equalTo(self.detailView.snp.right)
                    make.bottom.equalTo(self.detailView.snp.bottom)
                    make.top.equalTo(self.detailView.snp.top)

                }
            } else if category == 1 {
                // 병원
                let detailContents = DetailView3(frame: detailView.frame)
                detailContents.drawShadow(10.0)
                detailContents.modifyButton.addTarget(self, action: #selector(viewActionSheet), for: .touchUpInside)
                if let url = data.photoUrl {
                    detailContents.imageView.kf.setImage(with: URL(string:url))
                } else {
                    detailContents.imageView.image = UIImage(named: "markerdefault")
                }
                detailContents.nameLabel.text = gsno(data.name)
                detailContents.saleLabel.text = gsno(data.etc)
                detailContents.propertyLabel.text = gsno(data.address)

                
                self.detailView.addSubview(detailContents)
                detailContents.snp.makeConstraints { (make) in
                    make.left.equalTo(self.detailView.snp.left)
                    make.right.equalTo(self.detailView.snp.right)
                    make.bottom.equalTo(self.detailView.snp.bottom)
                    make.top.equalTo(self.detailView.snp.top)

                }
            } else {
                // 고양이
                let detailContents = DetailView(frame: detailView.frame)
                detailContents.drawShadow(10.0)
                detailContents.modifyButton.addTarget(self, action: #selector(viewActionSheet), for: .touchUpInside)
                //
                
                if let url = data.photoUrl {
                    detailContents.imageView.kf.setImage(with: URL(string:url))
                } else {
                    detailContents.imageView.image = UIImage(named: "markerdefault")
                }
                detailContents.nameLabel.text = gsno(data.name)
                detailContents.propertyLabel.text = gsno(data.etc)
                detailContents.ageLabel.text = gsno(data.age)
                if gino(data.sex) == 0 {
                    detailContents.sexLabel.text = "남"
                } else {
                    detailContents.sexLabel.text = "여"
                }
                if gino(data.tnr) == 0 {
                    detailContents.TRNLabel.text = "해당없음"
                } else if gino(data.tnr) == 1 {
                    detailContents.TRNLabel.text = "완료"
                } else {
                    detailContents.TRNLabel.text = "모름"
                }
                self.detailView.addSubview(detailContents)
                detailContents.snp.makeConstraints { (make) in
                    make.left.equalTo(self.detailView.snp.left)
                    make.right.equalTo(self.detailView.snp.right)
                    make.bottom.equalTo(self.detailView.snp.bottom)
                    make.top.equalTo(self.detailView.snp.top)

                }
            }
            
            detailView.tag = 0
//            detailView.
            
            
        } else {
            detailView.tag += 1

            for v in detailView.subviews {
                v.removeFromSuperview()
            }
            detailView.backgroundColor = UIColor.green

            if ( category == 0 ) {
                // 배식소
                    print("배식소")
                let detailContents = DetailView2(frame: detailView.frame)
                detailContents.drawShadow(10.0)
                detailContents.modifyButton.addTarget(self, action: #selector(viewActionSheet), for: .touchUpInside)
                if let url = data.photoUrl {
                    detailContents.imageView.kf.setImage(with: URL(string:url))
                } else {
                    detailContents.imageView.image = UIImage(named: "markerdefault")
                }
                detailContents.nameLabel.text = gsno(data.name)
                detailContents.propertyLabel.text = gsno(data.etc)
                
                self.detailView.addSubview(detailContents)
                detailContents.snp.makeConstraints { (make) in
                    make.left.equalTo(self.detailView.snp.left)
                    make.right.equalTo(self.detailView.snp.right)
                    make.bottom.equalTo(self.detailView.snp.bottom)
                    make.top.equalTo(self.detailView.snp.top)
                    
                }
            } else if category == 1 {
                // 병원
              print("a병원")
                
                let detailContents = DetailView3(frame: detailView.frame)
                detailContents.drawShadow(10.0)
                detailContents.modifyButton.addTarget(self, action: #selector(viewActionSheet), for: .touchUpInside)
                if let url = data.photoUrl {
                    detailContents.imageView.kf.setImage(with: URL(string:url))
                } else {
                    detailContents.imageView.image = UIImage(named: "markerdefault")
                }
                detailContents.nameLabel.text = gsno(data.name)
                detailContents.propertyLabel.text = gsno(data.address)
                detailContents.saleLabel.text = gsno(data.etc)
                
                self.detailView.addSubview(detailContents)
                detailContents.snp.makeConstraints { (make) in
                    make.left.equalTo(self.detailView.snp.left)
                    make.right.equalTo(self.detailView.snp.right)
                    make.bottom.equalTo(self.detailView.snp.bottom)
                    make.top.equalTo(self.detailView.snp.top)
                    
                }
            } else {
                // 고양이
             
                let detailContents = DetailView(frame: detailView.frame)
                detailContents.drawShadow(10.0)
                detailContents.modifyButton.addTarget(self, action: #selector(viewActionSheet), for: .touchUpInside)
                //
                
                if let url = data.photoUrl {
                    detailContents.imageView.kf.setImage(with: URL(string:url))
                } else {
                    detailContents.imageView.image = UIImage(named: "markerdefault")
                }
                detailContents.nameLabel.text = gsno(data.name)
                detailContents.propertyLabel.text = gsno(data.etc)
                detailContents.ageLabel.text = gsno(data.age)
                if gino(data.sex) == 0 {
                    detailContents.sexLabel.text = "남"
                } else {
                    detailContents.sexLabel.text = "여"
                }
                if gino(data.tnr) == 0 {
                    detailContents.TRNLabel.text = "해당없음"
                } else if gino(data.tnr) == 1 {
                    detailContents.TRNLabel.text = "완료"
                } else {
                    detailContents.TRNLabel.text = "모름"
                }
                
                self.detailView.addSubview(detailContents)
                detailContents.snp.makeConstraints { (make) in
                    make.left.equalTo(self.detailView.snp.left)
                    make.right.equalTo(self.detailView.snp.right)
                    make.bottom.equalTo(self.detailView.snp.bottom)
                    make.top.equalTo(self.detailView.snp.top)
                    
                }

            }
            
           
        }
        detailViewHidden(false)

        return false
    }
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        locationButton.resignFirstResponder()
        print("coordinate \(coordinate.latitude) \(coordinate.longitude)")
    }
    func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
        // zoom in & out
    }
    
    @IBAction func unwindToMainScreen(segue: UIStoryboardSegue) {
        print("Unwind segue to main screen triggered!")
    }

}

extension MapViewController{
    // network call back
    func requestCallback(_ datas: Any, _ code: Int) {
//        if ( code == APIServiceCode.)
        if ( code == APIServiceCode.GEOCODE ) {
            let location = datas as! String
            let coordinate = location.split(separator: " ")
//            loadMapView(latitude: Double(coordinate[0]), longitude: Double(coordinate[1]), zoom: 15.0)
//            coordinate
//            print("GEOCODE RESULT \(Float(coordinate[0]))")
            loadMapView(latitude: gdno(Double(coordinate[0])), longitude: gdno(Double(coordinate[1])), zoom: 15.0)
        } else if ( code == APIServiceCode.MARKER_LIST ) {
            markerList = datas as! [MarkerModel]
            makeMarkerView(markerList)

        }
    }
}
