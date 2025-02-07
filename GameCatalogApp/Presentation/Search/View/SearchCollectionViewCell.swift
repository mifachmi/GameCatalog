//
//  SearchCollectionViewCell.swift
//  GameCatalogApp
//
//  Created by Fachmi Dimas Ardhana on 07/02/25.
//

import UIKit
import RxSwift

protocol SearchCollectionViewCellDelegate: AnyObject {
    func didTapCard(gameId: Int)
}

class SearchCollectionViewCell: UICollectionViewCell {
    private var homeCardView: HomeCardView
    weak var delegate: SearchCollectionViewCellDelegate?
    
    var game: GameModel? {
        didSet {
            guard let game = game else { return }
            homeCardView.configure(with: game)
        }
    }
    
    override init(frame: CGRect) {
        homeCardView = HomeCardView()
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SearchCollectionViewCell {
    func setupView() {
        contentView.backgroundColor = .clear
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(homeCardView)
        homeCardView.translatesAutoresizingMaskIntoConstraints = false
        homeCardView.delegate = self
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            homeCardView.topAnchor.constraint(equalTo: contentView.topAnchor),
            homeCardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            homeCardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            homeCardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}

extension SearchCollectionViewCell: HomeCardViewDelegate {
    func didTapCard() {
        delegate?.didTapCard(gameId: game?.id ?? 0)
    }
}
