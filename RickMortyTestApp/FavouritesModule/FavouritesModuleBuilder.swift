//
//  FavouritesModuleBuilder.swift
//  RickMortyTestApp
//
//  Created by Adlet Zhantassov on 11.11.2023.
//

import Foundation

class FavouritesModuleBuilder {
    static func build() -> FavouritesViewController {
        let interactor = FavouritesInteractor()
        let router = FavouritesRouter()
        let presenter = FavouritesPresenter(router: router, interactor: interactor)
        let viewController = FavouritesViewController()
        viewController.presenter = presenter
        presenter.view = viewController
        interactor.presenter = presenter
        router.presenter = presenter
        return viewController
    }
}
