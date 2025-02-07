//
//  FavoriteGameViewController.swift
//  GameCatalogApp
//
//  Created by Fachmi Dimas Ardhana on 27/01/25.
//

import UIKit

class FavoriteGameViewController: UIViewController {
    
    private let favoritePresenter: FavoritePresenter
    
    private lazy var emptyStateLabel: UILabel = {
        let label = UILabel()
        label.text = "No favorite games yet"
        label.textAlignment = .center
        label.textColor = .gray
        label.font = .preferredFont(forTextStyle: .headline)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isHidden = true
        return label
    }()
    
    private lazy var favoriteCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = .init(width: UIScreen.main.bounds.width, height: 130)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(
            FavoriteGameCollectionViewCell.self,
            forCellWithReuseIdentifier: "FavoriteGameCollectionViewCell"
        )
        collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    init(favoritePresenter: FavoritePresenter) {
        self.favoritePresenter = favoritePresenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
        favoritePresenter.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        favoritePresenter.getFavoriteGames()
    }
    
}

extension FavoriteGameViewController {
    func setupView() {
        view.backgroundColor = .white
        navigationItem.title = "My Favorite Game"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        view.addSubview(favoriteCollectionView)
        view.addSubview(emptyStateLabel)
        
        NSLayoutConstraint.activate([
            favoriteCollectionView.topAnchor.constraint(equalTo: view.topAnchor),
            favoriteCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            favoriteCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            favoriteCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            emptyStateLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emptyStateLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}

extension FavoriteGameViewController: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return favoritePresenter.favoriteGames.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "FavoriteGameCollectionViewCell",
            for: indexPath
        ) as? FavoriteGameCollectionViewCell {
            let game = favoritePresenter.favoriteGames[indexPath.row]
            cell.game = game
            cell.delegate = self
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
}

extension FavoriteGameViewController: FavoriteGameCollectionViewCellDelegate {
    func didTapCard(gameId: Int) {
        favoritePresenter.showDetailGame(from: self, gameId: gameId)
    }
}

extension FavoriteGameViewController: FavoritePresenterDelegate {
    func getFavoriteGames(count: Int) {
        self.favoriteCollectionView.reloadData()
        if count > 0 {
            emptyStateLabel.isHidden = true
        } else {
            emptyStateLabel.isHidden = false
        }
    }
    
}
