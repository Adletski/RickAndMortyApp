//
//  CoreDataManager.swift
//  RickMortyTestApp
//
//  Created by Adlet Zhantassov on 11.11.2023.
//

import Foundation
import UIKit
import CoreData

final class CoreDataManager: NSObject {
    
    static let shared = CoreDataManager()
    private override init() { }
    
    private var appDelegate: AppDelegate {
        UIApplication.shared.delegate as! AppDelegate
    }
    
    private var context: NSManagedObjectContext {
        appDelegate.persistentContainer.viewContext
    }
    
    public func deleteAllFavourites() {
        let fetchRequest: NSFetchRequest<Favourites> = Favourites.fetchRequest()
        guard let favourites = try? context.fetch(fetchRequest) else { return }
        
        for favourite in favourites {
            context.delete(favourite)
        }
        
        appDelegate.saveContext()
    }
    
    public func addFavourite(id: Int16, name: String, url: String, episode: String, created: String, airDate: String, characters: [String]) {
        
        let fetchRequest: NSFetchRequest<Favourites> = Favourites.fetchRequest()
        guard let favourites = try? context.fetch(fetchRequest) else { return }
        print(favourites)
        if !favourites.contains(where: { $0.url == url }) {
            guard let entity = NSEntityDescription.entity(forEntityName: "Favourites", in: context) else { return }
            let favouriteObject = Favourites(entity: entity, insertInto: context)
            favouriteObject.id = id
            favouriteObject.name = name
            favouriteObject.url = url
            favouriteObject.episode = episode
            favouriteObject.created = created
            favouriteObject.airDate = airDate
            favouriteObject.characters = characters
            
            do {
                try context.save()
            } catch {
                print("error in add favourite \(error)")
            }
        }
    }
    
    public func fetchFavourites() -> [Favourites] {
        let fetchRequest: NSFetchRequest<Favourites> = Favourites.fetchRequest()
        do {
            return try context.fetch(fetchRequest)
        } catch {
            print(error.localizedDescription)
        }
        return []
    }
    
    public func deleteFavourite(url: String) {
        let fetchRequest: NSFetchRequest<Favourites> = Favourites.fetchRequest()
        guard let favourites = try? context.fetch(fetchRequest),
        let favourite = favourites.first(where: { $0.url == url }) else { return }
        context.delete(favourite)
        
        appDelegate.saveContext()
    }
    
}
