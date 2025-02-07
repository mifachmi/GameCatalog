//
//  SearchViewController.swift
//  GameCatalogApp
//
//  Created by Fachmi Dimas Ardhana on 07/02/25.
//

import UIKit
import RxSwift
import RxCocoa

class SearchViewController: UIViewController {
    
    private let searchPresenter: SearchPresenter
    private let disposeBag = DisposeBag()
    
    private lazy var loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    private lazy var emptyStateLabel: UILabel = {
        let label = UILabel()
        label.text = "No matching games found"
        label.textAlignment = .center
        label.textColor = .gray
        label.font = .preferredFont(forTextStyle: .headline)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isHidden = true
        return label
    }()
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.backgroundImage = UIImage()
        searchBar.autocapitalizationType = .none
        searchBar.autocorrectionType = .no
        searchBar.enablesReturnKeyAutomatically = false
        searchBar.returnKeyType = .search
        searchBar.placeholder = "Search game by title"
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    
    private lazy var searchResultCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = .init(width: UIScreen.main.bounds.width, height: 130)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(
            SearchCollectionViewCell.self,
            forCellWithReuseIdentifier: "SearchCollectionViewCell"
        )
        collectionView.isHidden = true
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    init(searchPresenter: SearchPresenter) {
        self.searchPresenter = searchPresenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        bindSearchBar()
        dismissKeyboardMethod()
        
        searchPresenter.delegate = self
    }
}

extension SearchViewController {
    func setupView() {
        view.backgroundColor = .white
        navigationItem.title = "Search Game"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        view.addSubview(searchBar)
        view.addSubview(emptyStateLabel)
        view.addSubview(searchResultCollectionView)
        view.addSubview(loadingIndicator)
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            searchBar.heightAnchor.constraint(equalToConstant: 56),
            
            emptyStateLabel.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            emptyStateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            emptyStateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            emptyStateLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            searchResultCollectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            searchResultCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchResultCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            searchResultCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            loadingIndicator.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            loadingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    func bindSearchBar() {
        searchBar.rx.searchButtonClicked
            .withLatestFrom(searchBar.rx.text.orEmpty)
            .subscribe(on: ConcurrentDispatchQueueScheduler(qos: .background))
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] query in
                self?.searchPresenter.searchGames(query: query)
            })
            .disposed(by: disposeBag)
        
        searchBar.rx.text.orEmpty
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] text in
                if text.isEmpty {
                    self?.searchPresenter.gamesRelay.accept([])
                    self?.emptyStateLabel.isHidden = false
                    self?.searchResultCollectionView.isHidden = true
                }
            })
            .disposed(by: disposeBag)
        
        searchPresenter.gamesRelay.asObservable()
            .bind(to: searchResultCollectionView.rx.items(
                cellIdentifier: "SearchCollectionViewCell",
                cellType: SearchCollectionViewCell.self)
            ) { _, game, cell in
                cell.game = game
                cell.delegate = self
            }
            .disposed(by: disposeBag)
        
        searchPresenter.gamesRelay.asObservable()
            .subscribe(onNext: { [weak self] games in
                self?.searchResultCollectionView.isHidden = games.isEmpty
            })
            .disposed(by: disposeBag)
        
    }
    
    func dismissKeyboardMethod() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
        
        searchResultCollectionView.rx.contentOffset
            .subscribe(onNext: { [weak self] _ in
                self?.dismissKeyboard()
            })
            .disposed(by: disposeBag)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension SearchViewController: SearchCollectionViewCellDelegate {
    func didTapCard(gameId: Int) {
        searchPresenter.showDetailGame(from: self, gameId: gameId)
    }
}

extension SearchViewController: SearchPresenterDelegate {
    func willStartLoading() {
        emptyStateLabel.isHidden = true
        loadingIndicator.startAnimating()
    }
    
    func didFinishLoading() {
        loadingIndicator.stopAnimating()
    }
    
    func didFailGetGames(with error: any Error) {
        emptyStateLabel.text = error.localizedDescription
        emptyStateLabel.isHidden = false
    }
}
