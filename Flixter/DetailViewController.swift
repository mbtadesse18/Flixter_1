//
//  DetailViewController.swift
//  Flixter
//
//  Created by Mariamawit Tadesse on 03/19/23.
//

import UIKit
import Nuke

class DetailViewController: UIViewController {

    @IBOutlet weak var backDropImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!

    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var voteAverageLabel: UILabel!
    @IBOutlet weak var votesLabel: UILabel!
    @IBOutlet weak var popularityLabel: UILabel!


    var track: Movie!

    override func viewDidLoad() {
        super.viewDidLoad()

        if let movieBackDropPath = track.backdrop_path {
                    Nuke.loadImage(with: URL(string: "https://image.tmdb.org/t/p/w600_and_h900_bestv2/\(movieBackDropPath)")!, into: backDropImageView)
                }
        titleLabel.text = track.title
        overviewLabel.text = track.overview
        
        voteAverageLabel.text = "\(track.vote_average)"
        votesLabel.text = "\(track.vote_count)"
        popularityLabel.text = "\(track.popularity)"
        
        

    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
               // Get the index path of the cell from the table view
               //let indexPath = tableView.indexPath(for: cell),
               // Get the detail view controller
            if let relatedViewController = segue.destination as? RelatedViewController {

                // Set the track on the detail view controller
                relatedViewController.movieID = track.id
            }
        }


}
