//
//  ViewController.swift
//  EinfachTableview
//
//  Created by Marwen Doukh on 2/7/19.
//  Copyright © 2019 Marwen Doukh. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, EinfachTableviewDelegate {
    
    @IBOutlet weak var myTableview: UITableView!
    // einfach tableview
    let einfachTV = EinfachTableview<Movies, Movie>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set delegates
        myTableview.delegate = einfachTV
        myTableview.dataSource = einfachTV
        einfachTV.einfachTVDelegate = self
        // load data from WS
        einfachTV.localStorageMode = .realm
        
        einfachTV.loadData(url: "https://www.json-generator.com/api/json/get/ceDdNwgzFK?indent=2")
        
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
    
    func manuallyDecode(object: Codable) -> [Codable] {
        if let movies = object as? Movies {
            return movies.movies
        }
        return []
    }
    
}
