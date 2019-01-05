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
    override func viewDidLoad() {
        super.viewDidLoad()
        outerView.drawShadow(10.0)
        outerView.roundCorner(30.0)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.mapView.delegate = self
        loadMapView(latitude: 37.498197, longitude: 127.027610, zoom: 15.0)

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
    func requestCallback(_ datas: Any, _ code: Int) {
        
    }
    @IBAction func gotoMyLocation( _ sender : UIButton!){
        
    }
    
    @IBAction func registerImage( _ sender : UIButton!) {
        
        let request = MapRequest(self)

//        request.addPhoto(dataImageView)
        let data = dataImageView.image?.jpegData(compressionQuality: 1.0)
//        request.addPhoto(data!)
        var m : MapRequestModel = MapRequestModel()

        m.requestType = 0;
        m.registerType = 2;
        m.name = "피어캣"
//        m.etc = "etc"
        m.lat = 37.0001 ;
        m.lng = 127.00001 ;
        m.address = "asd";
        m.phone = "010-3676-2713"
        m.radius = 0
        m.sex = 0
        m.age = "10"
        m.phtoUrl = nil
        m.regionFullName = "서울특별시 서초구 서초3동"

        request.addMapData(m)

        self.performSegue(withIdentifier: "unWindToMain", sender: nil)
        // go to home

        
    }
    
}
