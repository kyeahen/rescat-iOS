//
//  RegisterVC3.swift
//  rescat
//
//  Created by jigeonho on 04/01/2019.
//  Copyright © 2019 kyeahen. All rights reserved.
//

import Foundation
import UIKit
import GoogleMaps
class RegisterVC3 : UIViewController, APIServiceCallback, GMSMapViewDelegate {
    @IBOutlet weak var dataImageView: UIImageView!
    @IBOutlet var mapView : GMSMapView!
    @IBOutlet var mylocationButton : UIButton!
    @IBOutlet var registerButton : UIButton!
    @IBOutlet var outerView : UIView!

    var requestMap : MapRequest!
    var requestAddress : NaverMapRequest!
    var registerMap : MapRequestModel = MapRequestModel()
    var lat = 0.0 ; var lng = 0.0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        requestMap = MapRequest(self)
        requestAddress = NaverMapRequest(self)
        
        outerView.drawShadow(10.0)
        outerView.roundCorner(15.0)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.mapView.delegate = self
        guard let regions = UserDefaults.standard.array(forKey: "regions") as? [String] else { return }

        requestAddress.requestGeocoder(regions[0])

    }
    func loadMapView(latitude : Double, longitude : Double, zoom : Float){
        let camera = GMSCameraPosition.camera(withLatitude: latitude, longitude: longitude, zoom: zoom)
        self.mapView.camera = camera
        
    }

    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        print("coordinate \(coordinate.latitude) \(coordinate.longitude)")
        lat = Double(coordinate.latitude) ; lng = Double(coordinate.longitude)
        mapView.clear()

        registerButton.isHidden = false
        let position = CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude)

        
        self.mapView.animate(toLocation: position)

        let marker = GMSMarker()

        marker.icon = UIImage(named: "icMapCat");
        let circleCenter = position
        let circ = GMSCircle(position: circleCenter, radius: 100)
        circ.fillColor = UIColor(red: 242/255, green: 145/255, blue: 145/255, alpha: 0.2)
        circ.strokeColor = .none
        circ.map = mapView
        marker.position = position
        marker.title = "여기?"
        marker.snippet = "name"
        marker.map = mapView


    }
   
    @IBAction func gotoMyLocation( _ sender : UIButton!){
        self.simpleAlert(title: "alert", message: "내위치 이동")
    }
    
    @IBAction func registerImage( _ sender : UIButton!) {
        
    
        registerMap.lat = lat ; registerMap.lng = lng
        requestAddress.requestReverseGeocoder(lat, lng)

//        request.addPhoto(dataImageView)
//        var datas = [Data]()
//        for i in 0..<5 {
//            guard let  data = dataImageView.image?.jpegData(compressionQuality: 1.0) else { return }
//            datas.append(data)
//
//        }
//        PhotoRequest.uploadPhotos(datas)
//        for i in 0..<5{
//            var m : MapRequestModel = MapRequestModel()
//
//            m.requestType = 0
//            m.registerType = 0
//            let lat = Double.random(lower: 37.04149, 127.020924)
//            let long = Double.random(lower: 127.020924, 127.040959)
//            m.lat = lat; m.lng = long
//            m.radius = 3 ; m.sex = 0 ; m.age = "10개월"
//            m.regionFullName = "서울특별시 강남구 논현1동"
//            m.name = "피어캣"
//            m.photoUrl = "https://s3.ap-northeast-2.amazonaws.com/rescat/ggu.jpg"
//
//            requestMap.addMapData(m)
//        }



        // go to home

        
    }
    func requestCallback(_ datas: Any, _ code: Int) {
     
        if ( code == APIServiceCode.REVERSE_GEOCODE) {
            let string = datas as! String
            print("지도 \(string)")
//            requestMap
            registerMap.regionFullName = string
            registerMap.radius = 3
            requestMap.addMapData(registerMap)
        } else if ( code == APIServiceCode.MARKER_POST ) {
            self.simpleAlertwithHandler(title: "등록요청 완료", message: "24시간 내에 관리자 승인 후, 등록 결과가 마이페이지 > 우체통으로 전달됩니다.") { (UIAlertAction) in
                self.performSegue(withIdentifier: "unWindToMain", sender: nil)

            }

        } else if ( code == APIServiceCode.GEOCODE ){
            
            let data = datas as! String
            
            print("지도 geocode 결과 \(data)")
            
            let coordinate = data.split(separator: " ")
            loadMapView(latitude: gdno(Double(coordinate[0])), longitude: gdno(Double(coordinate[1])), zoom: 15.0)

            
        }
    }
    
}
