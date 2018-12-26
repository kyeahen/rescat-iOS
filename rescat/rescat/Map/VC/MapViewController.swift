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
class MapViewController: UIViewController, GMSMapViewDelegate, UISearchBarDelegate, APIServiceCallback {
    

    @IBOutlet var mapView : GMSMapView!
    @IBOutlet var searchbar : UISearchBar!
    
    @IBOutlet var button1 : UIButton!
    @IBOutlet var button2 : UIButton!
    @IBOutlet var button3 : UIButton!
    @IBOutlet var button4 : UIButton!
    var buttons = [UIButton]()
    var floatingButton : UIButton!
    
    
    var detailViewHeight = 200   // temp value
    var detailViewCreated = false
    var detailView : UIView!; var detailImageView : UIImageView!; var detailNameView : UILabel!
    var detailBirthView : UILabel!; var detailPropertyView : UILabel!; var detailTextView : UILabel!
    
    var initData : [TestModel] = []
    var filterdData : [TestModel] = []
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        buttons.append(button1); buttons.append(button2); buttons.append(button3); buttons.append(button4);
        for (index, element) in buttons.enumerated() {
            element.addTarget(self, action: #selector(filterButton), for: .touchUpInside)
            element.tag = index
        }
        
        floatingButton = UIButton()
        floatingButton.backgroundColor = UIColor.blue
        floatingButton.setTitle("+", for: .normal)
        floatingButton.addTarget(self, action: #selector(registerButton), for: .touchUpInside)
        self.view.addSubview(floatingButton)
        floatingButton.snp.makeConstraints { (make) in
            make.height.equalTo(50); make.width.equalTo(50);
            make.right.equalTo(self.view.snp.right).offset(-15)
            make.bottom.equalTo(self.view.snp.bottom).offset(-15)
        }
        
        //  내 도시로 focus
        let camera = GMSCameraPosition.camera(withLatitude: 37.498197, longitude: 127.027610, zoom: 13.0)
        self.mapView.camera = camera
      
        self.mapView.delegate = self
        self.searchbar.delegate = self

        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // get datas from server
        let request = Test(self)
        request.testRequest()
    }
    
    // hide detailView && appear floating button
    func detailViewHidden(_ isHidden : Bool){
        if ( isHidden ) {
            UIView.animate(withDuration: 0.15, animations: {
                if (self.detailViewCreated) { self.detailView.alpha = 0.0 }
            }) { (_) in UIView.animate(withDuration: 0.15, animations: {
                self.floatingButton.alpha = 1.0
            })}
            
        } else {
            UIView.animate(withDuration: 0.15, animations: {
                self.floatingButton.alpha = 0.0
            }) { (_) in UIView.animate(withDuration: 0.15, animations: {
                self.detailView.alpha = 1.0
            })}
        }
    }
    @objc func registerButton(_ sender : UIButton!) {
        print("register")
//        let view = DetailView(frame: self.view.frame)
//        self.view.addSubview(view)
        let mapstoryboard = UIStoryboard(name: "Map", bundle: nil)
        let vc = mapstoryboard.instantiateViewController(withIdentifier: "RegisterVC") as! RegisterVC
        self.present(vc, animated: true, completion: nil)

    }

    @objc func filterButton(_ sender : UIButton!){
        
        buttons.forEach { (button) in  button.backgroundColor = UIColor.gray }
        sender.backgroundColor = UIColor.blue
        
        detailViewHidden(true)
        
        if ( sender.tag == 0 ){ makeMarkerView(initData) }
        else {
            filterdData = initData.filter { (element) -> Bool in
                return gino(element.location_type) == sender.tag
            }
            makeMarkerView(filterdData)
        }
    }

    func makeMarkerView(_ data : [TestModel]) {
        
        mapView.clear()
        // make marker objects
        for i in 0..<data.count{
            let marker = GMSMarker()
            marker.position = CLLocationCoordinate2D(latitude: CLLocationDegrees(gfno(data[i].latitude)), longitude: CLLocationDegrees(gfno(data[i].longitude)))
            marker.title = "\(gino(data[i].location_type))"; marker.snippet = "name";
            marker.map = mapView
        }
       
    }
    // -----------------------------  UISearchBarDelegate function ----------------------------
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        detailViewHidden(true)
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchbar.resignFirstResponder()
    }
    //  -----------------------------  GMSMapViewDelegate function ----------------------------
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        if ( !detailViewCreated ) {
            detailViewCreated = true
            detailView = UIView()
            detailView.backgroundColor = UIColor.black
            self.view.addSubview(detailView)
            detailView.snp.makeConstraints { (make) in
                make.left.equalTo(self.view.snp.left).offset(15)
                make.right.equalTo(self.view.snp.right).offset(-15)
                make.height.equalTo(detailViewHeight)
                make.bottom.equalTo(self.view.snp.bottom).offset(-80)
            }
            
            let detailContents = DetailView(frame: detailView.frame)
            self.detailView.addSubview(detailContents)
            detailContents.snp.makeConstraints { (make) in
                make.left.equalTo(self.detailView.snp.left)
                make.right.equalTo(self.detailView.snp.right)
                make.bottom.equalTo(self.detailView.snp.bottom)
                make.top.equalTo(self.detailView.snp.top)

            }
//            detailView.addSubview(detailContents)
//            detailImageView = UIImageView()
//            detailImageView.backgroundColor = UIColor.green
//            detailTextView =
            
            detailView.tag = 0
            
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
    func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
        // zoom in & out
    }

}
extension MapViewController{
    // network call back
    func requestCallback(_ data : Any) {
        initData = data as! [TestModel]
        makeMarkerView(initData)
    }
}
