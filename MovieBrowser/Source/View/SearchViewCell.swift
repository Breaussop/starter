//
//  SearchViewCell.swift
//  MovieBrowser
//
//  Created by Kenneth Adams on 04/22/21.
//  Copyright © 2021 Lowe's Home Improvement. All rights reserved.
//

import UIKit

class SearchViewCell: UITableViewCell {
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var releaseLabel: UILabel!
    @IBOutlet var ratingLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    public func configure(with title: String, releaseDate: String, rating: Double){
        titleLabel.text = title
        releaseLabel.text = releaseDate
        ratingLabel.text = String(rating)
        
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "SearchViewCell", bundle: nil)
    }
    
}
