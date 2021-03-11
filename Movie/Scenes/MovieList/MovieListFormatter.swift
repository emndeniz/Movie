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
    var filteredResults: [MoviesModel.Result] = []
    var totalResults = 0
}

// MARK: - Extensions -

extension MovieListFormatter: MovieListFormatterInterface {
    func getMovieCell(index: Int, isFiltered: Bool) -> MovieCellModel {
        guard results.count > 0 else {
            // Return empty data
            return MovieCellModel(title: "", isFavourite: false, posterUrl: "")
        }
        
        let movie: MoviesModel.Result!
        
        if isFiltered {
            movie = filteredResults[index]
        }else {
            movie = results[index]
        }
        
        return MovieCellModel(title: movie.title ?? "",
                              isFavourite: false,
                              posterUrl: movie.posterPath ?? "")
    }
    
    func startLocalSearch(filter: String) {
        filteredResults = results.filter{ ($0.title?.contains(filter) ?? false)}
    }
    
    
    func getTotalNumberOfMovies() -> Int {
        return totalResults
    }
    
    func getCurrentNumberOfMovies( isFiltered: Bool) -> Int {
        if isFiltered {
            return filteredResults.count
        }else {
            return results.count
        }

    }
    
    func appendMovieResponse(model:MoviesModel?) {
        guard let model = model , let results = model.results else {return}
        self.results.append(contentsOf: results)
        
        if let totalRes = model.totalResults {
            totalResults = totalRes
        }
    }
    
    
    
    func calculateIndexPathsToReload(newResults: [MoviesModel.Result]) -> [IndexPath] {
      let startIndex = results.count - newResults.count
      let endIndex = startIndex + newResults.count
      return (startIndex..<endIndex).map { IndexPath(row: $0, section: 0) }
    }
    
}
