//
//  PoiListViewModel.swift
//  myTaxiTest
//
//  Created by Waqas Sultan on 6/30/19.
//  Copyright © 2019 Waqas Sultan. All rights reserved.
//

import UIKit

enum ListType: Int {
    case Map
}

class PoiListViewModel {
    
  private  var dataItems:[Poi] = []  ///for cache
    var repo:PoiRepository = PoiRepository()
    
    private var cellViewModels: [PoiListItemViewModel] = [PoiListItemViewModel]() {
        didSet {
            self.reloadTableViewClosure?(cellViewModels)
        }
    }
    
    var alertMessage: String? {
        didSet {
            self.showAlertClosure?(alertMessage ?? "Some thing went wrong")
        }
    }
    var reloadTableViewClosure: (([PoiListItemViewModel])->())?
    var showAlertClosure: ((String)->())?
    var updateLoadingStatus: (()->())?
    
    func getPoiList(boudingBox:BoundingBox?,type:ListType) {
        
        repo.fetchPoiLists(boundingBox: boudingBox,type: type,complete: { [weak self] (poiList) in
            self?.convertFetchedPoiList(poiList: poiList)
        }) { (error) in
            self.alertMessage = error ?? "Some thing went wrong"
        }
    }
    
    func convertFetchedPoiList(poiList:[Poi]) {
        dataItems.removeAll()
        self.dataItems.append(contentsOf: poiList)
        var processedViewModelArray = [PoiListItemViewModel]()
        
        for item in poiList {
            let viewModel = PoiListItemViewModel(fleetType: item.fleetType, latitude: item.coordinate.latitude, longitude: item.coordinate.longitude,imageName: "mainImage")
            processedViewModelArray.append(viewModel)
        }
        
        
        self.cellViewModels = processedViewModelArray

    }
 

}


@objc class PoiListItemViewModel :NSObject {
   @objc let fleetType:String
    let latitude:Double
    let longitude:Double
   @objc let imageName:String
    
    
    init(fleetType:String,latitude:Double,longitude:Double,imageName:String) {
        self.fleetType = fleetType
        self.latitude = latitude
        self.longitude = longitude
        self.imageName = imageName
    }
}
