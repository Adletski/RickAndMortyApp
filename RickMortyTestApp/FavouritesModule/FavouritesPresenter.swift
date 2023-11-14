//
//  FavouritesPresenter.swift
//  RickMortyTestApp
//
//  Created by Adlet Zhantassov on 11.11.2023.
//

import Foundation

protocol FavouritesPresenterProtocol: AnyObject {
    func viewDidLoaded()
    
}

class FavouritesPresenter {
    
    weak var view: FavouritesViewControllerProtocol?
    var router: FavouritesRouterProtocol
    var interactor: FavouritesInteractorProtocol
    
    init(router: FavouritesRouterProtocol, interactor: FavouritesInteractorProtocol) {
        self.router = router
        self.interactor = interactor
    }
}

extension FavouritesPresenter: FavouritesPresenterProtocol {
    
    func viewDidLoaded() {
        
    }
}
