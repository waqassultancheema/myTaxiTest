//
//  ServiceApi.swift
//  myTaxiTest
//
//  Created by Waqas Sultan on 6/30/19.
//  Copyright © 2019 Waqas Sultan. All rights reserved.
//

import Foundation



public class ServiceApi:WebAPIHandler {
    
    
    static let shared = ServiceApi()
    let cache = LRUCache<String,Data>(capacity: 3)
    var task: URLSessionTask!
    
    func getDataFromServer(url: String, withMethod method: URLMethod?, headers: [String : String]?, completion: @escaping onCompletion) -> URLSessionTask? {
        
        guard Reachability.isConnectedToNetwork() else {
            completion(nil, NetworkError.noNetwork)
            return nil
        }
        
        let urlString = url.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) ?? ""
        
        
        if let urL = URL(string: urlString) {
            var request = URLRequest(url: urL)
            if let method = method {
                request.httpMethod = method.rawValue
            }
            
            if let headers = headers {
                for header in headers {
                    request.addValue(header.value, forHTTPHeaderField: header.key)
                }
            }
            let session = URLSession.shared
            let task = session.dataTask(with: request) { (data, response, error) -> Void in
                ParserURLResponse.parseURLResponse(response: response, data: data, completion: completion,error: error)
            }
            task.resume()
            return task
        }
        return nil
    }
    
    
   
    
    func getData(url: String, withMethod method: URLMethod?, headers: [String: String]?,completion: @escaping onCompletion) {
        
        if let response = cache.getValue(for: url) {
            completion(response, nil)
        } else {
          task =   getDataFromServer(url: url, withMethod: method, headers: headers) { [unowned self] (data, error) in
                
                
                guard error == nil else {
                    completion(nil,error)
                    return
                }
                self.cache.setValue(data as! Data, for: url)
                completion(data,error)
            }
            
        }
        
    }
    
    func cancelRequest() {
        self.task.cancel()
    }
    
    
}
