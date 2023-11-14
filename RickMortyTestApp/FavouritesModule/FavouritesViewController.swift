//
//  FavouritesViewController.swift
//  RickMortyTestApp
//
//  Created by Adlet Zhantassov on 05.11.2023.
//

import UIKit

protocol FavouritesViewControllerProtocol: AnyObject {
    
}

final class FavouritesViewController: UIViewController {
    
    var presenter: FavouritesPresenterProtocol?
    
    var data: [Favourites] = []
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(FavouritesTableViewCell.self, forCellReuseIdentifier: FavouritesTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        return tableView
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("new")
        data = CoreDataManager.shared.fetchFavourites()
        tableView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        presenter?.viewDidLoaded()
    }
    
    private func setup() {
        navigationItem.title = "Favourites"
        view.backgroundColor = .white
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension FavouritesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FavouritesTableViewCell.identifier, for: indexPath) as? FavouritesTableViewCell else { return UITableViewCell() }
        cell.configure(result: data[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
}

extension FavouritesViewController: FavouritesViewControllerProtocol {
    
}
