//
//  FavouritesModel+CoreDataProperties.swift
//  RickMortyTestApp
//
//  Created by Adlet Zhantassov on 12.11.2023.
//
//

import Foundation
import CoreData


extension FavouritesModel {

    @NSManaged public var id: Int16
    @NSManaged public var name: String?
    @NSManaged public var airDate: String?
    @NSManaged public var episode: String?
    @NSManaged public var characters: [String]?
    @NSManaged public var url: String?
    @NSManaged public var created: String?

}

extension FavouritesModel : Identifiable {

}
