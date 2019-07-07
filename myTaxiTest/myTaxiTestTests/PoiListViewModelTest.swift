//
//  PoiListViewModelTest.swift
//  myTaxiTestTests
//
//  Created by Waqas Sultan on 7/2/19.
//  Copyright © 2019 Waqas Sultan. All rights reserved.
//

import XCTest
@testable import myTaxiTest
class PoiListViewModelTest: XCTestCase {

    var stubPoiList : [Poi]!
    var stubPoiRepo : StubPoiRepository!
    var sut : PoiListViewModel!
    override func setUp() {
        super.setUp()
        sut = PoiListViewModel()
        stubPoiRepo = StubPoiRepository()

        loadStubPoiList()
        
        sut.repo = stubPoiRepo

        
    }
    func loadStubPoiList() {
        let data = loadJSONFromBundle(withName: "PoiList", extension: "json")
        do {
            let metaData = try MetaData(data: data)
            stubPoiList = metaData.poiList
            stubPoiRepo.dataToReturntoSuccess = stubPoiList

        } catch  {
        }

    }
    
    override func tearDown() {
        stubPoiRepo = nil
        sut = nil
        super.tearDown()
    }
    
    func testFetchPoiListCalled() {
        
        sut.getPoiList(boudingBox: BoundingBox.hamburgBoundingBox, type: .Map)
        XCTAssert(stubPoiRepo.isFetchPoiListCalled)
    }
    
    func testFetchPoiListSucess() {
        let expect = XCTestExpectation(description: "wait for reload Closure")
        var list:Array = Array<PoiListItemViewModel>()
        sut.reloadTableViewClosure = { (poiList) in
            list = poiList
            expect.fulfill()
        }
        sut.getPoiList(boudingBox: BoundingBox.hamburgBoundingBox, type: .Map)
        stubPoiRepo.fetchSuccess()
        
        XCTAssert(list.count > 0 )
        wait(for: [expect], timeout: 1.0)
        
    }
    
    func testFetchPoiListFail() {
        stubPoiRepo.shouldFailOnFetch = true
        let expect = XCTestExpectation(description: "wait for error Closure")
        var errorMSG = ""
        sut.showAlertClosure = { (error) in
            errorMSG = error
            expect.fulfill()
        }
        sut.getPoiList(boudingBox: BoundingBox.hamburgBoundingBox, type: .Map)
        stubPoiRepo.fetchFail(error: NetworkError.noNetwork)
        XCTAssertNotEqual(errorMSG, "")
        wait(for: [expect], timeout: 1.0)

    }
    
    func testPoiListViewModel() {
        
        let stubPoi = stubPoiList.first!
        let viewModel = PoiListItemViewModel(fleetType: stubPoi.fleetType, latitude: stubPoi.coordinate.latitude, longitude: stubPoi.coordinate.longitude, imageName: "mainImage")
        
        XCTAssertEqual(viewModel.fleetType, stubPoi.fleetType)
        XCTAssertEqual(viewModel.latitude, stubPoi.coordinate.latitude)
        XCTAssertEqual(viewModel.longitude, stubPoi.coordinate.longitude)

    }
}
