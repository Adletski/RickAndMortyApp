//
//  DetailViewController.swift
//  RickMortyTestApp
//
//  Created by Adlet Zhantassov on 09.11.2023.
//

import UIKit

protocol DetailViewControllerProtocol: AnyObject {
    func showCharacter(character: CharacterModel)
}

final class DetailViewController: UIViewController {
    
    var presenter: DetailPresenterProtocol?
    var character: CharacterModel?
    
    private let profileImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let cameraButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "camera"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 25, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var informationTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        presenter?.viewDidLoaded()
    }
    
    override func viewDidLayoutSubviews() {
        profileImage.layer.cornerRadius = profileImage.frame.height / 2
        profileImage.layer.borderWidth = 1
        profileImage.layer.masksToBounds = false
        profileImage.layer.borderColor = UIColor.white.cgColor
        profileImage.clipsToBounds = true
    }
    
    private func setup() {
        navigationController?.navigationBar.tintColor = .black
        let rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "logoBack"), style: .done, target: nil, action: nil)
        navigationItem.rightBarButtonItem = rightBarButtonItem
        view.backgroundColor = .white
        view.addSubview(profileImage)
        view.addSubview(cameraButton)
        view.addSubview(nameLabel)
        view.addSubview(informationTableView)
//        informationTableView.rowHeight = 65
        
        NSLayoutConstraint.activate([
            profileImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            profileImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profileImage.widthAnchor.constraint(equalToConstant: 150),
            profileImage.heightAnchor.constraint(equalToConstant: 150),
            
            cameraButton.centerYAnchor.constraint(equalTo: profileImage.centerYAnchor),
            cameraButton.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: 10),
            
            nameLabel.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 20),
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            informationTableView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20),
            informationTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            informationTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            informationTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            
        ])
    }
}

extension DetailViewController: DetailViewControllerProtocol {
    
    func showCharacter(character: CharacterModel) {
        print("showcharacter")
        DispatchQueue.main.async {
            NetworkManager.getImage(urlString: character.image) { result in
                switch result {
                case .success(let image):
                    DispatchQueue.main.async {
                        self.profileImage.image = image
                    }
                case .failure(let error):
                    print(error)
                }
            }
            self.nameLabel.text = character.name
            self.character = character
            self.informationTableView.reloadData()
        }
    }
}

// MARK: - UITableViewDelegate

extension DetailViewController: UITableViewDelegate {
    
}

// MARK: - UITableViewDataSource

extension DetailViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Informations"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier")
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "reuseIdentifier")
        }
        
        cell?.textLabel?.font = .systemFont(ofSize: 15, weight: .bold)
        
        if indexPath.row == 0 {
            cell?.textLabel?.text = "Gender"
            cell?.detailTextLabel?.text = character?.gender
        } else if indexPath.row == 1 {
            cell?.textLabel?.text = "Status"
            cell?.detailTextLabel?.text = character?.status
        } else if indexPath.row == 2 {
            cell?.textLabel?.text = "Specie"
            cell?.detailTextLabel?.text = character?.species
        } else if indexPath.row == 3 {
            cell?.textLabel?.text = "Origin"
            cell?.detailTextLabel?.text = character?.origin.name
        } else if indexPath.row == 4 {
            cell?.textLabel?.text = "Type"
            cell?.detailTextLabel?.text = character?.type
        } else if indexPath.row == 5 {
            cell?.textLabel?.text = "Location"
            cell?.detailTextLabel?.text = character?.location.name
        }
        
        return cell ?? UITableViewCell()
    }
}
