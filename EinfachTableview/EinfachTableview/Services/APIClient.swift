//
//  APIClient.swift
//  EinfachTableview
//
//  Created by Marwen Doukh on 2/9/19.
//  Copyright © 2019 Marwen Doukh. All rights reserved.
//

import UIKit

class APIClient<T: Codable> {
    
    
    func execute(request: URLRequest, completion: @escaping (T?) -> Void) {
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            guard error == nil else {
                debugPrint("error: \(error.debugDescription)")
                completion(nil)
                return
            }
            
            guard let data = data else {
                debugPrint("no data")
                completion(nil)
                return
            }
            
            guard let object = try? JSONDecoder().decode(T.self, from: data) else {
                debugPrint("Could not decode data")
                return
            }
            // completion object
            completion(object)
            }.resume()
    }
    
}
