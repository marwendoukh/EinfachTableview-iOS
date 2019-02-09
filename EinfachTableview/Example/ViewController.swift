//
//  ViewController.swift
//  EinfachTableview
//
//  Created by Marwen Doukh on 2/7/19.
//  Copyright © 2019 Marwen Doukh. All rights reserved.
//

import UIKit

class ViewController: UIViewController, EinfachTVDelegate {
    
    @IBOutlet weak var myTableview: UITableView!
    // einfach tableview
    let einfachTV = EinfachTableview<[Movie]>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set delegates
        myTableview.delegate = einfachTV
        myTableview.dataSource = einfachTV
        einfachTV.einfachTVDelegate = self
        // load data from WS
        einfachTV.loadData(url: "https://www.json-generator.com/api/json/get/cfwqDioRvm?indent=2")
    }
    
    
    func doneCallingWs() {
        myTableview.reloadData()
    }
    
    func cellForRowAt(_ tableView: UITableView, cellForRowAt indexPath: IndexPath, model: Codable) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "id", for: indexPath) as? MovieTableViewCell
        let movie = model as? Movie
        cell?.titleLabel.text = movie?.title
        
        return cell ?? UITableViewCell()
    }
    
    func terminatedWithError(error: EinfachTableviewError) {
        debugPrint(error)
    }
    
}

