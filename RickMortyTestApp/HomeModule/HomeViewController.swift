//
//  HomeViewController.swift
//  RickMortyTestApp
//
//  Created by Adlet Zhantassov on 05.11.2023.
//

import UIKit

protocol HomeViewControllerProtocol: AnyObject {
    func showEpisode(episode: Episode)
}

final class HomeViewController: UIViewController {
    
    private var filteredResults: [Res] = []
    private var results: [Res] = []
    private var isSearching = false
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Name or episode (ex.S01E01)..."
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.delegate = self
        searchBar.backgroundImage = UIImage()
        return searchBar
    }()
    
    private lazy var advancedFiltersButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "advancedFilters"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let episodeCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 30
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(EpisodeCollectionViewCell.self, forCellWithReuseIdentifier: EpisodeCollectionViewCell.identifier)
        return collectionView
    }()
    
    var presenter: HomePresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        print("home view controller")
        setup()
        presenter?.viewDidLoaded()
        episodeCollectionView.delegate = self
        episodeCollectionView.dataSource = self
    }
    
    private func setup() {
        navigationItem.title = "Rick and Morty"
        view.backgroundColor = .white
        view.addSubview(episodeCollectionView)
        view.addSubview(searchBar)
        view.addSubview(advancedFiltersButton)
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            searchBar.heightAnchor.constraint(equalToConstant: 50),
            
            advancedFiltersButton.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            advancedFiltersButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            advancedFiltersButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            advancedFiltersButton.heightAnchor.constraint(equalToConstant: 50),
            
            episodeCollectionView.topAnchor.constraint(equalTo: advancedFiltersButton.bottomAnchor, constant: 10),
            episodeCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            episodeCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            episodeCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}

//MARK: - HomeViewControllerProtocol

extension HomeViewController: HomeViewControllerProtocol {
    func showEpisode(episode: Episode) {
        DispatchQueue.main.async {
            self.results = episode.results
            self.episodeCollectionView.reloadData()
        }
    }
}

//MARK: - UICollectionViewDelegateFlowLayout

extension HomeViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width - 70, height: 300)
    }
}

//MARK: - UICollectionViewDelegate

extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.characterDidTap(results[indexPath.row])
    }
}

//MARK: - UICollectionViewDataSource

extension HomeViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isSearching {
            return filteredResults.count
        } else {
            return results.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EpisodeCollectionViewCell.identifier, for: indexPath) as? EpisodeCollectionViewCell else { return UICollectionViewCell() }
        cell.delegate = self
        if isSearching {
            cell.configure(result: filteredResults[indexPath.row])
        } else {
            cell.configure(result: results[indexPath.row])
        }
        return cell
    }
}

//MARK: - EpisodeCollectionViewCellDelegate

extension HomeViewController: EpisodeCollectionViewCellDelegate {
    func didTapFavoriteButton(cell: EpisodeCollectionViewCell) {
        if let indexPath = episodeCollectionView.indexPath(for: cell) {
            if isSearching {
                let data = filteredResults[indexPath.row]
                print("filteredRes \(data.url)")
                if !data.isFavourite {
                    CoreDataManager.shared.addFavourite(id: Int16(data.id), name: data.name, url: data.url, episode: data.episode, created: data.created, airDate: data.airDate, characters: data.characters)
                } else {
                    CoreDataManager.shared.deleteFavourite(url: data.url)
                }
            } else {
                let data = results[indexPath.row]
                results[indexPath.row].isFavourite = true
                print("res \(data.url)")
                if !data.isFavourite {
                    CoreDataManager.shared.addFavourite(id: Int16(data.id), name: data.name, url: data.url, episode: data.episode, created: data.created, airDate: data.airDate, characters: data.characters)
                } else {
                    CoreDataManager.shared.deleteFavourite(url: data.url)
                }
            }
            print("user did tap cell with index: \(indexPath.row)")
        }
    }
}

//MARK: - UISearchBarDelegate

extension HomeViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.filteredResults.removeAll()
        
        guard searchText != "" || searchText != " " else {
            print("empty search")
            return
        }
        
        filteredResults = results.filter({ $0.episode.lowercased().contains(searchText.lowercased()) })

        print(filteredResults)
        if searchBar.text == "" {
            isSearching = false
            episodeCollectionView.reloadData()
        } else {
            isSearching = true
            episodeCollectionView.reloadData()
        }
    }
}
