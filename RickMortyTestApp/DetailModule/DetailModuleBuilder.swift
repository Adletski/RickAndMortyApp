//
//  DetailModuleBuilder.swift
//  RickMortyTestApp
//
//  Created by Adlet Zhantassov on 09.11.2023.
//

import Foundation

class DetailModuleBuilder {
    static func build(character: Res) -> DetailViewController {
        let interactor = DetailInteractor(character: character)
        let router = DetailRouter()
        let presenter = DetailPresenter(router: router, interactor: interactor)
        let viewController = DetailViewController()
        viewController.presenter = presenter
        presenter.view = viewController
        interactor.presenter = presenter
        router.presenter = presenter
        return viewController
    }
}
