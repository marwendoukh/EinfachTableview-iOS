//
//  EinfachTableviewDelegate.swift
//  EinfachTableview
//
//  Created by Marwen Doukh on 10.02.19.
//  Copyright © 2019 Marwen Doukh. All rights reserved.
//

import UIKit

protocol EinfachTableviewDelegate: class {
    func cellForRowAt(_ tableView: UITableView, cellForRowAt indexPath: IndexPath, model: Codable) -> UITableViewCell
    func doneCallingWs()
    func terminatedWithError(error: EinfachTableviewError, description: String)
    func manuallyDecode(object: Codable) -> [Codable]
}

extension EinfachTableviewDelegate {
    
    // default manually object decoding
    func manuallyDecode(object: Codable) -> [Codable] {
        return []
    }
    
    // default error handling
    func terminatedWithError(error: EinfachTableviewError, description: String) {
        debugPrint(description)
    }
}
