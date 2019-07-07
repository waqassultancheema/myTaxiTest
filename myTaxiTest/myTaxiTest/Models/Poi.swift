//
//  Poi.swift
//  myTaxiTest
//
//  Created by Waqas Sultan on 6/30/19.
//  Copyright © 2019 Waqas Sultan. All rights reserved.
//

import Foundation

 @objc class Poi:NSObject, Codable {
  @objc  let id: Int
   @objc let coordinate: Coordinate
   @objc let fleetType: String
  @objc  let heading: Double
    
    init(id: Int, coordinate: Coordinate, fleetType: String, heading: Double) {
        self.id = id
        self.coordinate = coordinate
        self.fleetType = fleetType
        self.heading = heading
    }
}

// MARK: Poi convenience initializers and mutators

extension Poi {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Poi.self, from: data)
        self.init(id: me.id, coordinate: me.coordinate, fleetType: me.fleetType, heading: me.heading)
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
        id: Int? = nil,
        coordinate: Coordinate? = nil,
        fleetType: String? = nil,
        heading: Double? = nil
        ) -> Poi {
        return Poi(
            id: id ?? self.id,
            coordinate: coordinate ?? self.coordinate,
            fleetType: fleetType ?? self.fleetType,
            heading: heading ?? self.heading
        )
    }
    
    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}
