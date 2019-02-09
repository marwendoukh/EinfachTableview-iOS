//
//  EinfachTV.swift
//  EinfachTableview
//
//  Created by Marwen Doukh on 2/9/19.
//  Copyright © 2019 Marwen Doukh. All rights reserved.
//

import UIKit
import Reachability

protocol EinfachTVDelegate: class {
    func cellForRowAt(_ tableView: UITableView, cellForRowAt indexPath: IndexPath, model: Codable) -> UITableViewCell
    func doneCallingWs()
    func terminatedWithError(error: EinfachTableviewError)
}

class EinfachTableview<T: Codable>: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    // list of items (from WS)
    var items: [Codable] = []
    // delegate
    weak var einfachTVDelegate: EinfachTVDelegate?
    
    func loadData(url: String) {
        
        // check for Internet
        guard Reachability()?.connection.hashValue != 0 else {
            einfachTVDelegate?.terminatedWithError(error: .noInternet)
            return
        }
        
        // api client
        let apiClient = APIClient<T>()
        
        if let url = URL(string: url) {
            let request = URLRequest(url: url)
            apiClient.execute(request: request) { (itemsFromWs, error) in
                
                // check for errors
                guard error == nil else {
                    self.einfachTVDelegate?.terminatedWithError(error: error ?? .errorWsResponse)
                    return
                }
                
                // check if WS returns an array
                if let items = itemsFromWs as? [Codable] {
                    self.items = items
                    DispatchQueue.main.async {
                        self.einfachTVDelegate?.doneCallingWs()
                    }
                    
                }
                
            }
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = einfachTVDelegate?.cellForRowAt(tableView, cellForRowAt: indexPath, model: items[indexPath.row])
        return cell ?? UITableViewCell()
    }
}
