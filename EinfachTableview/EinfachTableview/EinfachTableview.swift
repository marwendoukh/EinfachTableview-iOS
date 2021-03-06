//
//  EinfachTV.swift
//  EinfachTableview
//
//  Created by Marwen Doukh on 2/9/19.
//  Copyright © 2019 Marwen Doukh. All rights reserved.
//

import UIKit
import Reachability
import RealmSwift

class EinfachTableview<T: Codable, RO: Object>: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: Vars
    
    // list of items (from WS or local storage)
    var items: [Codable] = []
    // delegate
    weak var einfachTVDelegate: EinfachTableviewDelegate?
    
    // local storage mode
    var localStorageMode: EinfachTableviewStorageMode = .none
    
    // Realm DB version
    var realmDbVersion: UInt64 = 1
    
    // Update old saved Realm objects
    var updateRealmObjects: Bool = true
    
    // MARK: Public Func
    
    func loadData(url: String, header: [String: String]? = nil) {
        
        // check for Internet
        if Reachability()?.connection.hashValue == 0 {
            if localStorageMode == .none {
                // online mode only --> return error
                einfachTVDelegate?.terminatedWithError(error: .noInternet, description: "No Internet Connection")
                return
                
            } else {
                // offline mode
                loadDataFromLocalStorage()
                
            }
            
        } else {
            // Internet is availabe
            
            // api client
            let apiClient = APIClient<T>()
            
            if let url = URL(string: url) {
                var request = URLRequest(url: url)
                // request header
                request.allHTTPHeaderFields = header
                
                // execute WS
                apiClient.execute(request: request) { (itemsFromWs, error) in
                    
                    // check for errors
                    guard error == nil else {
                        self.einfachTVDelegate?.terminatedWithError(error: error ?? .errorWsResponse,
                                                                    description: error.debugDescription)
                        return
                    }
                    
                    // check if WS returns an array
                    if let items = itemsFromWs as? [Codable] {
                        self.items = items
                        
                        // ask the viewController to manually decode the Model returned from the WS
                    } else if let decodedManuallyObject = self.einfachTVDelegate?.manuallyDecode(object: itemsFromWs) {
                        self.items = decodedManuallyObject
                    }
                    
                    DispatchQueue.main.async {
                        
                        // check if offline mode is active
                        if self.localStorageMode != .none {
                            self.saveDataLocally()
                        }
                        self.einfachTVDelegate?.doneCallingWs()
                    }
                    
                }
                
            }
        }
    }
    
    // MARK: Tableview Delegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = einfachTVDelegate?.cellForRowAt(tableView, cellForRowAt: indexPath, model: items[indexPath.row])
        return cell ?? UITableViewCell()
    }
    
    // MARK: Local Storage
    
    // save data to local storage
    func saveDataLocally() {
        switch localStorageMode {
        case .realm:
            if let items = items as? [Object] {
                let realmStorage = RealmDataStorage<RO>(updateRealmObject: updateRealmObjects,
                                                        realmSchemaVersion: realmDbVersion)
                realmStorage.save(items: items)
            } else {
                einfachTVDelegate?.terminatedWithError(error: .realmSavingFailed,
                                                       description: "Model does not inherit from Object Class")
            }
        case .none:
            break
            
        }
    }
    
    // load data from local storage
    func loadDataFromLocalStorage() {
        switch localStorageMode {
        case .realm:
            let realmStorage = RealmDataStorage<RO>(updateRealmObject: updateRealmObjects,
                                                    realmSchemaVersion: realmDbVersion)
            let array = realmStorage.loadData()
            self.items = array
        case .none:
            break
        }
    }
    
}
