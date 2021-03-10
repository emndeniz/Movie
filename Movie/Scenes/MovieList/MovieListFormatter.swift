//
//  MovieListFormatter.swift
//  Movie
//
//  Created by Mehmet Emin Deniz on 9.03.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the 🐍 VIPER generator
//

import UIKit

final class MovieListFormatter {
    var results: [MoviesModel.Result] = []
    //var totalNumberOfPages = 0
    var totalResults = 0
}

// MARK: - Extensions -

extension MovieListFormatter: MovieListFormatterInterface {
    func getTotalNumberOfMovies() -> Int {
        return totalResults
    }
    
    func getCurrentNumberOfMovies() -> Int {
        return results.count
    }
    
    func appendMovieResponse(model:MoviesModel?) {
        guard let model = model , let results = model.results else {return}
        self.results.append(contentsOf: results)
        
        if let totalRes = model.totalResults {
            totalResults = totalRes
        }
    }
    
    func getMovieCell(index: Int) -> MovieCellModel? {
        guard results.count > 0 else {
            return nil
        }
        let movie = results[index]
        return MovieCellModel(title: movie.title ?? "",
                              isFavourite: false,
                              posterUrl: movie.posterPath ?? "")
    }
    
    func calculateIndexPathsToReload(newResults: [MoviesModel.Result]) -> [IndexPath] {
      let startIndex = results.count - newResults.count
      let endIndex = startIndex + newResults.count
      return (startIndex..<endIndex).map { IndexPath(row: $0, section: 0) }
    }
    
}
