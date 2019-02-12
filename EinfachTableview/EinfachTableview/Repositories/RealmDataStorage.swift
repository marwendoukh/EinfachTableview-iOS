//
//  RealmDataStorage.swift
//  EinfachTableview
//
//  Created by Marwen Doukh on 10.02.19.
//  Copyright © 2019 Marwen Doukh. All rights reserved.
//

import RealmSwift

// swiftlint:disable force_try
struct RealmDataStorage<T: Object> {
    
    func save(items: [Object]) {
        let realm = try! Realm()
        try! realm.write {
            realm.add(items, update: true)
        }
    }
    
    func loadData() -> [Codable] {
        let realm = try! Realm()
        
        let array = realm.objects(T.self)
        // if the objects found in Realm DB are [Codable], then return them
        if let objectArray = Array(array) as? [Codable] {
            return objectArray
        }
        return []
    }
}
