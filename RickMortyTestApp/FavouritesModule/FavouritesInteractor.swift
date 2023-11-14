//
//  FavouritesInteractor.swift
//  RickMortyTestApp
//
//  Created by Adlet Zhantassov on 11.11.2023.
//

import Foundation

protocol FavouritesInteractorProtocol: AnyObject {
    
}

class FavouritesInteractor: FavouritesInteractorProtocol {
    
    weak var presenter: FavouritesPresenterProtocol?
    
    init(presenter: FavouritesPresenterProtocol? = nil) {
        self.presenter = presenter
    }
    
    
}
