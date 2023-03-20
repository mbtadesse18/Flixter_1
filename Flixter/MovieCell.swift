//
//  MovieCell.swift
//  Flixter
//
//  Created by Mariamawit Tadesse on 03/19/23.
//

import UIKit
import Nuke

class MovieCell: UITableViewCell {

    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var movieOverviewLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    /// Configures the cell's UI for the given track.
    func configure(with track: Movie) {
        movieNameLabel.text = track.title
        movieOverviewLabel.text = track.overview

        // Load image async via Nuke library image loading helper method
        if let movieBackDropPath = track.poster_path {
                    Nuke.loadImage(with: URL(string: "https://image.tmdb.org/t/p/w600_and_h900_bestv2/\(movieBackDropPath)")!, into: movieImageView)
                }
    }

}
