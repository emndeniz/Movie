//
//  MovieListPresenter.swift
//  Movie
//
//  Created by Mehmet Emin Deniz on 9.03.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the 🐍 VIPER generator
//

import UIKit

final class MovieListPresenter {

    // MARK: - Private properties -

    private unowned let view: MovieListViewInterface
    private let formatter: MovieListFormatterInterface
    private let interactor: MovieListInteractorInterface
    private let wireframe: MovieListWireframeInterface

    private var pageNumber = 1
    private var isFetchInProgress = false
    // MARK: - Lifecycle -

    init(view: MovieListViewInterface, formatter: MovieListFormatterInterface, interactor: MovieListInteractorInterface, wireframe: MovieListWireframeInterface) {
        self.view = view
        self.formatter = formatter
        self.interactor = interactor
        self.wireframe = wireframe
    }
    
}

// MARK: - Extensions -

extension MovieListPresenter: MovieListPresenterInterface {

    func fetchMoreMovie() {
        fetchMovies()
    }
    
    func viewDidLoad() {
       fetchMovies()
    }
    
    func getTotalNumberOfMovies() -> Int {
        return formatter.getTotalNumberOfMovies()
    }
    
    func getCurrentNumberOfMovies() -> Int {
        return formatter.getCurrentNumberOfMovies()
    }
    
    func getMovieCell(indexPath: IndexPath) -> MovieCellModel {
        return formatter.getMovieCell(index: indexPath.row + (indexPath.section * 2))  ?? MovieCellModel(title: "", isFavourite: false, posterUrl: "")
    }
    
    private func fetchMovies(){
        guard !isFetchInProgress else {
          return
        }
        
        isFetchInProgress = true
        interactor.getMovies(pageNum:pageNumber) { [weak self] model in
            guard let self = self else {return}
            self.isFetchInProgress = false
            self.pageNumber = self.pageNumber + 1
            guard let model = model else {
                let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                self.wireframe.showAlert(title: "Error", message: "Failed to retrieve movie data", actions: [okAction])
                return
            }
            self.formatter.appendMovieResponse(model: model)
            self.view.updateMovieList()

            
        }
    }
}
