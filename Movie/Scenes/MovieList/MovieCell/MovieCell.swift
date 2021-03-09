//
//  MovieCell.swift
//  Movie
//
//  Created by Mehmet Emin Deniz on 8.03.2021.
//

import UIKit

protocol MovieCellDelegate : class {
    func didPressFavButton(isFavorited:Bool)
}

class MovieCell: UICollectionViewCell {
    var cellDelegate: MovieCellDelegate?
    
    @IBOutlet weak var poster: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var favButtonOutlet: UIButton!
    
    //private var movieID:
    
    private var isFavorited = false
    @IBAction func favButtonAction(_ sender: Any) {
        isFavorited = !isFavorited
        let imageName = isFavorited ? "star.fill" : "star"
        favButtonOutlet.setImage(UIImage(systemName: imageName), for: .normal)
        cellDelegate?.didPressFavButton(isFavorited: isFavorited)
    }
    
    func setCellData(){
       
    }
  
}
