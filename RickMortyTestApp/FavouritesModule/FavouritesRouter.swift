//
//  FavouritesRouter.swift
//  RickMortyTestApp
//
//  Created by Adlet Zhantassov on 11.11.2023.
//

import Foundation

protocol FavouritesRouterProtocol: AnyObject {
    
}

class FavouritesRouter {
    weak var presenter: FavouritesPresenterProtocol?
    
}

extension FavouritesRouter: FavouritesRouterProtocol {
    
}
