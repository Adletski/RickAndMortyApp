//
//  DetailInteractor.swift
//  RickMortyTestApp
//
//  Created by Adlet Zhantassov on 09.11.2023.
//

import Foundation

protocol DetailInteractorProtocol: AnyObject {
    func loadCharacter()
}

class DetailInteractor: DetailInteractorProtocol {
    
    weak var presenter: DetailPresenterProtocol?
    var character: Res
    var characterModel: CharacterModel?
    
    init(presenter: DetailPresenterProtocol? = nil, character: Res) {
        self.presenter = presenter
        self.character = character
    }
    
    func loadCharacter() {
        
        NetworkManager.getCharacter(urlString: character.characters.randomElement() ?? "") { result in
            switch result {
                case .success(let character):
                    self.presenter?.didLoadCharacter(character: character)
                case .failure(let error):
                    print("error with get character \(error)")
            }
        }
    }
}
