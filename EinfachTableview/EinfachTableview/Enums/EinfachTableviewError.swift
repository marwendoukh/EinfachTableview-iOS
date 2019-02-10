//
//  EinfachTableviewError.swift
//  EinfachTableview
//
//  Created by Marwen Doukh on 2/9/19.
//  Copyright © 2019 Marwen Doukh. All rights reserved.
//

enum EinfachTableviewError {
    case noInternet  // no internet connection
    case errorWsResponse  // WS response error
    case errorDataDecodingWsResponse  // could not decode WS data
    case noDataWsResponse  // WS returns empty data
    case realmSavingFailed  // Error while saving data in Realm
}
