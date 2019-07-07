//
//  PoiList.swift
//  myTaxiTest
//
//  Created by Waqas Sultan on 6/30/19.
//  Copyright © 2019 Waqas Sultan. All rights reserved.
//

import Foundation

// MARK: - MetaData
class MetaData: Codable {
    let poiList: [Poi]
    
    init(poiList: [Poi]) {
        self.poiList = poiList
    }
}

// MARK: MetaData convenience initializers and mutators

extension MetaData {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(MetaData.self, from: data)
        self.init(poiList: me.poiList)
    }
    
    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }
    
    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }
    
    func with(
        poiList: [Poi]? = nil
        ) -> MetaData {
        return MetaData(
            poiList: poiList ?? self.poiList
        )
    }
    
    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}
