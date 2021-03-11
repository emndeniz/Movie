//
//  MovieDetailInterfaces.swift
//  Movie
//
//  Created by Mehmet Emin Deniz on 11.03.2021.
//
//  This file was generated by the 🐍 VIPER generator
//

import UIKit

protocol MovieDetailWireframeInterface: WireframeInterface {
}

protocol MovieDetailViewInterface: ViewInterface {
    func updateUI(model:MovieDetailViewModel)
}

protocol MovieDetailPresenterInterface: PresenterInterface {
    func getTitle() -> String
    func getMovieId() -> Int
}

protocol MovieDetailFormatterInterface: FormatterInterface {
    func getMovieDetailViewModel(response:MovieDetailModel) -> MovieDetailViewModel
}

protocol MovieDetailInteractorInterface: InteractorInterface {
    func getMovieDetail(id:Int, completion: @escaping GetMovieDetailCompletion)
}
