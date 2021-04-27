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
    
    func dateModify(toMod: [String]) -> String {
        if (toMod[1] == "01"){
            return "January \(toMod[2]), \(toMod[0])"
        }
       else if (toMod[1] == "02"){
            return "February \(toMod[2]), \(toMod[0])"
        }

       else if (toMod[1] == "03"){
            return "March \(toMod[2]), \(toMod[0])"
        }

        else if (toMod[1] == "04"){
            return "April \(toMod[2]), \(toMod[0])"
        }

       else if (toMod[1] == "05"){
            return "May \(toMod[2]), \(toMod[0])"
        }

       else if (toMod[1] == "06"){
            return "June \(toMod[2]), \(toMod[0])"
        }

       else if (toMod[1] == "07"){
            return "July \(toMod[2]), \(toMod[0])"
        }

       else if (toMod[1] == "08"){
            return "August \(toMod[2]), \(toMod[0])"
        }

       else if (toMod[1] == "09"){
            return "September \(toMod[2]), \(toMod[0])"
        }
        
       else if (toMod[1] == "10"){
            return "October \(toMod[2]), \(toMod[0])"
        }
        
        else if (toMod[1] == "11"){
            return "November \(toMod[2]), \(toMod[0])"
        }
        
        else if (toMod[1] == "12"){
            return "December \(toMod[2]), \(toMod[0])"
        }
        else {
            return ""
        }
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
        let str = self.movieVM.movies[indexPath.row].release_date
        let strArray = str?.components(separatedBy: "-") ?? [""]
        let date = self.dateModify(toMod: strArray)
        
        cell.titleLabel.text = self.movieVM.movies[indexPath.row].title
        cell.releaseLabel.text = date
        cell.ratingLabel.text = "\(self.movieVM.movies[indexPath.row].vote_average ?? 0)"
        return cell
    }
    

    
}

