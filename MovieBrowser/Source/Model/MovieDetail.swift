//
//  MovieDetail.swift
//  MovieBrowser
//
//  Created by Kenneth Adams on 04/22/21.
//  Copyright © 2021 Lowe's Home Improvement. All rights reserved.
//


import Foundation

struct MovieDetail: Codable {
    
   var results: [MovieListResult]
    
}

struct MovieListResult: Codable, Equatable {
    var poster_path: String?
    var popularity: Double?
    var adult: Bool?
    var overview: String?
    var release_date: String?
    var genre_ids: [Int]?
    var id: Int?
    var original_title: String?
    var original_language: String?
    var title: String?
    var backdrop_path: String?
    
    enum CodingKeys: String, CodingKey {
        case poster_path, adult, overview, release_date, genre_ids, id, original_title, original_language, title, backdrop_path, popularity
        
    }
}



