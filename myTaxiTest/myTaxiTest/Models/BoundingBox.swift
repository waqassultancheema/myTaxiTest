//
//  BoundingBox.swift
//  myTaxiTest
//
//  Created by Waqas Sultan on 7/1/19.
//  Copyright © 2019 Waqas Sultan. All rights reserved.
//

import UIKit
import MapKit
struct BoundingBox {
    let topRight: CLLocationCoordinate2D
    let topLeft: CLLocationCoordinate2D
    let bottomRight: CLLocationCoordinate2D
    let bottomLeft: CLLocationCoordinate2D
    
    init(rect: MKMapRect) {
        topRight = MKMapPoint(x: rect.maxX, y: rect.origin.y).coordinate
        topLeft = MKMapPoint(x: rect.origin.x, y: rect.origin.y).coordinate
        bottomRight = MKMapPoint(x: rect.maxX, y: rect.maxY).coordinate
        bottomLeft = MKMapPoint(x: rect.origin.x, y: rect.maxY).coordinate
    }
    
    var items: [String: CLLocationCoordinate2D] {
        return [
            "topRight": topRight,
            "topLeft": topLeft,
            "bottomRight": bottomRight,
            "bottomLeft": bottomLeft,
        ]
    }
    
    var itemsINJSON: String {
        
        var index = 0
        var pointIndex =  1
        var append = ""
        for item in northWestAndSouthWest {
            if index % 2 == 0 {
                append = append + "p\(pointIndex)Lat=\(item)&"
            } else {
                append = append + "p\(pointIndex)Lon=\(item)&"
                pointIndex = pointIndex + 1
            }
            index = index + 1
            
        }
        return append
        
        //"p1Lat=\(self.topRight.latitude)&p1Lon=\(self.topRight.longitude)&p2Lat=\(self.topLeft.latitude)&p2Lon=\(self.topLeft.longitude)&p3Lat=\(self.bottomRight.latitude)&p3Lon=\(self.bottomRight.longitude)&p4Lat=\(self.bottomLeft.latitude)&p4Lon=\(self.bottomLeft.longitude)"
    }
   static  var hamburgBoundingBox:BoundingBox {
        
        let coordinate1:CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 53.694865, longitude: 9.757589)
        let coordinate2:CLLocationCoordinate2D =  CLLocationCoordinate2D(latitude: 53.394655, longitude: 10.099891)
        let rect = MKMapRect(coordinates: [coordinate1,coordinate2])
        
        return BoundingBox(rect: rect)
    }
    var northWestAndSouthWest: [CLLocationDegrees] {
        return [
            topRight.latitude,
            topRight.longitude,
            bottomLeft.latitude,
            bottomLeft.longitude,
        ]
    }
    var points: [CLLocationDegrees] {
        return [
            topRight.latitude,
            topRight.longitude,
            topLeft.latitude,
            topLeft.longitude,
            bottomRight.latitude,
            bottomRight.longitude,
            bottomLeft.latitude,
            bottomLeft.longitude,
        ]
    }
}
