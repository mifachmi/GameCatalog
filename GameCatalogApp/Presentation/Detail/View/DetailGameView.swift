//
//  DetailGameView.swift
//  GameCatalogApp
//
//  Created by Fachmi Dimas Ardhana on 26/01/25.
//

import UIKit

class DetailGameView: UIView {
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.contentInset = .init(top: 100, left: 0, bottom: 16, right: 0)
        return scrollView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Game Name"
        label.font = .boldSystemFont(ofSize: 24)
        label.numberOfLines = 0
        label.textColor = .black
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
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        imageView.image = UIImage(resource: .imagePlaceholder)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var descriptionTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 17)
        label.numberOfLines = 0
        label.text = "About the Game"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.numberOfLines = 0
        label.text = "Game Description"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var releaseDateTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 17)
        label.numberOfLines = 0
        label.text = "Release Date"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var releaseDateLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.numberOfLines = 0
        label.text = "Release Date Information"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var genreTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 17)
        label.numberOfLines = 0
        label.text = "Genre"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var genreLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.numberOfLines = 0
        label.text = "Data Genre"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var alternativeNamesTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 17)
        label.numberOfLines = 0
        label.text = "Alternative Names"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var alternativeNamesLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.numberOfLines = 0
        label.text = "Data Alternative Names"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var publisherTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 17)
        label.numberOfLines = 0
        label.text = "Publisher"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var publisherLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.numberOfLines = 0
        label.text = "Data Publisher"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var ratingStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            starImageView, ratingLabel
        ])
        stackView.spacing = 4
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension DetailGameView {
    func setupView() {
        backgroundColor = .white
        setupViewHierarchy()
        setupConstraints()
    }
    
    func setupViewHierarchy() {
        addSubview(scrollView)
        scrollView.addSubview(nameLabel)
        scrollView.addSubview(ratingStackView)
        scrollView.addSubview(imageView)
        scrollView.addSubview(descriptionTitleLabel)
        scrollView.addSubview(descriptionLabel)
        [
            releaseDateTitleLabel, releaseDateLabel, genreTitleLabel,
            genreLabel, alternativeNamesTitleLabel, alternativeNamesLabel,
            publisherTitleLabel, publisherLabel
        ].forEach { scrollView.addSubview($0) }
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            nameLabel.topAnchor.constraint(
                equalTo: scrollView.topAnchor, constant: 16),
            nameLabel.leadingAnchor.constraint(
                equalTo: leadingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(
                equalTo: trailingAnchor, constant: -16),
            
            ratingStackView.topAnchor.constraint(
                equalTo: nameLabel.bottomAnchor, constant: 8),
            ratingStackView.leadingAnchor.constraint(
                equalTo: nameLabel.leadingAnchor),
            
            imageView.topAnchor.constraint(
                equalTo: ratingStackView.bottomAnchor, constant: 16),
            imageView.leadingAnchor.constraint(
                equalTo: nameLabel.leadingAnchor),
            imageView.trailingAnchor.constraint(
                equalTo: nameLabel.trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 200),
            
            descriptionTitleLabel.topAnchor.constraint(
                equalTo: imageView.bottomAnchor, constant: 16),
            descriptionTitleLabel.leadingAnchor.constraint(
                equalTo: nameLabel.leadingAnchor),
            descriptionTitleLabel.trailingAnchor.constraint(
                equalTo: nameLabel.trailingAnchor),
            
            descriptionLabel.topAnchor.constraint(
                equalTo: descriptionTitleLabel.bottomAnchor, constant: 8),
            descriptionLabel.leadingAnchor.constraint(
                equalTo: nameLabel.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(
                equalTo: nameLabel.trailingAnchor),
            
            releaseDateTitleLabel.topAnchor.constraint(
                equalTo: descriptionLabel.bottomAnchor, constant: 16),
            releaseDateTitleLabel.leadingAnchor.constraint(
                equalTo: nameLabel.leadingAnchor),
            releaseDateTitleLabel.trailingAnchor.constraint(
                equalTo: nameLabel.trailingAnchor),
            
            releaseDateLabel.topAnchor.constraint(
                equalTo: releaseDateTitleLabel.bottomAnchor, constant: 8),
            releaseDateLabel.leadingAnchor.constraint(
                equalTo: nameLabel.leadingAnchor),
            releaseDateLabel.trailingAnchor.constraint(
                equalTo: nameLabel.trailingAnchor)
        ])
        
        setupGenreSectionConstraints()
        setupAlternativeNamesSectionConstraints()
        setupPublisherSectionConstraints()
    }
    
    func setupGenreSectionConstraints() {
        NSLayoutConstraint.activate([
            genreTitleLabel.topAnchor.constraint(
                equalTo: releaseDateLabel.bottomAnchor, constant: 16),
            genreTitleLabel.leadingAnchor.constraint(
                equalTo: nameLabel.leadingAnchor),
            genreTitleLabel.trailingAnchor.constraint(
                equalTo: nameLabel.trailingAnchor),
            
            genreLabel.topAnchor.constraint(
                equalTo: genreTitleLabel.bottomAnchor, constant: 8),
            genreLabel.leadingAnchor.constraint(
                equalTo: nameLabel.leadingAnchor),
            genreLabel.trailingAnchor.constraint(
                equalTo: nameLabel.trailingAnchor)
        ])
    }
    
    func setupAlternativeNamesSectionConstraints() {
        NSLayoutConstraint.activate([
            alternativeNamesTitleLabel.topAnchor.constraint(
                equalTo: genreLabel.bottomAnchor, constant: 16),
            alternativeNamesTitleLabel.leadingAnchor.constraint(
                equalTo: nameLabel.leadingAnchor),
            alternativeNamesTitleLabel.trailingAnchor.constraint(
                equalTo: nameLabel.trailingAnchor),
            
            alternativeNamesLabel.topAnchor.constraint(
                equalTo: alternativeNamesTitleLabel.bottomAnchor, constant: 8),
            alternativeNamesLabel.leadingAnchor.constraint(
                equalTo: nameLabel.leadingAnchor),
            alternativeNamesLabel.trailingAnchor.constraint(
                equalTo: nameLabel.trailingAnchor)
        ])
    }
    
    func setupPublisherSectionConstraints() {
        NSLayoutConstraint.activate([
            publisherTitleLabel.topAnchor.constraint(
                equalTo: alternativeNamesLabel.bottomAnchor, constant: 16),
            publisherTitleLabel.leadingAnchor.constraint(
                equalTo: nameLabel.leadingAnchor),
            publisherTitleLabel.trailingAnchor.constraint(
                equalTo: nameLabel.trailingAnchor),
            
            publisherLabel.topAnchor.constraint(
                equalTo: publisherTitleLabel.bottomAnchor, constant: 8),
            publisherLabel.leadingAnchor.constraint(
                equalTo: nameLabel.leadingAnchor),
            publisherLabel.trailingAnchor.constraint(
                equalTo: nameLabel.trailingAnchor),
            publisherLabel.bottomAnchor.constraint(
                equalTo: scrollView.bottomAnchor, constant: -16)
        ])
    }
    
    func configure(with game: GameModel) {
        nameLabel.text = game.name
        ratingLabel.text = "\(game.rating ?? 0.0)"
        descriptionLabel.attributedText = game.description?
            .htmlAttributedString(fontSize: .preferredFont(forTextStyle: .headline))
        
        releaseDateLabel.text = game.released
        
        let genre = game.genres?.isEmpty ?? true ? "Unknown" : game.genres?.map { $0.name! }.joined(separator: ", ")
        genreLabel.text = genre
        
        let dataAlternativeNames = game.alternativeNames
        let alternativeNames = dataAlternativeNames?.isEmpty ?? true
        ? "No Available Alternative Names" : dataAlternativeNames?.joined(separator: ", ")
        alternativeNamesLabel.text = alternativeNames
        
        let dataPublisher = game.publishers
        let publisherNames = dataPublisher?.isEmpty ?? true ?
        "No Available Publisher" : dataPublisher?.map { $0.name ?? "" }.joined(separator: ", ")
        publisherLabel.text = publisherNames
        
        if let backgroundImage = game.backgroundImage,
           let url = URL(string: backgroundImage) {
            imageView.setImage(with: url)
        } else {
            imageView.image = UIImage(resource: .imagePlaceholder)
        }
    }
}
