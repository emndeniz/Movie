//
//  MovieCell.swift
//  Movie
//
//  Created by Mehmet Emin Deniz on 8.03.2021.
//

import UIKit


class MovieCell: UICollectionViewCell {
    
    @IBOutlet weak var poster: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var favButtonOutlet: UIButton!
    
    private var movieId = -1
    
   // private var isFavorited = false
    @IBAction func favButtonAction(_ sender: Any) {
        toggleFavoriteMovieStatus()
    }
    
    func setCellData(data:MovieCellModel?){
        guard let data = data else {
            return
        }
        
        movieId = data.id
        title.text = data.title
        updateFavoritesButton()

        if let url = ImageViewHelper.createImageURL(posterPath: data.posterUrl, size: 200){
            poster.load(url: url)
        }
    }
    
    private func updateFavoritesButton(){
        if MovieFavoriteManager().isMovieFavorite(id: movieId){
            MovieFavoriteManager().addMovieToFavorites(id: movieId)
            favButtonOutlet.setImage( UIImage(systemName: "star.fill"), for: .normal)
        }
    }
    
    
    private func toggleFavoriteMovieStatus(){
        if MovieFavoriteManager().isMovieFavorite(id: movieId){
            MovieFavoriteManager().removeFromFavorites(id: movieId)
            favButtonOutlet.setImage( UIImage(systemName: "star"), for: .normal)
        }else {
            MovieFavoriteManager().addMovieToFavorites(id: movieId)
            favButtonOutlet.setImage( UIImage(systemName: "star.fill"), for: .normal)
        }
    }
  
}
