//
//  MoviesModel.swift
//  InstaMovies
//
//  Created by Ahmed Abd Elaziz on 5/17/20.
//  Copyright © 2020 Ahmed Abd Elaziz. All rights reserved.
//

import Foundation

// MARK: - MoviesModel
struct MoviesModel: Codable {
    let page, totalResults, totalPages: Int?
    let results: [MoviesDetailsModel]?

    enum CodingKeys: String, CodingKey {
        case page
        case totalResults = "total_results"
        case totalPages = "total_pages"
        case results
    }
}
