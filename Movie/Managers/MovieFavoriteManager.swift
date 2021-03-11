//
//  MovieFavoriteManager.swift
//  Movie
//
//  Created by Mehmet Emin Deniz on 11.03.2021.
//

import UIKit
import CoreData

struct MovieFavoriteManager {
    private let entityName = "FavoriteMovies"
    private let movieIdKey = "movieId"
    

    
    /// Add movie to favorites list in core data
    /// - Parameter id: Movie Id
    func addMovieToFavorites(id:Int){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        if let entity = NSEntityDescription.entity(forEntityName: entityName, in: managedContext){
            let item  = NSManagedObject(entity: entity, insertInto: managedContext)
            item.setValue(id, forKeyPath: movieIdKey)
            
            do {
                try managedContext.save()
            } catch let error {
                print("Item can not be saved, error: \(error.localizedDescription)")
            }
        }
    }
    
    /// Remove movie from favorites list in core data
    /// - Parameter id: Movie Id
    func removeFromFavorites(id:Int){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName:entityName)
        
        do {
            let fetchResults = try managedContext.fetch(fetchRequest)
            for item in fetchResults as! [NSManagedObject]{
                if let favMovieId = item.value(forKeyPath: movieIdKey) as? Int, favMovieId == id{
                    managedContext.delete(item)
                }
            }
        } catch let error {
            print("Item can not be fetched, error: \(error.localizedDescription)")
           
        }
    }
    
    
    
    /// Shows that is given movie is favorited or not.
    /// - Parameter id: Movie Id
    /// - Returns: isFavorited
    func isMovieFavorite(id:Int) -> Bool{
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return false
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName:entityName)
        
        do {
            let fetchResults = try managedContext.fetch(fetchRequest)
            //var favoritedMoviesIds = [Int]()
            for item in fetchResults as! [NSManagedObject]{
                if let favMovieId = item.value(forKeyPath: movieIdKey) as? Int, favMovieId == id{
                    return true
                }
            }
        } catch let error {
            print("Item can not be fetched, error: \(error.localizedDescription)")
           
        }
        return false
    }
}
