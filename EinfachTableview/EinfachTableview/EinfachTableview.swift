//
//  EinfachTV.swift
//  EinfachTableview
//
//  Created by Marwen Doukh on 2/9/19.
//  Copyright © 2019 Marwen Doukh. All rights reserved.
//

import UIKit

protocol EinfachTVDelegate: class {
    func cellForRowAt(_ tableView: UITableView, cellForRowAt indexPath: IndexPath, model: Codable) -> UITableViewCell
    func doneCallingWs()
}


class EinfachTableview<T: Codable>: NSObject, UITableViewDelegate, UITableViewDataSource  {
    
    // list of items (from WS)
    var items: [Codable] = []
    // delegate
    var einfachTVDelegate: EinfachTVDelegate?
   
    
    func loadData(url: String) {
        
        let ws = APIClient<T>()
        if let url = URL(string: url) {
            let request = URLRequest(url: url)
            ws.execute(request: request) { (itemsFromWs) in
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = einfachTVDelegate?.cellForRowAt(tableView, cellForRowAt: indexPath, model: items[indexPath.row])
        return cell ?? UITableViewCell()
    }
}
