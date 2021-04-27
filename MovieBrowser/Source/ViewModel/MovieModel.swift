//
//  File.swift
//  MovieBrowser
//
//  Created by Kenneth Adams on 04/22/21.
//  Copyright © 2021 Lowe's Home Improvement. All rights reserved.
//

import UIKit



class MovieModel {
    
    var movies: [MovieListResult] = []
    var finalMovies: [Movie] = []
    let networkManager = Network.shared
    
    var updateHandler: (() -> ())?
    
    init() {
        
    }
    
    func bind(updateHandler: @escaping () -> ()) {
        self.updateHandler = updateHandler
    }
    
    func fetchMovies(url: String) {
        networkManager.fetchData(url: url ) { [weak self] (result: Result<MovieDetail,MyError>) in
            guard let self = self else {return}
            switch result {
            case .success(let movieList):
                self.movies = movieList.results
                self.updateHandler?()
            case .failure(let error):
                print(error)
            }
        }
    }
    
   // func image(for index: Int) -> UIImage {
   //     return self.finalMovies[index].image ?? UIImage(imageLiteralResourceName: //"placeholder")
   // }
}
