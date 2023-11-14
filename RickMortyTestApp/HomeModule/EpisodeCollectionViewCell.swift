//
//  EpisodeCollectionViewCell.swift
//  RickMortyTestApp
//
//  Created by Adlet Zhantassov on 06.11.2023.
//

import UIKit

protocol EpisodeCollectionViewCellDelegate: AnyObject {
    func didTapFavoriteButton(cell: EpisodeCollectionViewCell)
}

final class EpisodeCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "EpisodeCollectionViewCell"
    var isheartFilled = false
    
    weak var delegate: EpisodeCollectionViewCellDelegate?
    
    private let mainView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 10
        view.layer.borderColor = UIColor.systemGray3.cgColor
        view.backgroundColor = .white
        return view
    }()
    
    private let characterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "mockImage")
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let movieImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "MonitorPlay")
        return imageView
    }()
    
    private let episodeLabel: UILabel = {
        let label = UILabel()
        label.text = "Pilot | S01E01"
        label.font = .systemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Rick Sanchez"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 15)
        return label
    }()
    
    private let heartButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "heartRegular"), for: .normal)
        button.addTarget(self, action: #selector(heartButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let stackH: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let myView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func heartButtonTapped() {
        isheartFilled.toggle()
        if isheartFilled {
            delegate?.didTapFavoriteButton(cell: self)
            heartButton.setImage(UIImage(named: "heartFilled"), for: .normal)
        } else {
            heartButton.setImage(UIImage(named: "heartRegular"), for: .normal)
        }
    }
    
    func configure(result: Res) {
        self.nameLabel.text = result.name
        self.episodeLabel.text = result.episode
        NetworkManager.getCharacter(urlString: result.characters.randomElement() ?? "") { result in
            switch result {
                case .success(let character):
                NetworkManager.getImage(urlString: character.image) { result in
                    switch result {
                    case .success(let image):
                        DispatchQueue.main.async {
                            self.characterImageView.image = image
                        }
                    case .failure(let error):
                        print("error with get image: \(error)")
                    }
                }
                case .failure(let error):
                    print("error with get character \(error)")
            }
        }
        if result.isFavourite {
            heartButton.setImage(UIImage(named: "heartFilled"), for: .normal)
        }
    }
    
    private func setup() {
        addSubview(mainView)
        mainView.addSubview(characterImageView)
        mainView.addSubview(nameLabel)
        myView.addSubview(movieImageView)
        myView.addSubview(episodeLabel)
        myView.addSubview(heartButton)
        mainView.addSubview(myView)
        
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: topAnchor),
            mainView.leadingAnchor.constraint(equalTo: leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: trailingAnchor),
            mainView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            characterImageView.topAnchor.constraint(equalTo: mainView.topAnchor),
            characterImageView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor),
            characterImageView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor),
            characterImageView.heightAnchor.constraint(equalToConstant: 200),
            
            nameLabel.topAnchor.constraint(equalTo: characterImageView.bottomAnchor, constant: 10),
            nameLabel.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 10),

            myView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            myView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor),
            myView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor),
            myView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            movieImageView.centerYAnchor.constraint(equalTo: myView.centerYAnchor),
            movieImageView.leadingAnchor.constraint(equalTo: myView.leadingAnchor, constant: 10),
            
            episodeLabel.centerYAnchor.constraint(equalTo: myView.centerYAnchor),
            episodeLabel.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: 5),
            
            heartButton.centerYAnchor.constraint(equalTo: myView.centerYAnchor),
            heartButton.trailingAnchor.constraint(equalTo: myView.trailingAnchor, constant: -10)
        ])
    }
    
    override func prepareForReuse() {
        self.episodeLabel.text = nil
        self.nameLabel.text = nil
        self.characterImageView.image = nil
        self.movieImageView.image = nil
        self.heartButton.setImage(UIImage(named: "heartRegular"), for: .normal)
    }
}
