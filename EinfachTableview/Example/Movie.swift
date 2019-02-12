//
//  Movie.swift
//  EinfachTableview
//
//  Created by Marwen Doukh on 2/9/19.
//  Copyright © 2019 Marwen Doukh. All rights reserved.
//

// swiftlint:disable identifier_name
import RealmSwift

class Movies: Codable {
    var movies: [Movie] = []
}
class Movie: Object, Codable {
    
    @objc dynamic var rating: Double = 0
    @objc dynamic var title: String = ""
    @objc dynamic var mediumCoverImage: String = ""
    @objc dynamic var year: Int = 0
    @objc dynamic var smallCoverImage: String = ""
    @objc dynamic var id: Int = 0
    @objc dynamic var descriptionFull: String = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    private enum CodingKeys: String, CodingKey {
        case rating = "rating"
        case title = "title"
        case mediumCoverImage = "medium_cover_image"
        case year = "year"
        case smallCoverImage = "small_cover_image"
        case id = "id"
        case descriptionFull = "description_full"
    }
    
    func encode(to encoder: Encoder) throws {
        do {
            var container = encoder.container(keyedBy: CodingKeys.self)
            
            try container.encode(rating, forKey: .rating)
            try container.encode(title, forKey: .title)
            try container.encode(mediumCoverImage, forKey: .mediumCoverImage)
            try container.encode(smallCoverImage, forKey: .smallCoverImage)
            try container.encode(year, forKey: .year)
            try container.encode(id, forKey: .id)
            try container.encode(descriptionFull, forKey: .descriptionFull)
            
        } catch {
            print(error)
        }
    }
    
    required convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        rating = try container.decode(Double.self, forKey: .rating)
        title = try container.decode(String.self, forKey: .title)
        mediumCoverImage = try container.decode(String.self, forKey: .mediumCoverImage)
        smallCoverImage = try container.decode(String.self, forKey: .smallCoverImage)
        year = try container.decode(Int.self, forKey: .year)
        id = try container.decode(Int.self, forKey: .id)
        descriptionFull = try container.decode(String.self, forKey: .descriptionFull)
        
    }
}
