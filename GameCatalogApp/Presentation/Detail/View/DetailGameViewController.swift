//
//  DetailGameViewController.swift
//  GameCatalogApp
//
//  Created by Fachmi Dimas Ardhana on 26/01/25.
//

import UIKit
import RxSwift

class DetailGameViewController: UIViewController {
    
    private let gameId: Int
    private let detailPresenter: DetailPresenter
    
    private lazy var heartButtonItem: UIBarButtonItem = {
        let heartImage = UIImage(systemName: "heart")
        let button = UIBarButtonItem(
            image: heartImage,
            style: .plain,
            target: self,
            action: #selector(heartButtonTapped)
        )
        button.tintColor = UIColor.systemBlue
        return button
    }()
    
    private lazy var loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    private lazy var detailGameView: DetailGameView = {
        let view = DetailGameView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBarItem()
        setupView()

        detailPresenter.delegate = self
        detailPresenter.checkIsFavorite(gameId: gameId)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        detailPresenter.getGameDetail(id: gameId)
    }
    
    init(gameId: Int, detailPresenter: DetailPresenter) {
        self.gameId = gameId
        self.detailPresenter = detailPresenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension DetailGameViewController {
    func setupNavigationBarItem() {
        navigationItem.rightBarButtonItem = heartButtonItem
    }
    
    @objc func heartButtonTapped() {
        guard let game = detailPresenter.game else { return }
        detailPresenter.toggleFavoriteStatus(game: game)
    }
    
    func setupView() {
        view.backgroundColor = .white
        view.addSubview(detailGameView)
        view.addSubview(loadingIndicator)
        
        NSLayoutConstraint.activate([
            detailGameView.topAnchor.constraint(equalTo: view.topAnchor),
            detailGameView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            detailGameView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            detailGameView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            loadingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func updateHeartButton(isFavorite: Bool) {
        let imageName = isFavorite ? "heart.fill" : "heart"
        self.heartButtonItem.image = UIImage(systemName: imageName)
    }
}

extension DetailGameViewController: DetailPresenterProtocolDelegate {
    func willStartLoading() {
        detailGameView.isHidden = true
        loadingIndicator.startAnimating()
    }
    
    func didFinishLoading() {
        detailGameView.isHidden = false
        loadingIndicator.stopAnimating()
    }
    
    func didGetDetailGame(with game: GameModel) {
        detailGameView.configure(with: game)
    }
    
    func didFailGetDetailGames(with error: any Error) {
        detailGameView.isHidden = false
    }
    
    func didSuccessToggleFavoriteStatus(isFavorite: Bool) {
        DispatchQueue.main.async {
            let alertMessage = isFavorite ? "Removed from favorite" : "Added to favorite"
            let alert = UIAlertController(
                title: "Favorite Status",
                message: alertMessage,
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                self.updateHeartButton(isFavorite: !isFavorite)
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func didCheckIsFavorite(isFavorite: Bool) {
        self.updateHeartButton(isFavorite: isFavorite)
    }
    
}
