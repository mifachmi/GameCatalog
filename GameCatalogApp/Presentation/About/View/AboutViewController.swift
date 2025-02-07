//
//  AboutViewController.swift
//  GameCatalogApp
//
//  Created by Fachmi Dimas Ardhana on 25/01/25.
//

import UIKit

class AboutViewController: UIViewController {
    
    private lazy var aboutView: AboutView = {
        let view = AboutView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
}

extension AboutViewController {
    func setupView() {
        view.backgroundColor = .white
        navigationItem.title = "About"
        navigationItem.largeTitleDisplayMode = .always
        view.addSubview(aboutView)
        
        NSLayoutConstraint.activate([
            aboutView.topAnchor.constraint(equalTo: view.topAnchor),
            aboutView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            aboutView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            aboutView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
