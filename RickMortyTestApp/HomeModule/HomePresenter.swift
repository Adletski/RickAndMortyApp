//
//  HomePresenter.swift
//  RickMortyTestApp
//
//  Created by Adlet Zhantassov on 05.11.2023.
//

import Foundation

protocol HomePresenterProtocol: AnyObject {
    func viewDidLoaded()
    func didLoad(episode: Episode)
    func characterDidTap(_ character: Res)
}

class HomePresenter {
    
    weak var view: HomeViewControllerProtocol?
    var router: HomeRouterProtocol
    var interactor: HomeInteractorProtocol
    
    init(router: HomeRouterProtocol, interactor: HomeInteractorProtocol) {
        self.router = router
        self.interactor = interactor
    }
}

extension HomePresenter: HomePresenterProtocol {
    func characterDidTap(_ character: Res) {
        router.openDetail(character: character)
        print("character did tap")
    }
    
    func didLoad(episode: Episode) {
        view?.showEpisode(episode: episode)
    }
    
    func viewDidLoaded() {
        interactor.loadEpisode()
    }
}
