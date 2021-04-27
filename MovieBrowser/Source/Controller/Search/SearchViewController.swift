//
//  SearchViewController.swift
//  SampleApp
//
//  Created by Kenneth Adams on 04/22/21.
//  Copyright © 2021 Lowe's Home Improvement. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    let movieVM = MovieModel() 
    var searchText: String = ""
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var goButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchBar.delegate = self
        
        self.navigationItem.titleView?.tintColor = .white
        self.navigationController?.navigationBar.barTintColor = .systemBlue
        
    }
    
    @IBAction  func didTapButton(_ sender: Any){
        setUpCollection(query: self.searchBar.text ?? "")
        
    }
    
    
    func setUpCollection(query: String) {
        let url = "https://api.themoviedb.org/3/search/movie?api_key=5885c445eab51c7004916b9c0313e2d3&language=en-US&query=\(query)&page=1&include_adult=true"
        
        tableView.register(SearchViewCell.nib(), forCellReuseIdentifier: "cell")
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.movieVM.bind {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        movieVM.fetchMovies(url: url)
    }
}

extension SearchViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){        
        guard let vc = MovieDetailViewController.create(ref: movieVM.movies[indexPath.row]) else {return}
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.movieVM.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:"cell", for: indexPath) as! SearchViewCell
        cell.titleLabel.text = self.movieVM.movies[indexPath.row].title
        cell.releaseLabel.text = self.movieVM.movies[indexPath.row].release_date
        cell.ratingLabel.text = "\(self.movieVM.movies[indexPath.row].popularity ?? 0)"
        return cell
    }
}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
    }
}
