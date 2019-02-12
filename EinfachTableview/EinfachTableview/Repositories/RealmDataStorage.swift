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
    
    var updateRealmObject: Bool = true
    var realmSchemaVersion: UInt64 = 1
    
    init(updateRealmObject: Bool, realmSchemaVersion: UInt64) {
        self.updateRealmObject = updateRealmObject
        self.realmSchemaVersion = realmSchemaVersion
        self.performRealmMigration()
    }
    
    // Realm migration
    func performRealmMigration() {
        let config = Realm.Configuration(
            schemaVersion: realmSchemaVersion,
            migrationBlock: { _, oldSchemaVersion in
                if oldSchemaVersion < 1 {}
        })
        // Tell Realm to use this new configuration object for the default Realm
        Realm.Configuration.defaultConfiguration = config
        // perform the migration
        _ = try! Realm()
    }
    
    func save(items: [Object]) {
        let realm = try! Realm()
        try! realm.write {
            realm.add(items, update: updateRealmObject)
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
