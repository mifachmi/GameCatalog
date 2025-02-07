//
//  UIImageView+Ext.swift
//  GameCatalogApp
//
//  Created by Fachmi Dimas Ardhana on 26/01/25.
//

import UIKit
import Kingfisher

extension UIImageView {
    func setImage(with url: URL?, placeholder: UIImage? = nil) {
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.color = .gray
        activityIndicator.hidesWhenStopped = true
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(activityIndicator)
        
        // Center the activity indicator using Auto Layout constraints.
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
        
        activityIndicator.startAnimating()
        
        self.kf.setImage(with: url, placeholder: placeholder, options: nil, progressBlock: nil) { _ in
            DispatchQueue.main.async {
                activityIndicator.stopAnimating()
                activityIndicator.removeFromSuperview()
            }
        }
    }
}
