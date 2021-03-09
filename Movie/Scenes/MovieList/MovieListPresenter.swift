//
//  MovieListPresenter.swift
//  Movie
//
//  Created by Mehmet Emin Deniz on 9.03.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the 🐍 VIPER generator
//

import Foundation

final class MovieListPresenter {

    // MARK: - Private properties -

    private unowned let view: MovieListViewInterface
    private let formatter: MovieListFormatterInterface
    private let interactor: MovieListInteractorInterface
    private let wireframe: MovieListWireframeInterface

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
    func viewDidLoad() {
        interactor.getMovies(pageNum: 1)
    }
}
