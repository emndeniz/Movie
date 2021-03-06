//
//  MovieListInterfaces.swift
//  Movie
//
//  Created by Mehmet Emin Deniz on 9.03.2021.
//
//  This file was generated by the 🐍 VIPER generator
//

import UIKit

protocol MovieListWireframeInterface: WireframeInterface {
}

protocol MovieListViewInterface: ViewInterface {
    func updateMovieList()
}

protocol MovieListPresenterInterface: PresenterInterface {
    func fetchMoreMovie()
    func getTotalNumberOfMovies() -> Int
    func getCurrentNumberOfMovies(isFiltered: Bool) -> Int
    func getMovieCell(indexPath:IndexPath, isFiltered:Bool) -> MovieCellModel
    func startLocalSearch(filter:String)
}

protocol MovieListFormatterInterface: FormatterInterface {
    func appendMovieResponse(model:MoviesModel?)
    func getMovieCell(index:Int, isFiltered:Bool) -> MovieCellModel
    func startLocalSearch(filter:String)
    func getTotalNumberOfMovies() -> Int
    func getCurrentNumberOfMovies(isFiltered: Bool) -> Int
}

protocol MovieListInteractorInterface: InteractorInterface {
    func getMovies(pageNum:Int,completion: @escaping GetMoviesResult)
}
