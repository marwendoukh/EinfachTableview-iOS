//
//  RealmDataStorage.swift
//  EinfachTableview
//
//  Created by Marwen Doukh on 10.02.19.
//  Copyright © 2019 Marwen Doukh. All rights reserved.
//

import RealmSwift

// swiftlint:disable force_try
struct RealmDataStorage<T: Codable> {
    
    func saveDataInRealm(items: [Object]) {
        let realm = try! Realm()
        try! realm.write {
            realm.add(items)
        }
    }
}
