//
//  MovieListViewController.swift
//  Movie
//
//  Created by Mehmet Emin Deniz on 9.03.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the 🐍 VIPER generator
//

import UIKit

final class MovieListViewController: UIViewController {

    // MARK: - Public properties -

    var presenter: MovieListPresenterInterface!
    
    @IBOutlet weak var collectionView: UICollectionView!
    private let itemsPerRow: CGFloat = 2
    private let sectionInsets = UIEdgeInsets(top: 15.0,left: 15.0,bottom: 15.0,right: 15.0)
    
    // MARK: - Lifecycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }

}

// MARK: - Extensions -

extension MovieListViewController: MovieListViewInterface {
    func updateMovieList() {
        collectionView.reloadData()
    }
    
}

extension MovieListViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return presenter.getTotalNumberOfMovies()/2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as? MovieCell else {
            return UICollectionViewCell()
        }
        
        if isLoadingCell(for: indexPath){
            presenter.fetchMoreMovie()
            cell.setCellData(data: nil)
        }else {
            cell.setCellData(data: presenter.getMovieCell(indexPath: indexPath))
        }
        cell.cellDelegate = self
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath ) -> CGSize {
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
}
extension MovieListViewController : UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        print("Prefetch: \(indexPaths)")
        if indexPaths.contains(where: isLoadingCell) {
            presenter.fetchMoreMovie()
         }
    }
    
    func isLoadingCell(for indexPath: IndexPath) -> Bool {
        let num = indexPath.row + indexPath.section * 2 + 10
        let result = num >= presenter.getCurrentNumberOfMovies()
        return result
    }
    
    func visibleIndexPathsToReload(intersecting indexPaths: [IndexPath]) -> [IndexPath] {
        let indexPathsForVisibleRows = collectionView.indexPathsForVisibleItems
        let indexPathsIntersection = Set(indexPathsForVisibleRows).intersection(indexPaths)
        return Array(indexPathsIntersection)
      }
}

extension MovieListViewController: MovieCellDelegate {
    func didPressFavButton(isFavorited: Bool) {
        print("didPressStartButton")
    }
}
