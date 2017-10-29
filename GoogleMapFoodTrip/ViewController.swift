//
//  ViewController.swift
//  GoogleMapFoodTrip
//
//  Created by SEAN on 2017/10/29.
//  Copyright © 2017年 SEAN. All rights reserved.
//

import UIKit
import GoogleMaps

class Location: NSObject{
    let name : String
    let location: CLLocationCoordinate2D
    let zoom: Float
    
    init(location: CLLocationCoordinate2D, zoom: Float, name: String) {
        self.location = location
        self.zoom = zoom
        self.name = name
    }
}

class GoogleMapController: UIViewController {
    var mapView: GMSMapView?
    var currentDestination: Location?
    let destinations = [Location(location: CLLocationCoordinate2D(latitude: 23.483747, longitude: 120.463141), zoom: 23, name: "嘉義公園米糕"), Location(location: CLLocationCoordinate2D(latitude: 23.478843, longitude: 120.450164), zoom: 17, name: "林聰明沙鍋魚頭")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isTranslucent = false
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "下一步", style: .plain, target: self, action: #selector(nextStep))
        navigationController?.navigationBar.tintColor = .white
        
        let camera = GMSCameraPosition.camera(withLatitude: 23.479911, longitude: 120.454081, zoom: 17)
        mapView = GMSMapView.map(withFrame: .zero, camera: camera)
        view = mapView
        
        let currentPosition = CLLocationCoordinate2D(latitude: 23.479911, longitude: 120.454081)
        let marker = GMSMarker()
        marker.position = currentPosition
        marker.title = "劉里長雞肉飯"
        marker.snippet = "嘉義必吃雞肉飯"
        marker.map = mapView
    }
    
    @objc func nextStep(){
        
        if currentDestination == nil{
            currentDestination = destinations.first
            
            setMapCamera()
            
        }else{
            if let index = destinations.index(where: {return $0 == currentDestination!}){
             
                currentDestination = destinations[index + 1]
                
                setMapCamera()
            }
        }
    }
    
    private func setMapCamera(){
        CATransaction.begin()
        CATransaction.setValue(2, forKey: kCATransactionAnimationDuration)
        
        mapView?.animate(to: GMSCameraPosition.camera(withTarget: currentDestination!.location, zoom: currentDestination!.zoom))
        
        CATransaction.commit()
        
        let marker = GMSMarker()
        marker.position = currentDestination!.location
        marker.title = currentDestination?.name
        marker.map = mapView
    }
    
  
}

