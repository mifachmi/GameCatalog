//
//  HomeViewController.swift
//  GameCatalogApp
//
//  Created by Fachmi Dimas Ardhana on 25/01/25.
//

import UIKit
import RxSwift

class HomeViewController: UIViewController {
    
    private let homePresenter: HomePresenter
    
    private lazy var loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    private lazy var homeCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = .init(width: UIScreen.main.bounds.width, height: 130)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(HomeCollectionViewCell.self, forCellWithReuseIdentifier: "HomeCollectionViewCell")
        collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    init(homePresenter: HomePresenter) {
        self.homePresenter = homePresenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupView()
        
        homePresenter.output = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        homePresenter.getGames(pageSize: 15)
    }
    
}

extension HomeViewController {
    func setupNavigationBar() {
        navigationItem.title = "Game Catalog"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let profileButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "person.crop.circle"),
            style: .plain,
            target: self,
            action: #selector(addButtonTapped)
        )
        profileButtonItem.tintColor = UIColor.systemBlue
        navigationItem.rightBarButtonItem = profileButtonItem
    }
    
    func setupView() {
        view.backgroundColor = .white
        view.addSubview(homeCollectionView)
        view.addSubview(loadingIndicator)
        
        NSLayoutConstraint.activate([
            homeCollectionView.topAnchor.constraint(equalTo: view.topAnchor),
            homeCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            homeCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            homeCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            loadingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    @objc func addButtonTapped() {
        let aboutVC = AboutViewController()
        navigationController?.pushViewController(aboutVC, animated: true)
    }
}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return homePresenter.games.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let itemCell = homePresenter.games[indexPath.row]
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "HomeCollectionViewCell",
            for: indexPath
        ) as? HomeCollectionViewCell
        cell?.game = itemCell
        cell?.delegate = self
        return cell ?? UICollectionViewCell()
    }
}

extension HomeViewController: HomeCollectionViewCellDelegate {
    func didTapCard(gameId: Int) {
        homePresenter.showDetailGame(from: self, gameId: gameId)
    }
}

extension HomeViewController: HomePresenterOutput {
    func willStartLoading() {
        homeCollectionView.isHidden = true
        loadingIndicator.startAnimating()
    }
    
    func didFinishLoading() {
        loadingIndicator.stopAnimating()
        homeCollectionView.isHidden = false
    }
    
    func didGetGames(_ games: [GameModel]) {
        homeCollectionView.reloadData()
    }
    
    func didFailGetGames(with error: Error) {
        print(error.localizedDescription)
    }
}
