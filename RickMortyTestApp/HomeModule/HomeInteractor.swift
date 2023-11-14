//
//  HomeInteractor.swift
//  RickMortyTestApp
//
//  Created by Adlet Zhantassov on 05.11.2023.
//

import Foundation

protocol HomeInteractorProtocol: AnyObject {
    func loadEpisode()
}

class HomeInteractor: HomeInteractorProtocol {
    
    weak var presenter: HomePresenterProtocol?
    
    let networkManager = NetworkManager()
    
    func loadEpisode() {
        networkManager.getEpisodes { [weak self] result in
            switch result {
                case .success(let episode):
                    self?.presenter?.didLoad(episode: episode)
                case .failure(let error):
                    print(error)
            }
        }
    }
}
