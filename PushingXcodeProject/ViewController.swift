//
//  ViewController.swift
//  PushingXcodeProject
//
//  Created by Saahil Kaushal on 03/10/23.
//

import UIKit
import MapKit

class ViewController: UIViewController,MKMapViewDelegate {
    
    
    @IBOutlet weak var mapView: MKMapView!
    
    var locationManager:CLLocationManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        
        showRoute(CLLocationCoordinate2D(latitude: 30.7163, longitude: 76.7284),CLLocationCoordinate2D(latitude: 30.7180, longitude: 76.7147))
        
    }
    func showRoute(_ source:CLLocationCoordinate2D,_ destination:CLLocationCoordinate2D){
        
        let sourcePlacemark = MKPlacemark(coordinate: source,addressDictionary: nil)
        let destinationPlacemark = MKPlacemark(coordinate: destination, addressDictionary: nil)
        
        let sourceMapItem = MKMapItem(placemark: sourcePlacemark)
        let destinationMapItem = MKMapItem(placemark: destinationPlacemark)
        
        let directionRequest = MKDirections.Request()
        directionRequest.source = sourceMapItem
        directionRequest.destination = destinationMapItem
        directionRequest.transportType = .automobile
        
        let direction = MKDirections(request: directionRequest)
        
        direction.calculate { (response,error)->Void in
            guard let response = response else{
                if let error = error {
                    print("Error")
                }
                return
                
            }
            let route = response.routes[0]
            self.mapView.addOverlay((route.polyline),level:MKOverlayLevel.aboveRoads)
            
            let rect = route.polyline.boundingMapRect
            self.mapView.setRegion(MKCoordinateRegion(rect), animated: true)
        }
    }
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if overlay is MKPolyline {
            var polylineRender = MKPolylineRenderer(overlay: overlay)
            polylineRender.strokeColor = UIColor.blue
            polylineRender.lineWidth = 5
            return polylineRender
        }
        return MKPolygonRenderer()
    }

   
}

        
    




