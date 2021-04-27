//
//  Movie.swift
//  MovieBrowser
//
//  Created by Kenneth Adams on 04/22/21.
//  Copyright © 2021 Lowe's Home Improvement. All rights reserved.
//


import UIKit

class Movie {
    var image: UIImage?
    var adult: Bool?
    var overview: String?
    var release_date: String?
    var genre_ids: [Int]?
    var id: Int?
    var original_title: String?
    var original_language: String?
    var title: String?
    var backdrop_path: String?
    
    init(movie: MovieListResult, image: UIImage){
        self.image                  = image
        self.adult                  = movie.adult
        self.overview               = movie.overview
        self.release_date           = movie.release_date
        self.genre_ids              = movie.genre_ids
        self.id                     = movie.id
        self.original_title         = movie.original_title
        self.original_language      = movie.original_language
        self.title                  = movie.title
        self.backdrop_path          = movie.backdrop_path
        
    }
    
    init(){
        self.image                  = UIImage()
        self.adult                  = false
        self.overview               = ""
        self.release_date           = ""
        self.genre_ids              = []
        self.id                     = 0
        self.original_title         = ""
        self.original_language      = ""
        self.title                  = ""
        self.backdrop_path          = ""
    }
    
}
