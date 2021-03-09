//
//  MovieService.swift
//  Movie
//
//  Created by Mehmet Emin Deniz on 9.03.2021.
//

import Foundation


enum MovieService {
    case popularMovies(page: String)
    case movieDetail(id: String)
}

extension MovieService: ServiceBase {
    var baseURL: String {
        return "https://api.themoviedb.org"
    }

    var path: String {
        
        let defaultQurries = "language=en-US&api_key=" //TODO language can be argument
        
        switch self {
        case .popularMovies(_):
            return "/3/movie/popular"
        case .movieDetail(let id):
            return "/3/movie/\(id)"
        }
    }
    

    var parameters: [String: Any]? {
        // default params
        let API_KEY = "66434cfba33cb2d552b996412de2d822"
        var params: [String: Any] = ["api_key": API_KEY]
        
        switch self {
        case .popularMovies(let page):
            params["page"] = page
        case .movieDetail(_):
            break
        }
        return params
    }

    var method: ServiceMethod {
        return .get
    }
}
