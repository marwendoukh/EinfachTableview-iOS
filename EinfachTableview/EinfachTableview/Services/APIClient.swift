//
//  APIClient.swift
//  EinfachTableview
//
//  Created by Marwen Doukh on 2/9/19.
//  Copyright © 2019 Marwen Doukh. All rights reserved.
//

import UIKit

class APIClient<T: Codable> {
    
    func execute(request: URLRequest, completion: @escaping (T?, EinfachTableviewError?) -> Void) {
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            
            guard error == nil else {
                debugPrint("error: \(error.debugDescription)")
                completion(nil, .errorWsResponse)
                return
            }
            
            guard let data = data else {
                debugPrint("no data")
                completion(nil, .noDataWsResponse)
                return
            }
            
            guard let object = try? JSONDecoder().decode(T.self, from: data) else {
                debugPrint("Could not decode data")
                completion(nil, .errorDataDecodingWsResponse)
                return
            }
            // completion object
            completion(object, nil)
            }.resume()
    }
    
}
