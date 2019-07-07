//
//  PoiRepository.swift
//  myTaxiTest
//
//  Created by Waqas Sultan on 6/30/19.
//  Copyright © 2019 Waqas Sultan. All rights reserved.
//

import Foundation
enum PoiListEndPoint {
    case getRegion(boudingBox:BoundingBox)
    
    static func setEndPoint(type: ListType,boundingBox:BoundingBox?) -> PoiListEndPoint {
        var endPoint: PoiListEndPoint
        switch type {
        case .Map:
            endPoint =  .getRegion(boudingBox: boundingBox!)
                
        }
        return endPoint
    }
    var endPoint : String {
        
        switch self {            
        case .getRegion(let boudingBox):
            return boudingBox.itemsINJSON
        }
    }
}

class PoiRepository {
    
    
    func fetchPoiLists(boundingBox:BoundingBox? ,type: ListType, complete :@escaping ([Poi]) -> Void, failure:@escaping (String?) -> Void) {
        let endPoint = PoiListEndPoint.setEndPoint(type: type,boundingBox: boundingBox)
        let url = AppConstants.baseUrl + endPoint.endPoint
        ServiceApi.shared.getData(url: url, withMethod: nil, headers: nil) {  (response, error) in
            guard error == nil else {
                failure(error?.localizedDescription)
                return
            }
            
            if let mData = response as? Data {
                do {
                    let metaData = try MetaData(data: mData)
                    complete(metaData.poiList)
                } catch  {
                    failure(error.localizedDescription)
                }
            }
        }
    }
    
    
}


