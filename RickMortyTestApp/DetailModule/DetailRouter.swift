//
//  DetailRouter.swift
//  RickMortyTestApp
//
//  Created by Adlet Zhantassov on 09.11.2023.
//

import Foundation

protocol DetailRouterProtocol: AnyObject {
    
}

class DetailRouter {
    weak var presenter: DetailPresenterProtocol?
}

extension DetailRouter: DetailRouterProtocol {
    
}
