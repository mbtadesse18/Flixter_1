//
//  Poster.swift
//  Flixter
//
//  Created by Mariamawit Tadesse on 3/19/23.
//

import Foundation

struct PosterSearchResponse: Decodable {
    let results: [Poster]
}

struct Poster: Decodable {
    let artworkUrl100: URL
}
