//
//  Movie.swift
//  Flixter
//
//  Created by Mariamawit Tadesse on 03/19/23.
//

import Foundation

// TODO: Pt 1 - Create a Track model struct
struct TracksResponse: Decodable{
    let results: [Movie]
}

struct Movie: Decodable{
    let title: String
    let overview: String
    let poster_path: String?
    let backdrop_path: String?
    let popularity: Double
    let vote_average: Double
    let vote_count: Int
    let id: Int
}

// TODO: Pt 1 - Create an extension with a mock tracks static var


// MARK: Helper Methods
/// Converts milliseconds to mm:ss format
///  ex:  208643 -> "3:28"
///  ex:

