//
//  PoiMapViewController.swift
//  myTaxiTest
//
//  Created by Waqas Sultan on 6/30/19.
//  Copyright © 2019 Waqas Sultan. All rights reserved.
//

import UIKit
import MapKit
class PoiMapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var collectionView: PoiCollectionView!
    var viewModel = PoiListViewModel()
    private var mapChangedFromUserInteraction = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewModel()
        configureMap()
        // Do any additional setup after loading the view.
    }
    
    func configureViewModel() {
        viewModel.getPoiList(boudingBox: BoundingBox.hamburgBoundingBox, type: .Map)
        
        viewModel.reloadTableViewClosure =  { [weak self] (viewModelList) in
            if self?.collectionView.dataItems == nil {
                self?.collectionView.dataItems = NSMutableArray()
            }
            self?.collectionView.dataItems.removeAllObjects()
                DispatchQueue.main.async {
                    self?.mapView.removeAnnotations((self?.mapView.annotations)!)
                    for viewModel in viewModelList {
                        self?.collectionView.dataItems.add(viewModel)
                        let artwork = Artwork(title: viewModel.fleetType,
                                              coordinate: CLLocationCoordinate2D(latitude: viewModel.latitude, longitude: viewModel.longitude))
                        self?.mapView.addAnnotation(artwork)
                    }
                    self?.collectionView.reloadData()
                    self?.mapView.fitMapViewToAnnotaionList()
                }
        }
        
        viewModel.showAlertClosure = { (error) in
            
        }
    }
    
    func configureMap() {
        let initialLocation = CLLocation(latitude: 53.694865, longitude:  9.757589 )
        centerMapOnLocation(location: initialLocation)
        mapView.delegate = self
    }
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate,
                                                  latitudinalMeters: AppConstants.regionRadius, longitudinalMeters: AppConstants.regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }

    
    private func mapViewRegionDidChangeFromUserInteraction() -> Bool {
        let view = self.mapView.subviews[0]
        //  Look through gesture recognizers to determine whether this region change is from user interaction
        if let gestureRecognizers = view.gestureRecognizers {
            for recognizer in gestureRecognizers {
                if( recognizer.state == UIGestureRecognizer.State.began || recognizer.state == UIGestureRecognizer.State.ended ) {
                    return true
                }
            }
        }
        return false
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}





extension PoiMapViewController : MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        // Leave default annotation for user location
        if annotation is MKUserLocation {
            return nil
        }
        
        let reuseID = "Location"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseID)
        if annotationView == nil {
            let pin = MKAnnotationView(annotation: annotation,
                                       reuseIdentifier: reuseID)
            pin.image = UIImage(named: "taxi_map")
            pin.isEnabled = true
            pin.canShowCallout = true
            
            annotationView = pin
        } else {
            annotationView?.annotation = annotation
        }

        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, regionWillChangeAnimated animated: Bool) {
        mapChangedFromUserInteraction = mapViewRegionDidChangeFromUserInteraction()
        if (mapChangedFromUserInteraction) {

        }
    }
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        if (mapChangedFromUserInteraction) {
            let boundingBox = BoundingBox(rect: mapView.visibleMapRect)
            viewModel.getPoiList(boudingBox: boundingBox, type: .Map)

            
        }
    }
    
}
