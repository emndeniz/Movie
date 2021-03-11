//
//  MovieListInteractor.swift
//  Movie
//
//  Created by Mehmet Emin Deniz on 9.03.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the 🐍 VIPER generator
//

import Foundation

typealias GetMoviesResult = (_ model:MoviesModel?) -> ()

final class MovieListInteractor {
    let provider = ServiceProvider<MovieService>()
}

// MARK: - Extensions -

extension MovieListInteractor: MovieListInteractorInterface {
    func getMovies(pageNum: Int, completion: @escaping GetMoviesResult) {
        let pageNumStr = String(pageNum)
        provider.load(service: .popularMovies(page: pageNumStr), decodeType: MoviesModel.self) { result in
            switch result {
                case .success(let response):
                    print("getMovies success data received, response: \(response)")
                    completion(response)
                case .failure(let error):
                    print("getMovies fail data received, error: \(error.localizedDescription)")
                    completion(nil)
                case .empty:
                    print("No data")
                    completion(nil)
            }
        }
    
    }
    
}
