//
//  HomeModuleBuilder.swift
//  RickMortyTestApp
//
//  Created by Adlet Zhantassov on 05.11.2023.
//

import UIKit

class HomeModuleBuilder {
    static func build() -> HomeViewController {
        let interactor = HomeInteractor()
        let router = HomeRouter()
        let presenter = HomePresenter(router: router, interactor: interactor)
        let viewController = HomeViewController()
        viewController.presenter = presenter
        presenter.view = viewController
        interactor.presenter = presenter
        router.viewController = viewController
        return viewController
    }
}
