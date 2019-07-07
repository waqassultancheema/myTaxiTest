//
//  PoiStubRepository.swift
//  myTaxiTestTests
//
//  Created by Waqas Sultan on 7/2/19.
//  Copyright © 2019 Waqas Sultan. All rights reserved.
//

@testable import myTaxiTest
class StubPoiRepository: PoiRepository {

    var dataToReturntoSuccess:[Poi]?
    var shouldFailOnFetch:Bool = false
    
    var isFetchPoiListCalled = false
    
    var completeClosure: (([Poi]) -> Void)!
    var failureClosure: ((String?) -> Void)!

    override func fetchPoiLists(boundingBox:BoundingBox? ,type: ListType, complete :@escaping ([Poi]) -> Void, failure:@escaping (String?) -> Void) {
       
        isFetchPoiListCalled = true
        if shouldFailOnFetch {
            failureClosure = failure
        } else {
            completeClosure = complete
        }
    }
    
    func fetchSuccess() {
        if let data = dataToReturntoSuccess {
            completeClosure(data)
        } else {
            failureClosure(NetworkError.other("Dummy data not assigned").localizedDescription)
            
        }
    }
    
    func fetchFail(error:NetworkError)  {
        failureClosure(error.localizedDescription)
    }

    
}
