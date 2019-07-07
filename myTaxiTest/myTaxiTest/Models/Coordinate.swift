//
//  Coordinate.swift
//  myTaxiTest
//
//  Created by Waqas Sultan on 6/30/19.
//  Copyright © 2019 Waqas Sultan. All rights reserved.
//

import Foundation

@objc class Coordinate:NSObject, Codable {
    @objc let latitude, longitude: Double
    
    init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
}

// MARK: Coordinate convenience initializers and mutators

extension Coordinate {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Coordinate.self, from: data)
        self.init(latitude: me.latitude, longitude: me.longitude)
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
        latitude: Double? = nil,
        longitude: Double? = nil
        ) -> Coordinate {
        return Coordinate(
            latitude: latitude ?? self.latitude,
            longitude: longitude ?? self.longitude
        )
    }
    
    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}
