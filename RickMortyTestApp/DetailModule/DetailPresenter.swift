//
//  DetailPresenter.swift
//  RickMortyTestApp
//
//  Created by Adlet Zhantassov on 09.11.2023.
//

import Foundation

protocol DetailPresenterProtocol: AnyObject {
    func viewDidLoaded()
    func didLoadCharacter(character: CharacterModel)
}

class DetailPresenter {
    
    weak var view: DetailViewControllerProtocol?
    var router: DetailRouterProtocol
    var interactor: DetailInteractorProtocol
    
    init(router: DetailRouterProtocol, interactor: DetailInteractorProtocol) {
        self.router = router
        self.interactor = interactor
    }
}

extension DetailPresenter: DetailPresenterProtocol {
    
    func viewDidLoaded() {
        print("viewdidloaded")
        interactor.loadCharacter()
    }
    
    func didLoadCharacter(character: CharacterModel) {
        print("didloadcharacter")
        view?.showCharacter(character: character)
    }
    
}
