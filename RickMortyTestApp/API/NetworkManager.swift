//
//  NetworkManager.swift
//  RickMortyTestApp
//
//  Created by Adlet Zhantassov on 05.11.2023.
//

import Foundation
import UIKit

class NetworkManager {
    
    func getEpisodes(completion: @escaping (Result<Episode, Error>) -> Void) {
        let urlString = "https://rickandmortyapi.com/api/episode"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            do {
                guard let data = data else { return }
                let obj = try JSONDecoder().decode(Episode.self, from: data)
                completion(.success(obj))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    static func getCharacter(urlString: String, completion: @escaping (Result<CharacterModel, Error>) -> Void) {
        let urlString = urlString
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            do {
                guard let data = data else { return }
                let obj = try JSONDecoder().decode(CharacterModel.self, from: data)
                completion(.success(obj))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    static func getImage(urlString: String, completion: @escaping (Result<UIImage, Error>) -> Void) {
        let urlString = urlString
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            if let data = data, let image = UIImage(data: data) {
                completion(.success(image))
            }
        }.resume()
    }
}
