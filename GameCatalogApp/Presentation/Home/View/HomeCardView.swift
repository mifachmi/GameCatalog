//
//  HomeCardView.swift
//  GameCatalogApp
//
//  Created by Fachmi Dimas Ardhana on 26/01/25.
//

import UIKit

protocol HomeCardViewDelegate: AnyObject {
    func didTapCard()
}

class HomeCardView: UIView {
    
    weak var delegate: HomeCardViewDelegate?
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        imageView.image = UIImage(resource: .imagePlaceholder)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .headline)
        label.numberOfLines = 0
        label.text = "Game Name"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var releaseDateLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.numberOfLines = 0
        label.text = "Release Date"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var starImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "star.fill")
        imageView.tintColor = .systemYellow
        return imageView
    }()
    
    private lazy var ratingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14)
        label.textColor = .darkGray
        label.text = "6.5"
        return label
    }()
    
    private lazy var ratingStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [starImageView, ratingLabel])
        stackView.spacing = 4
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var labelStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [nameLabel, releaseDateLabel, ratingStackView])
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [imageView, labelStackView])
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    init() {
        super.init(frame: .zero)
        setupView()
        setGesture()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension HomeCardView {
    func setupView() {
        backgroundColor = UIColor.gray.withAlphaComponent(0.1)
        layer.cornerRadius = 10
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowOffset = .zero
        layer.shadowRadius = 5
        layer.masksToBounds = false
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(mainStackView)
        mainStackView.alignment = .fill
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            mainStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            mainStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            mainStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            
            imageView.topAnchor.constraint(equalTo: mainStackView.topAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 100),
            imageView.trailingAnchor.constraint(equalTo: labelStackView.leadingAnchor, constant: -16),
            starImageView.widthAnchor.constraint(equalToConstant: 16),
            starImageView.heightAnchor.constraint(equalToConstant: 16),
            
            labelStackView.topAnchor.constraint(equalTo: mainStackView.topAnchor, constant: 16)
        ])
    }
    
    func configure(with game: GameModel) {
        nameLabel.text = game.name
        releaseDateLabel.text = game.released
        ratingLabel.text = "\(game.rating ?? 0.0)"
        
        if let url = URL(string: game.backgroundImage!) {
            imageView.setImage(with: url)
        }
    }
    
    func setGesture() {
        isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapCardView))
        addGestureRecognizer(tapGesture)
    }
    
    @objc func didTapCardView() {
        self.delegate?.didTapCard()
    }
}
