//
//  ResponseParser.swift
//  myTaxiTest
//
//  Created by Waqas Sultan on 3/19/19.
//  Copyright © 2019 Waqas Sultan. All rights reserved.
//

import Foundation

protocol ParserServiceResponse {
    static func parseURLResponse(response: URLResponse?, data: Data?, completion: onCompletion,error:Error?)
}
struct Parsing {
    static let message = "Json Parsing Error"
    static let unKnown = "UnKnown Error occur, please try again"
    static let tokenError = "attempting to execute a request with an unauthorized token."
    static let noInternet = "Could not stablish connection to the Internet"
    static let operationCanceled = "this operation has been cancelled."
    static let operationTimeOut = "Operation timmed out."

}

class MyError: Codable {
    var status_message: String
    var status_code: Int
    
    private enum CodingKeys: String, CodingKey {
        case status_code = "code"
        case status_message = "message"
    }
}

struct ParserURLResponse:ParserServiceResponse {
    
    static func parseURLResponse(response: URLResponse?, data: Data?, completion: onCompletion,error:Error?) {
        if let httpResponse = response as? HTTPURLResponse {
            
            let code = httpResponse.statusCode
            if code == 200 {
                if data != nil {
                   completion(data, nil)
                } else {
                    completion(nil, NetworkError.unknown(Parsing.unKnown))
                }
                
            }
            else if code == 401 || code == 404 || code == 403 {
                let decoder = JSONDecoder()
                let mData = try? decoder.decode(MyError.self, from: data ?? Data())
                if let responseJSON = mData {
                    return completion(response, NetworkError.unknown(responseJSON.status_message))
                } else {
                    completion(nil, NetworkError.parsingError(Parsing.message))
                }
            } else if code == NSURLErrorTimedOut {
                completion(nil, NetworkError.parsingError(Parsing.operationTimeOut))
            } else if code == NSURLErrorNotConnectedToInternet {
                completion(nil, NetworkError.parsingError(Parsing.noInternet))
            } else if code == URLError.cancelled.rawValue {
                completion(nil, NetworkError.parsingError(Parsing.operationCanceled))
            } else {
                completion(nil, NetworkError.parsingError(Parsing.unKnown))
            }
        } else {
            completion(nil, NetworkError.other(error?.localizedDescription ?? Parsing.unKnown))
        }
    }
}
