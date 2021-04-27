//
//  MovieDetailViewController.swift
//  SampleApp
//
//  Created by Kenneth Adams on 04/22/21.
//  Copyright © 2021 Lowe's Home Improvement. All rights reserved.
//
import UIKit

class MovieDetailViewController: UIViewController {
    
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseLabel: UILabel!
    @IBOutlet weak var detailsLabel: UILabel!
    @IBOutlet weak var movieImage: UIImageView!
    var movie: MovieListResult?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNav()
        setupDetails(movie: movie ?? MovieListResult())
    }
    
    static func create(ref: MovieListResult) -> MovieDetailViewController? {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "detailsVC") as? MovieDetailViewController
        vc?.movie = ref
        return vc
    }
    
    func setupNav() {
        self.navigationItem.titleView?.tintColor = .white
        self.navigationController?.navigationBar.barTintColor = .systemBlue
    }
    
    func setupDetails(movie: MovieListResult){
        titleLabel.text = movie.original_title
        releaseLabel.text = movie.release_date
        detailsLabel.text = movie.overview
        Network.shared.fetchImage(url: "https://image.tmdb.org/t/p/w500\(self.movie?.poster_path ?? "")" ){[weak self](result: Result<UIImage, MyError>) in
            guard let self = self else {return}
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    self.movieImage.image = image
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension MovieDetailViewController: UITableViewDelegate {
    
    func collectionView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let p = self.movie else {return UITableViewCell()}
        guard let cell = UITableView().dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? SearchViewCell else {return SearchViewCell()}
        return cell
    }    
}
