//
//  HomeRouter.swift
//  RickMortyTestApp
//
//  Created by Adlet Zhantassov on 05.11.2023.
//

import Foundation
import UIKit

protocol HomeRouterProtocol: AnyObject {
    func openDetail(character: Res)
}

class HomeRouter: HomeRouterProtocol {
    
    weak var viewController: HomeViewController?
    
    func openDetail(character: Res) {
        let vc = DetailModuleBuilder.build(character: character)
//        viewController?.navigationController?.navigationBar.backItem?.title = "GO BACK"
        viewController?.navigationItem.backBarButtonItem = UIBarButtonItem(title: "GO BACK", style: .done, target: nil, action: nil)
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
}

