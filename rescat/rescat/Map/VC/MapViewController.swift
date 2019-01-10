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
    var myLocation = [String]()
    @IBOutlet var mapView : GMSMapView!
    
    @IBOutlet var button1 : UIButton!
    @IBOutlet var button2 : UIButton!
    @IBOutlet var button3 : UIButton!
    @IBOutlet var button4 : UIButton!
    var buttons = [UIButton]()
    @IBOutlet var locationButtonView : UIView!
    
    
    var detailViewHeight = 140   // temp value
    var detailViewCreated = false
    var detailView : UIView!; var detailImageView : UIImageView!; var detailNameView : UILabel!
    var detailBirthView : UILabel!; var detailPropertyView : UILabel!; var detailTextView : UILabel!
    @IBOutlet var coverView : UIView!
    
    var initData : [TestModel] = []
    var filterdData : [TestModel] = []
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.setNaviTitle(name: "우리동네 길냥이")

        guard let token = UserDefaults.standard.string(forKey: "token") else { return }
//        guard let role = UserDefaults.standard.string(forKey: "role") else { return }
        
        if ( token == "-1" ) {
            
            print("비회원")
            alertView.isHidden = false
            startLabel.text = UserInfo.memberMessage
            startButton.setTitle("케어테이커 인증하기", for: .normal)
            startButton.tag = 1 ; startButton.addTarget(self, action: #selector(gotoAction(_:)), for: .touchUpInside)
            startButton.roundCorner(10.0)

        } else {
                    guard let role = UserDefaults.standard.string(forKey: "role") else { return }

        
            print("로그인")
            if ( role == "CARETAKER") {
                // 케어테이커
                
                alertView.isHidden = true
                
                let backBTN = UIBarButtonItem(image: UIImage(named: "iconNewPost"), //백버튼 이미지 파일 이름에 맞게 변경해주세요.
                    style: .plain,
                    target: self,
                    action: #selector(registerButtonAction(_:)))
                
                let backBTN2 = UIBarButtonItem(image: UIImage(named: "icSearch"), //백버튼 이미지 파일 이름에 맞게 변경해주세요.
                    style: .plain,
                    target: self,
                    action: #selector(searchButtonAction(_:)))
                backBTN.tintColor = #colorLiteral(red: 0.4294961989, green: 0.3018877506, blue: 0.2140608728, alpha: 1)
                backBTN2.tintColor = #colorLiteral(red: 0.4294961989, green: 0.3018877506, blue: 0.2140608728, alpha: 1)
                
                navigationItem.rightBarButtonItems = [backBTN,backBTN2]
                navigationController?.interactivePopGestureRecognizer?.delegate = self as? UIGestureRecognizerDelegate
                
                
                for (index, element) in UserInfo.getLocation().enumerated(){
                    myLocation.append(gsno(element.keys.first))
                }
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
                
                locationButtonView.roundCorner(15)
                locationButtonView.drawShadow(15)
                locationButtonView.backgroundColor = UIColor.white
                locationButton = UITextField()
                locationButton.delegate = self
                
                locationButton.text = "서울시 서초구"
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
                //        print("naver request \(?)")
                self.mapView.delegate = self
                currentRegion = myLocation[0]
                naverRequest.requestGeocoder(myLocation[0])
                //        loadMapView(latitude: 37.498197, longitude: 127.027610, zoom: 15.0)
            } else if ( role == "MEMBER" ) {
                
                
                
                alertView.isHidden = false
                startLabel.text = UserInfo.notMessage
                startButton.setTitle("회원가입하기", for: .normal)
                startButton.tag = 0 ; startButton.addTarget(self, action: #selector(gotoAction(_:)), for: .touchUpInside)
                startButton.roundCorner(10.0)
            }
        }
        
    }
  
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)


        guard let role = UserDefaults.standard.string(forKey: "role") else { return }

        if ( role == "CARETAKER" ) {
            let res = UserInfo.getLocation()
            print("location \(res[0].keys.first)")
            let request = Test(self)
            request.testRequest()
        } else { }

      
    }
    @objc func gotoAction( _ sender : UIButton! ) {
        if sender.tag == 0 {
            //회원가입
            let join = UIStoryboard(name: "Sign", bundle: nil)
            let vc = join.instantiateViewController(withIdentifier: "JoinViewController") as! JoinViewController
            
            self.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(vc, animated: true)
            self.hidesBottomBarWhenPushed = false

        } else {
            // 케어테이커
//            let storyboard = storyboard.
            let care = UIStoryboard(name: "Care", bundle: nil)

            let vc = care.instantiateViewController(withIdentifier: "MainCareViewController") as! MainCareViewController
//            self.present(vc, animated:  true)
            self.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(vc, animated: true)
            self.hidesBottomBarWhenPushed = false

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
            self.present(vc, animated: true)
        }))
        actionSheet.addAction(UIAlertAction(title: "신고", style: .default, handler: { result in
            //doSomething
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
        let vc = mapstoryboard.instantiateViewController(withIdentifier: "RegisterVC") as! RegisterVC
        self.navigationController?.pushViewController(vc, animated: true)
//        self.present(vc, animated: true, completion: nil)

    }
    @objc func searchButtonAction(_ sender : UIBarButtonItem!){
        print("search")
        let vc = storyboard?.instantiateViewController(withIdentifier: "SearchViewController") as! SearchViewController
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
        
        if ( sender.tag == 0 ){ makeMarkerView(initData) }
        else {
            filterdData = initData.filter { (element) -> Bool in
                return gino(element.location_type) == sender.tag
            }
            makeMarkerView(filterdData)
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
    
    func makeMarkerView(_ data : [TestModel]) {
        
        mapView.clear()
        // make marker objects
        for i in 0..<data.count{
            let marker = GMSMarker()
            let position = CLLocationCoordinate2D(latitude: CLLocationDegrees(gfno(data[i].latitude)), longitude: CLLocationDegrees(gfno(data[i].longitude)))

            switch gino(data[i].location_type) {
            case 1:
                marker.icon = UIImage(named: "icMapCat");
                let circleCenter = position
                let circ = GMSCircle(position: circleCenter, radius: 100)
                circ.fillColor = UIColor(red: 242/255, green: 145/255, blue: 145/255, alpha: 0.2)
                circ.strokeColor = .none
                circ.map = mapView
                break
            case 2:
                marker.icon = UIImage(named: "icMapFood"); break
            case 3:
                marker.icon = UIImage(named: "icMapHospital"); break
            default:
                marker.icon = UIImage(named: "icMapHospital"); break

            }
            marker.position = position
            marker.title = "\(gino(data[i].location_type))"; marker.snippet = "name"
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
        return myLocation.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return myLocation[row]
        
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        locationButton.text = myLocation[row]
    }
    //  -----------------------------  GMSMapViewDelegate function ----------------------------
    func mapView(_ mapView: GMSMapView, didCloseInfoWindowOf marker: GMSMarker) {
        print("end")
        detailViewHidden(true)
    }
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        if ( !detailViewCreated ) {
            detailViewCreated = true
            detailView = UIView()
            detailView.backgroundColor = UIColor.black
            self.view.addSubview(detailView)
            detailView.snp.makeConstraints { (make) in
                make.left.equalTo(self.view.snp.left).offset(15)
                make.right.equalTo(self.view.snp.right).offset(-15)
                make.height.equalTo(140)
                make.bottom.equalTo(self.view.snp.bottom).offset(-57)
            }
            
            let detailContents = DetailView(frame: detailView.frame)
            //
            detailContents.modifyButton.addTarget(self, action: #selector(viewActionSheet), for: .touchUpInside)
            //
            self.detailView.addSubview(detailContents)
            detailContents.snp.makeConstraints { (make) in
                make.left.equalTo(self.detailView.snp.left)
                make.right.equalTo(self.detailView.snp.right)
                make.bottom.equalTo(self.detailView.snp.bottom)
                make.top.equalTo(self.detailView.snp.top)

            }
//            detailContents.modifyButton.addTarget(self, action: #selector(modifyRequestAction(_:)), for: .touchUpInside)
//            detailView.addSubview(detailContents)
//            detailImageView = UIImageView()
//            detailImageView.backgroundColor = UIColor.green
//            detailTextView =
            
            detailView.tag = 0
//            detailView.
            
            
        } else {
            detailView.tag += 1
            detailViewHeight += (Int.random(in: 0..<2) * 20) - 10
            UIView.animate(withDuration: 0.3) {
                
                self.detailView.snp.updateConstraints { (make) in
                    make.height.equalTo(self.detailViewHeight)
                }
                self.view.layoutIfNeeded()
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
        } else {
            initData = datas as! [TestModel]
            makeMarkerView(initData)

        }
    }
}
