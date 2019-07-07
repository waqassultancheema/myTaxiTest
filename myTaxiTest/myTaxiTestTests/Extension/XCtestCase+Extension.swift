//
//  XCtestCase+Extension.swift
//  myTaxiTestTests
//
//  Created by Waqas Sultan on 7/2/19.
//  Copyright © 2019 Waqas Sultan. All rights reserved.
//

import XCTest

extension XCTestCase {
    
    // MARK: - Helper Methods
    
    func loadJSONFromBundle(withName name: String, extension: String) ->  Data{
        let bundle = Bundle(for: classForCoder)
        let url = bundle.url(forResource: name, withExtension: `extension`)
        
        let data = try! Data(contentsOf: url!)
        return data
        
    }
    
}
