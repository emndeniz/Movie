//
//  MovieFavoriteManager.swift
//  Movie
//
//  Created by Mehmet Emin Deniz on 11.03.2021.
//

import UIKit
import CoreData

struct MovieFavoriteManager {
    let entityName = "FavoriteMovies"

    func addMovieToFavorites(id:Int){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        if let entity = NSEntityDescription.entity(forEntityName: entityName, in: managedContext){
            let item  = NSManagedObject(entity: entity, insertInto: managedContext)
            item.setValue(id, forKeyPath: "movieId")
            
            do {
                try managedContext.save()
            } catch let error {
                print("Item can not be saved, error: \(error.localizedDescription)")
            }
        }
    }
    
    func removeFromFavorites(id:Int){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName:entityName)
        
        do {
            let fetchResults = try managedContext.fetch(fetchRequest)
            for item in fetchResults as! [NSManagedObject]{
                if let favMovieId = item.value(forKeyPath: "movieId") as? Int, favMovieId == id{
                    managedContext.delete(item)
                }
            }
        } catch let error {
            print("Item can not be fetched, error: \(error.localizedDescription)")
           
        }
    }
    
    
    
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
                if let favMovieId = item.value(forKeyPath: "movieId") as? Int, favMovieId == id{
                    return true
                }
            }
        } catch let error {
            print("Item can not be fetched, error: \(error.localizedDescription)")
           
        }
        return false
    }
}
