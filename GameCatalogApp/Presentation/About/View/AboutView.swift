//
//  AboutView.swift
//  GameCatalogApp
//
//  Created by Fachmi Dimas Ardhana on 25/01/25.
//

import UIKit

class AboutView: UIView {
    
    private lazy var roundedImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(resource: .foto)
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 75
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Fachmi Dimas Ardhana"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var jobLabel: UILabel = {
        let label = UILabel()
        label.text = "iOS Developer"
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var urlLabel: UILabel = {
        let label = UILabel()
        label.text = "https://mifachmi-portfolio.super.site"
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .link
        
        let underlineAttribute = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue]
        let underlineAttributedString = NSAttributedString(string: label.text!, attributes: underlineAttribute)
        label.attributedText = underlineAttributedString
        
        label.isUserInteractionEnabled = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [roundedImageView, nameLabel, jobLabel, urlLabel])
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setGesture()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension AboutView {
    func setupView() {
        backgroundColor = .white
        
        addSubview(mainStackView)
        
        NSLayoutConstraint.activate([
            mainStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            mainStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            mainStackView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -16),
            
            roundedImageView.widthAnchor.constraint(equalToConstant: 150),
            roundedImageView.heightAnchor.constraint(equalToConstant: 150)
        ])
    }
    
    func setGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(openUrl))
        urlLabel.addGestureRecognizer(tapGesture)
    }
    
    @objc func openUrl() {
        guard let url = URL(string: "https://mifachmi-portfolio.super.site") else { return }
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}
