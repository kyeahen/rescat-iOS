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
        let location = LocationUserDefaultService.getLocations().first
        guard let mainLocation = location else {
            loadMapView(latitude: 37.300, longitude: 127.027610, zoom: 15.0)
            return
        }
        
        loadMapView(latitude: gdno(mainLocation.first?.key), longitude: gdno(mainLocation.first?.value), zoom: 15.0)

    }
    func loadMapView(latitude : Double, longitude : Double, zoom : Float){
        let camera = GMSCameraPosition.camera(withLatitude: latitude, longitude: longitude, zoom: zoom)
        self.mapView.camera = camera
        
    }

    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        print("coordinate \(coordinate.latitude) \(coordinate.longitude)")
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
        
        let request = MapRequest(self)
        
        if gino(registerMap.registerType) == 1 {
            
        } else {
            
        }

//        request.addPhoto(dataImageView)
        let data = dataImageView.image?.jpegData(compressionQuality: 1.0)
//        request.addPhoto(data!)
        for i in 0..<5{
            var m : MapRequestModel = MapRequestModel()
           
            m.requestType = 0
            m.registerType = 0
            let lat = Double.random(lower: 37.04149, 127.020924)
            let long = Double.random(lower: 127.020924, 127.040959)
            m.lat = lat; m.lng = long
            m.radius = 3 ; m.sex = 0 ; m.age = "10개월"
            m.regionFullName = "서울특별시 강남구 논현1동"
            m.name = "피어캣"
            m.phtoUrl = "https://s3.ap-northeast-2.amazonaws.com/rescat/ggu.jpg"

            
            
            // ----------
//            m.requestType = 0
//            m.registerType = 1
//            let lat = Double.random(lower: 37.04149, 127.020924)
//            let long = Double.random(lower: 127.020924, 127.040959)
//            m.lat = lat; m.lng = long
//            m.radius = 3 ; m.sex = 0 ; m.age = "10개월"
//            m.regionFullName = "서울특별시 강남구 신사동"
//            m.name = "피어캣"
//            m.address = "everywhere"
//            m.phone = "010-3676-2713"
//            m.phtoUrl = "https://s3.ap-northeast-2.amazonaws.com/rescat/ggu.jpg"
         
            
            request.addMapData(m)
        }



        self.performSegue(withIdentifier: "unWindToMain", sender: nil)
        // go to home

        
    }
    func requestCallback(_ datas: Any, _ code: Int) {
     
        if ( code == APIServiceCode.GEOCODE) {
            
        }
    }
    
}
